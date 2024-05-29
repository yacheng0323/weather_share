import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_share/core/const.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/show_snack.bar.dart';
import 'package:weather_share/feature/register/domain/register_view_model.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode nickNameFocusNode = FocusNode();

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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return ChangeNotifierProvider(
      create: (context) {
        RegisterViewModel registerViewModel = RegisterViewModel();

        return registerViewModel;
      },
      builder: (context, child) {
        return Consumer<RegisterViewModel>(
          builder: (context, provider, child) {
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
                                    Container(
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
                                    EmailTextFormField(
                                        emailController: emailController,
                                        emailFocusNode: emailFocusNode,
                                        passwordFocusNode: passwordFocusNode),
                                    PasswordTextFormField(
                                        passwordController: passwordController,
                                        provider: provider,
                                        passwordFocusNode: passwordFocusNode,
                                        confirmPasswordFocusNode:
                                            confirmPasswordFocusNode),
                                    ConfirmPasswordTextFormField(
                                        confirmPasswordController:
                                            confirmPasswordController,
                                        passwordController: passwordController,
                                        provider: provider,
                                        confirmPasswordFocusNode:
                                            confirmPasswordFocusNode,
                                        nickNameFocusNode: nickNameFocusNode),
                                    NickNameTextFormField(
                                        nicknameController: nicknameController,
                                        nickNameFocusNode: nickNameFocusNode),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          45, 16, 45, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Transform.scale(
                                              scale: 1.2,
                                              child: Checkbox(
                                                  side: BorderSide.none,
                                                  activeColor:
                                                      const Color(0xff448EF7),
                                                  value: provider
                                                      .isPrivacyPolicyAccepted,
                                                  onChanged: (value) {
                                                    provider.toggleVisibility(
                                                        RegisterVisibilityType
                                                            .isPrivacyPolicyAccepted);
                                                  }),
                                            ),
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(4)),
                                          Expanded(
                                            child: RichText(
                                              maxLines: 5,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "I have read and agree to the Terms of Service &",
                                                      style: textgetter
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              color: Colors
                                                                  .white)),
                                                  TextSpan(
                                                    text: " Privacy Policy",
                                                    style: textgetter.bodyMedium
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            decorationColor:
                                                                Colors.white),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () async {
                                                            // ShowPrivacyDialog(
                                                            //         context:
                                                            //             context)
                                                            //     .call();
                                                            await provider.navToURL(
                                                                uri:
                                                                    privacyURL);
                                                          },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 60),
                                      padding: const EdgeInsets.fromLTRB(
                                          24, 0, 24, 0),
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff448BF7),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Back",
                                          style: textgetter.bodyMedium
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      padding: const EdgeInsets.fromLTRB(
                                          24, 0, 24, 50),
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff448BF7),
                                            disabledBackgroundColor:
                                                const Color(0xffA9D3FC),
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
                                                  if (provider
                                                          .isPrivacyPolicyAccepted ==
                                                      false) {
                                                    ShowSnackBarHelper
                                                            .errorSnackBar(
                                                                context:
                                                                    context)
                                                        .showSnackbar(
                                                            "Please confirm that you have checked the box to agree to the Privacy Policy and Terms of Service.");
                                                  } else {
                                                    await provider.register(
                                                        email: emailController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        nickName:
                                                            nicknameController
                                                                .text);

                                                    if (provider
                                                            .registeredResult
                                                            ?.isRegistered ==
                                                        true) {
                                                      if (!context.mounted) {
                                                        return;
                                                      }

                                                      ShowSnackBarHelper
                                                              .successSnackBar(
                                                                  context:
                                                                      context)
                                                          .showSnackbar(
                                                              "Registration successful!");
                                                      Navigator.pop(context);
                                                    } else {
                                                      if (!context.mounted) {
                                                        return;
                                                      }

                                                      ShowSnackBarHelper
                                                              .errorSnackBar(
                                                                  context:
                                                                      context)
                                                          .showSnackbar(provider
                                                                  .registeredResult
                                                                  ?.errorMessage ??
                                                              "");
                                                    }
                                                  }
                                                }
                                              },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Register",
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
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
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

