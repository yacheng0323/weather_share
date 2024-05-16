import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/show_privacy_dialog.dart';

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
      appBar: AppBar(
        title: Text(
          "帳戶",
          style: textgetter.titleLarge
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xff76B2F9),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("image/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  color: Colors.white),
              height: 250,
              margin: EdgeInsets.fromLTRB(34, 0, 34, 0),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "修改會員資料",
                        style: textgetter.bodyLarge
                            ?.copyWith(color: Color(0xff787878)),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        elevation: 0,
                        shape: RoundedRectangleBorder(),
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "修改密碼",
                        style: textgetter.bodyLarge
                            ?.copyWith(color: Color(0xff787878)),
                      ),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4))),
                          backgroundColor: Colors.white),
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {
                        ShowPrivacyDialog(context: context).call();
                      },
                      child: Text(
                        "隱私權政策",
                        style: textgetter.bodyLarge
                            ?.copyWith(color: Color(0xff787878)),
                      ),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4))),
                          backgroundColor: Colors.white),
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "聯絡我們",
                        style: textgetter.bodyLarge
                            ?.copyWith(color: Color(0xff787878)),
                      ),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4))),
                          backgroundColor: Colors.white),
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "註銷帳號",
                        style: textgetter.bodyLarge
                            ?.copyWith(color: Color(0xff787878)),
                      ),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4))),
                          backgroundColor: Colors.white),
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
