import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
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
        LoginViewModel loginViewModel = LoginViewModel();

        // loginViewModel.checkUserAuthState();
        return loginViewModel;
      },
      builder: (context, child) {
        return Consumer<LoginViewModel>(
          builder: (context, provider, child) {
            // if (provider.user != null) {
            //   AutoRouter.of(context).replace(const ShareHomePageRoute());
            // }
            return Scaffold(
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                toolbarHeight: 0,
              ),
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Stack(
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
                                    GestureDetector(
                                      onLongPress: () {
                                        if (kDebugMode) {
                                          log("debug mode");
                                          // emailController.value =
                                          //     const TextEditingValue(
                                          //         text: "ppp222@gmail.com");

                                          // passwordController.value =
                                          //     const TextEditingValue(
                                          //         text: "pp111111");
                                          emailController.value =
                                              const TextEditingValue(
                                                  text: "ivan.lee@itstar.tw");

                                          passwordController.value =
                                              const TextEditingValue(
                                                  text: "aa111111");
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 40, 0, 0),
                                        width: 150,
                                        height: 150,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(75),
                                            border: Border.all(
                                                color: const Color(0xff62B4ff),
                                                width: 4)),
                                        child: ClipRRect(
                                            child: Image.asset(
                                          "image/how's_the_weather.png",
                                        )),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          45, 0, 45, 0),
                                      margin: const EdgeInsets.only(top: 60),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            child: Text("Email",
                                                style: textgetter.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.white)),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Expanded(
                                              child: TextFormField(
                                            controller: emailController,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  100)
                                            ],
                                            focusNode: loginFocusNode,
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      passwordFocusNode);
                                            },
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 4, 4, 4),
                                                errorStyle: textgetter
                                                    .bodyMedium
                                                    ?.copyWith(
                                                  color: Colors.red,
                                                ),
                                                border:
                                                    const OutlineInputBorder(
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
                                      padding: const EdgeInsets.fromLTRB(
                                          45, 0, 45, 0),
                                      margin: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            child: Text("密碼",
                                                style: textgetter.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.white)),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Expanded(
                                              child: TextFormField(
                                            controller: passwordController,
                                            obscureText:
                                                provider.passwordVisible!,
                                            focusNode: passwordFocusNode,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  50)
                                            ],
                                            textInputAction:
                                                TextInputAction.done,
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    provider.passwordVisible!
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color:
                                                        const Color(0xff2E2E2E),
                                                  ),
                                                  onPressed: () {
                                                    provider
                                                        .modifyPasswordVisible();
                                                  },
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 4, 4, 4),
                                                errorStyle: textgetter
                                                    .bodyMedium
                                                    ?.copyWith(
                                                  color: Colors.red,
                                                ),
                                                border:
                                                    const OutlineInputBorder(
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
                                                      numReg.hasMatch(
                                                          value ?? '');
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
                                      padding: const EdgeInsets.fromLTRB(
                                          45, 0, 45, 0),
                                      alignment: Alignment.centerRight,
                                      margin: const EdgeInsets.only(top: 4),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero),
                                        onPressed: () {
                                          AutoRouter.of(context).push(
                                              const ForgotPasswordPageRoute());
                                        },
                                        child: Text(
                                          "忘記密碼",
                                          style: textgetter.bodyMedium
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 64),
                                      padding: const EdgeInsets.fromLTRB(
                                          45, 0, 45, 0),
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            disabledBackgroundColor:
                                                const Color(0xffA9D3FC),
                                            backgroundColor:
                                                const Color(0xff448BF7),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4))),
                                        onPressed: provider.loadingStatus
                                            ? null
                                            : () async {
                                                if (formKey.currentState
                                                        ?.validate() ==
                                                    true) {
                                                  await provider.signIn(
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text);

                                                  if (provider.signInResult
                                                          ?.isSignIn ==
                                                      true) {
                                                    if (!context.mounted) {
                                                      return;
                                                    }
                                                    ShowSnackBarHelper
                                                            .successSnackBar(
                                                                context:
                                                                    context)
                                                        .showSnackbar("登入成功!");
                                                    AutoRouter.of(context).replace(
                                                        const ShareHomePageRoute());
                                                  } else {
                                                    if (!context.mounted) {
                                                      return;
                                                    }

                                                    ShowSnackBarHelper
                                                            .errorSnackBar(
                                                                context:
                                                                    context)
                                                        .showSnackbar(provider
                                                            .signInResult!
                                                            .errorMessage!);
                                                  }
                                                }
                                              },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "登入",
                                              style: textgetter.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                            provider.loadingStatus
                                                ? Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 0, 0, 0),
                                                    child:
                                                        const CupertinoActivityIndicator(
                                                      color: Colors.white,
                                                    ))
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      padding: const EdgeInsets.fromLTRB(
                                          45, 0, 45, 0),
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff448BF7),
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
              ),
            );
          },
        );
      },
    );
  }
}
