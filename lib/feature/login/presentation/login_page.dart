import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_share/core/router/app_router.gr.dart';
import 'package:weather_share/core/styles/textgetter.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();

  final TextEditingController loginTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    loginTextEditingController.dispose();
    passwordTextEditingController.dispose();
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
                              Text("帳號",
                                  style: textgetter.bodyMedium
                                      ?.copyWith(color: Colors.white)),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: TextFormField(
                                controller: loginTextEditingController,
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
                              Text("密碼",
                                  style: textgetter.bodyMedium
                                      ?.copyWith(color: Colors.white)),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: TextFormField(
                                controller: passwordTextEditingController,
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
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 4),
                          child: TextButton(
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            onPressed: () {},
                            child: Text(
                              "忘記密碼",
                              style: textgetter.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 64),
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
                              "登入",
                              style: textgetter.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff448BF7),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            onPressed: () {
                              AutoRouter.of(context)
                                  .push(const RegisterPageRoute());
                            },
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
