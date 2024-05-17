import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_share/core/router/app_router.gr.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/show_privacy_dialog.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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

    return Scaffold(
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    color: Colors.white,
                    width: 50,
                    height: 50,
                    child: Image.asset("image/avatar.png")),
                Padding(padding: EdgeInsets.all(8)),
                Text(
                  "暱稱",
                  style: textgetter.bodyLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                Text(
                  "email",
                  style: textgetter.bodyMedium
                      ?.copyWith(color: Colors.white.withOpacity(0.6)),
                )
              ],
            ),
            decoration: BoxDecoration(color: Color(0xff76B2F9)),
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.person_2_outlined),
                  title: Text(
                    "修改會員資料",
                    style: textgetter.bodyLarge?.copyWith(
                      color: Color(0xff787878),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    AutoRouter.of(context).push(const UserProfileRoute());
                  },
                ),
                Divider(
                  height: 0,
                ),
                ListTile(
                  leading: Icon(Icons.lock_outline),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: Text(
                    "修改密碼",
                    style: textgetter.bodyLarge
                        ?.copyWith(color: Color(0xff787878)),
                  ),
                ),
                Divider(
                  height: 0,
                ),
                ListTile(
                  leading: Icon(Symbols.unknown_document_sharp),
                  title: Text(
                    "隱私權政策",
                    style: textgetter.bodyLarge
                        ?.copyWith(color: Color(0xff787878)),
                  ),
                  onTap: () {
                    ShowPrivacyDialog(context: context).call();
                  },
                ),
                Divider(
                  height: 0,
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Symbols.contact_support_rounded),
                  title: Text("聯絡我們",
                      style: textgetter.bodyLarge
                          ?.copyWith(color: Color(0xff787878))),
                ),
                Divider(
                  height: 0,
                ),
                ListTile(
                  leading: Icon(Icons.person_off_rounded),
                  title: Text(
                    "註銷帳號",
                    style: textgetter.bodyLarge
                        ?.copyWith(color: Color(0xff787878)),
                  ),
                  onTap: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text("確定要註銷帳號嗎"),
                            content: Text("是否確認前往填寫註銷帳號的表單?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("取消"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  final Uri url = Uri.parse(
                                      "https://forms.gle/313dSVb5tPEFeUDY8");

                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                                child: Text("確定"),
                              ),
                            ],
                          );
                        });
                  },
                ),
                Divider(
                  height: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
