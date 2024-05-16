import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/widgets/styled_text.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/show_privacy_dialog.dart';
import 'package:weather_share/feature/register/presentation/privacy.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _checkboxSelected = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController idcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nicknameController.dispose();
    idcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 0,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
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
                          width: 150,
                          height: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(75),
                              border: Border.all(
                                  color: Color(0xff62B4ff), width: 4)),
                          child: ClipRRect(
                              child: Image.asset(
                            "image/how's_the_weather.png",
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                          margin: EdgeInsets.only(top: 60),
                          height: 40,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 85,
                                child: Text("Email",
                                    style: textgetter.bodyMedium
                                        ?.copyWith(color: Colors.white)),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: TextFormField(
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
                                width: 85,
                                child: Text("密碼",
                                    style: textgetter.bodyMedium
                                        ?.copyWith(color: Colors.white)),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: TextFormField(
                                controller: passwordController,
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
                                width: 85,
                                child: Text("再次確認密碼",
                                    style: textgetter.bodyMedium
                                        ?.copyWith(color: Colors.white)),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: TextFormField(
                                controller: confirmPasswordController,
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
                                width: 85,
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
                          padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                          margin: EdgeInsets.only(top: 8),
                          height: 40,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 85,
                                child: Text("ID",
                                    style: textgetter.bodyMedium
                                        ?.copyWith(color: Colors.white)),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: TextFormField(
                                controller: idcontroller,
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
                          padding: EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Transform.scale(
                                  scale: 1.2,
                                  child: Checkbox(
                                      side: BorderSide.none,
                                      activeColor: Color(0xff448EF7),
                                      value: _checkboxSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkboxSelected =
                                              !_checkboxSelected;
                                        });
                                      }),
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(4)),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "已閱讀服務條款及",
                                        style: textgetter.bodyMedium
                                            ?.copyWith(color: Colors.white)),
                                    TextSpan(
                                      text: "隱私政策",
                                      style: textgetter.bodyMedium?.copyWith(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          ShowPrivacyDialog(context: context)
                                              .call();
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff448BF7),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            onPressed: () {},
                            child: Text(
                              "註冊",
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
