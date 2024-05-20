import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_share/core/router/app_router.gr.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/show_snack.bar.dart';
import 'package:weather_share/feature/login/domain/login_view_model.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final loginFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    loginFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return ChangeNotifierProvider(
      create: (context) {
        final loginViewModel = LoginViewModel();

        loginViewModel.checkUserAuthState();
        return loginViewModel;
      },
      builder: (context, child) {
        return Consumer<LoginViewModel>(
          builder: (context, provider, child) {
            if (provider.user != null) {
              AutoRouter.of(context).replace(const ShareHomePageRoute());
            }
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
                      final keyboardHeight =
                          MediaQuery.of(context).viewInsets.bottom;
                      return SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: keyboardHeight),
                        child: Form(
                          key: formKey,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
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
                                            color: Color(0xff62B4ff),
                                            width: 4)),
                                    child: ClipRRect(
                                        child: Image.asset(
                                      "image/how's_the_weather.png",
                                    )),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                                    margin: EdgeInsets.only(top: 60),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("帳號",
                                            style: textgetter.bodyMedium
                                                ?.copyWith(
                                                    color: Colors.white)),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                            child: TextFormField(
                                          controller: loginController,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                100)
                                          ],
                                          focusNode: loginFocusNode,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      8, 4, 4, 4),
                                              errorStyle: textgetter.bodyMedium
                                                  ?.copyWith(
                                                color: Colors.red,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              )),
                                          validator: (value) {
                                            final bool emailValid = RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(value ?? '');
                                            return !emailValid
                                                ? "信箱格式錯誤"
                                                : null;
                                          },
                                        )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                                    margin: EdgeInsets.only(top: 8),
                                    // height: 40,
                                    child: Row(
                                      children: [
                                        Text("密碼",
                                            style: textgetter.bodyMedium
                                                ?.copyWith(
                                                    color: Colors.white)),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                            child: TextFormField(
                                          controller: passwordController,
                                          obscureText:
                                              provider.passwordVisible!,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(50)
                                          ],
                                          onFieldSubmitted: (value) {
                                            FocusScope.of(context).requestFocus(
                                                passwordFocusNode);
                                          },
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  provider.passwordVisible!
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Color(0xff2E2E2E),
                                                ),
                                                onPressed: () {
                                                  provider
                                                      .modifyPasswordVisible();
                                                },
                                              ),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      8, 4, 4, 4),
                                              errorStyle: textgetter.bodyMedium
                                                  ?.copyWith(
                                                color: Colors.red,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              )),
                                          validator: (value) {
                                            bool isPasswordLengthQualified =
                                                (value?.length ?? 0) >= 8;

                                            RegExp numReg =
                                                RegExp(r".*[0-9].*");
                                            RegExp letterReg =
                                                RegExp(r".*[A-Za-z].*");
                                            bool isPasswordFormatQualified =
                                                letterReg.hasMatch(
                                                        value ?? '') &&
                                                    numReg
                                                        .hasMatch(value ?? '');
                                            return !(isPasswordFormatQualified &&
                                                    isPasswordLengthQualified)
                                                ? "至少8個字元\n由英文與數字組成"
                                                : null;
                                          },
                                        )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 4),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero),
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
                                              borderRadius:
                                                  BorderRadius.circular(4))),
                                      onPressed: () async {
                                        if (formKey.currentState?.validate() ==
                                            true) {
                                          await provider.signIn(
                                              email: loginController.text,
                                              password:
                                                  passwordController.text);

                                          if (provider.signInResult?.isSignIn ==
                                              true) {
                                            ShowSnackBarHelper.successSnackBar(
                                                    context: context)
                                                .showSnackbar("登入成功!");
                                            AutoRouter.of(context).replace(
                                                const ShareHomePageRoute());
                                          } else {
                                            ShowSnackBarHelper.errorSnackBar(
                                                    context: context)
                                                .showSnackbar(provider
                                                    .signInResult!
                                                    .errorMessage!);
                                          }
                                        }
                                      },
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
                                              borderRadius:
                                                  BorderRadius.circular(4))),
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
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