//**信箱欄位 */
class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.emailController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  });
  final TextEditingController emailController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      margin: const EdgeInsets.only(top: 60),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text("*Email",
                style: textgetter.bodyMedium?.copyWith(color: Colors.white)),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: TextFormField(
              controller: emailController,
              focusNode: emailFocusNode,
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(passwordFocusNode);
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  errorStyle:
                      textgetter.bodyMedium?.copyWith(color: Colors.red)),
              validator: (value) {
                final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value ?? '');
                return !emailValid ? "Invalid email format" : null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

//**密碼欄位 */
class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField(
      {super.key,
      required this.passwordController,
      required this.provider,
      required this.passwordFocusNode,
      required this.confirmPasswordFocusNode});

  final TextEditingController passwordController;
  final RegisterViewModel provider;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text("*Password",
                style: textgetter.bodyMedium?.copyWith(color: Colors.white)),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
              child: TextFormField(
            controller: passwordController,
            obscureText: provider.passwordVisible!,
            focusNode: passwordFocusNode,
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  onPressed: () {
                    provider.toggleVisibility(
                        RegisterVisibilityType.passwordVisible);
                  },
                  icon: Icon(
                    provider.passwordVisible!
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: const Color(0xff2E2E2E),
                  ),
                ),
                contentPadding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                errorStyle: textgetter.bodyMedium?.copyWith(color: Colors.red),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                )),
            validator: (value) {
              bool isPasswordLengthQualified = (value?.length ?? 0) >= 8;

              RegExp numReg = RegExp(r".*[0-9].*");
              RegExp letterReg = RegExp(r".*[A-Za-z].*");
              bool isPasswordFormatQualified =
                  letterReg.hasMatch(value ?? '') &&
                      numReg.hasMatch(value ?? '');
              return !(isPasswordFormatQualified && isPasswordLengthQualified)
                  ? "At least 8 characters\nConsists of letters and numbers"
                  : null;
            },
          )),
        ],
      ),
    );
  }
}

//**確認密碼欄位 */
class ConfirmPasswordTextFormField extends StatelessWidget {
  const ConfirmPasswordTextFormField(
      {super.key,
      required this.confirmPasswordController,
      required this.passwordController,
      required this.provider,
      required this.confirmPasswordFocusNode,
      required this.nickNameFocusNode});
  final TextEditingController confirmPasswordController;
  final TextEditingController passwordController;
  final RegisterViewModel provider;
  final FocusNode confirmPasswordFocusNode;
  final FocusNode nickNameFocusNode;

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text("*Confirm\nPassword",
                style: textgetter.bodyMedium?.copyWith(color: Colors.white)),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
              child: TextFormField(
            controller: confirmPasswordController,
            obscureText: provider.confirmPasswordVisible!,
            focusNode: confirmPasswordFocusNode,
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(nickNameFocusNode);
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  onPressed: () {
                    provider.toggleVisibility(
                        RegisterVisibilityType.confirmPasswordVisible);
                  },
                  icon: Icon(
                    provider.confirmPasswordVisible!
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: const Color(0xff2E2E2E),
                  ),
                ),
                errorStyle: textgetter.bodyMedium?.copyWith(color: Colors.red),
                contentPadding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                )),
            validator: (value) {
              bool isSameAsPassword =
                  value?.isNotEmpty == true && value == passwordController.text;

              return !(isSameAsPassword) ? "Does not match the password" : null;
            },
          )),
        ],
      ),
    );
  }
}

//**暱稱欄位 */
class NickNameTextFormField extends StatelessWidget {
  const NickNameTextFormField(
      {super.key,
      required this.nicknameController,
      required this.nickNameFocusNode});

  final TextEditingController nicknameController;
  final FocusNode nickNameFocusNode;

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text("*Nickname",
                style: textgetter.bodyMedium?.copyWith(color: Colors.white)),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
              child: TextFormField(
            controller: nicknameController,
            focusNode: nickNameFocusNode,
            inputFormatters: [LengthLimitingTextInputFormatter(80)],
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                errorStyle: textgetter.bodyMedium?.copyWith(color: Colors.red),
                contentPadding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                )),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Nickname is a required field.";
              }
              return null;
            },
          )),
        ],
      ),
    );
  }
}
