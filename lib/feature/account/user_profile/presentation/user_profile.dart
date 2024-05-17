import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_share/core/styles/textgetter.dart';

@RoutePage()
class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  @override
  void initState() {
    emailController.text = "?????";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "修改會員資料",
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
              color: Color(0xffE6E6E6),
              image: DecorationImage(
                image: AssetImage("image/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: keyboardHeight),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "image/avatar.png",
                              ),
                              Padding(padding: EdgeInsets.all(2)),
                              Text(
                                "選擇圖片",
                                style: textgetter.bodyMedium
                                    ?.copyWith(color: Color(0xffAAAAAA)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                          margin: EdgeInsets.only(top: 100),
                          height: 40,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 50,
                                child: Text("Email",
                                    style: textgetter.bodyMedium
                                        ?.copyWith(color: Colors.white)),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: TextFormField(
                                enabled: false,
                                controller: emailController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(8, 4, 4, 4),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                          margin: EdgeInsets.only(top: 8),
                          height: 40,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 50,
                                child: Text("暱稱",
                                    style: textgetter.bodyMedium
                                        ?.copyWith(color: Colors.white)),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: TextFormField(
                                controller: nicknameController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(8, 4, 4, 4),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 100),
                          padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff448BF7),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            onPressed: () {
                              // AutoRouter.of(context)
                              //     .replace(const HomePageRoute());
                            },
                            child: Text(
                              "送出",
                              style: textgetter.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
