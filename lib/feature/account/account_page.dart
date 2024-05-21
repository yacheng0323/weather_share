import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_share/core/router/app_router.gr.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/show_privacy_dialog.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:weather_share/feature/account/account_view_model.dart';

@RoutePage()
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);
    final Divider divider = Divider(height: 0);

    return ChangeNotifierProvider(
      create: (context) {
        AccountViewModel accountViewModel = AccountViewModel();
        accountViewModel.init();
        return accountViewModel;
      },
      builder: (context, child) {
        return Consumer<AccountViewModel>(
          builder: (context, provider, child) {
            return Scaffold(
              body: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Color(0xff76B2F9)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            color: Colors.white,
                            width: 50,
                            height: 50,
                            child: Image.asset("image/avatar.png")),
                        const Padding(padding: EdgeInsets.all(8)),
                        Text(
                          provider.nickName ?? "",
                          style: textgetter.bodyLarge?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          provider.email ?? "",
                          style: textgetter.bodyMedium
                              ?.copyWith(color: Colors.white.withOpacity(0.6)),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person_2_outlined),
                        title: Text(
                          "修改會員資料",
                          style: textgetter.bodyLarge?.copyWith(
                            color: const Color(0xff787878),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          AutoRouter.of(context).push(const UserProfileRoute());
                        },
                      ),
                      divider,
                      ListTile(
                        leading: const Icon(Icons.lock_outline),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: Text(
                          "修改密碼",
                          style: textgetter.bodyLarge
                              ?.copyWith(color: const Color(0xff787878)),
                        ),
                      ),
                      divider,
                      ListTile(
                        leading: Icon(Symbols.unknown_document_sharp),
                        title: Text(
                          "隱私權政策",
                          style: textgetter.bodyLarge
                              ?.copyWith(color: const Color(0xff787878)),
                        ),
                        onTap: () {
                          ShowPrivacyDialog(context: context).call();
                        },
                      ),
                      divider,
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Symbols.contact_support_rounded),
                        title: Text("聯絡我們",
                            style: textgetter.bodyLarge
                                ?.copyWith(color: const Color(0xff787878))),
                      ),
                      divider,
                      ListTile(
                        leading: const Icon(Icons.person_off_rounded),
                        title: Text(
                          "註銷帳號",
                          style: textgetter.bodyLarge
                              ?.copyWith(color: const Color(0xff787878)),
                        ),
                        onTap: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text("確定要註銷帳號嗎"),
                                  content: const Text("是否確認前往填寫註銷帳號的表單?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("取消"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        final Uri url = Uri.parse(
                                            "https://forms.gle/313dSVb5tPEFeUDY8");

                                        if (!await launchUrl(url)) {
                                          throw Exception(
                                              'Could not launch $url');
                                        }
                                      },
                                      child: const Text("確定"),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                      divider,
                      ListTile(
                        leading: const Icon(Icons.logout_outlined),
                        title: Text(
                          "登出",
                          style: textgetter.bodyLarge
                              ?.copyWith(color: const Color(0xff787878)),
                        ),
                        onTap: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text("確定要登出嗎?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("取消"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await provider.signOut();
                                        // Navigator.pop(context);
                                        AutoRouter.of(context).replaceAll(
                                            [const LoginPageRoute()]);
                                      },
                                      child: const Text("確定"),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                      divider,
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
