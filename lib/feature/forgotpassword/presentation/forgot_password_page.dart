import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/show_snack.bar.dart';
import 'package:weather_share/feature/forgotpassword/domain/forgot_password_view_model.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return ChangeNotifierProvider(
      create: (context) {
        ForgotPasswordViewModel forgotPasswordViewModel =
            ForgotPasswordViewModel();

        return forgotPasswordViewModel;
      },
      builder: (context, child) {
        return Consumer<ForgotPasswordViewModel>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                toolbarHeight: 0,
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
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    width: 150,
                                    height: 150,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(75),
                                        border: Border.all(
                                            color: const Color(0xff62B4ff),
                                            width: 4)),
                                    child: ClipRRect(
                                        child: Image.asset(
                                      "image/how's_the_weather.png",
                                    )),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(24, 0, 24, 0),
                                    margin: const EdgeInsets.only(top: 100),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 50,
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
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                100)
                                          ],
                                          controller: emailController,
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              errorStyle: textgetter.bodyMedium
                                                  ?.copyWith(color: Colors.red),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      8, 4, 4, 4),
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
                                    margin: const EdgeInsets.only(top: 100),
                                    padding:
                                        const EdgeInsets.fromLTRB(45, 0, 45, 0),
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
                                          await provider.resetPassword(
                                              email: emailController.text);

                                          if (provider.forgotPasswordResult
                                                  ?.isSuccess ==
                                              true) {
                                            ShowSnackBarHelper.successSnackBar(
                                                    context: context)
                                                .showSnackbar(
                                                    "已向您輸入的電子郵件地址發送驗證信件");
                                            Navigator.pop(context);
                                          } else {
                                            ShowSnackBarHelper.errorSnackBar(
                                                    context: context)
                                                .showSnackbar(provider
                                                        .forgotPasswordResult
                                                        ?.errorMessage ??
                                                    "");
                                          }
                                        }
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
