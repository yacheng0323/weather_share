import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_share/core/const.dart';
import 'package:weather_share/core/router/app_router.gr.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/show_privacy_dialog.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:weather_share/feature/account/account_view_model.dart';
import 'package:weather_share/feature/sharehome/domain/share_home_view_model.dart';

@RoutePage()
class AccountPage extends StatefulWidget {
  const AccountPage({super.key, required this.shareHomeViewModel});
  final ShareHomeViewModel shareHomeViewModel;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

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
                        provider.avatar != null
                            ? ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: provider.avatar!,
                                  width: 70,
                                  height: 70,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    color: Colors.white),
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "image/avatar.png",
                                )),
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
                          "Edit Member Information",
                          style: textgetter.bodyLarge?.copyWith(
                            color: const Color(0xff787878),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          AutoRouter.of(context).push(const UserProfileRoute());
                        },
                      ),
                      const Divider(height: 0),
                      ListTile(
                        leading: const Icon(Icons.lock_outline),
                        onTap: () {
                          Navigator.pop(context);
                          AutoRouter.of(context)
                              .push(const ChangePasswordPageRoute());
                        },
                        title: Text(
                          "Change Password",
                          style: textgetter.bodyLarge
                              ?.copyWith(color: const Color(0xff787878)),
                        ),
                      ),
                      const Divider(height: 0),
                      ListTile(
                        leading: const Icon(Symbols.post),
                        title: Text(
                          "Manage Posts",
                          style: textgetter.bodyLarge
                              ?.copyWith(color: const Color(0xff787878)),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          AutoRouter.of(context).push(ManageArticleRoute(
                              shareHomeViewModel: widget.shareHomeViewModel));
                        },
                      ),
                      const Divider(height: 0),
                      ListTile(
                        leading: const Icon(Symbols.unknown_document_sharp),
                        title: Text(
                          "Privacy Policy",
                          style: textgetter.bodyLarge
                              ?.copyWith(color: const Color(0xff787878)),
                        ),
                        onTap: () async {
                          Navigator.pop(context);

                          await provider.navToURL(uri: privacyURL);
                        },
                      ),
                      const Divider(height: 0),
                      ListTile(
                        onTap: () async {
                          Navigator.pop(context);

                          await provider.navToURL(uri: contactUsURL);
                        },
                        leading: const Icon(Symbols.contact_support_rounded),
                        title: Text("Contact Us",
                            style: textgetter.bodyLarge
                                ?.copyWith(color: const Color(0xff787878))),
                      ),
                      const Divider(height: 0),
                      ListTile(
                        leading: const Icon(Icons.person_off_rounded),
                        title: Text(
                          "Delete Account",
                          style: textgetter.bodyLarge
                              ?.copyWith(color: const Color(0xff787878)),
                        ),
                        onTap: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text(
                                      "Are you sure you want to delete your account?"),
                                  content: const Text(
                                      "Do you confirm going to the delete account form?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await provider.navToURL(
                                            uri: deleteAccountURL);
                                      },
                                      child: const Text("Confirm"),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                      const Divider(height: 0),
                      ListTile(
                        leading: const Icon(Icons.logout_outlined),
                        title: Text(
                          "Log Out",
                          style: textgetter.bodyLarge
                              ?.copyWith(color: const Color(0xff787878)),
                        ),
                        onTap: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text(
                                      "Are you sure you want to log out?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await provider.signOut();

                                        if (!context.mounted) return;
                                        AutoRouter.of(context).replaceAll(
                                            [const LoginPageRoute()]);
                                      },
                                      child: const Text("Confirm"),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                      const Divider(height: 0),
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
