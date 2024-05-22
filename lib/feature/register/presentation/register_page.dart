import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/show_privacy_dialog.dart';
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
                                  _emailTextFormField(textgetter),
                                  _passwordTextFormField(textgetter, provider),
                                  _confirmPasswordTextFormField(
                                      textgetter, provider),
                                  _nickNameTextFormField(textgetter),
                                  Container(
                                    padding: const EdgeInsets.only(top: 16),
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
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: "已閱讀服務條款及",
                                                  style: textgetter.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.white)),
                                              TextSpan(
                                                text: "隱私權政策",
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
                                                      ..onTap = () {
                                                        ShowPrivacyDialog(
                                                                context:
                                                                    context)
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
                                    margin: const EdgeInsets.only(top: 60),
                                    padding:
                                        const EdgeInsets.fromLTRB(24, 0, 24, 0),
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff448BF7),
                                          disabledBackgroundColor:
                                              Color(0xffA9D3FC),
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
                                                              context: context)
                                                      .showSnackbar(
                                                          "請確認您已勾選同意隱私權政策及服務條款。");
                                                } else {
                                                  await provider.register(
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                      nickName:
                                                          nicknameController
                                                              .text);

                                                  if (provider.registeredResult
                                                          ?.isRegistered ==
                                                      true) {
                                                    ShowSnackBarHelper
                                                            .successSnackBar(
                                                                context:
                                                                    context)
                                                        .showSnackbar("註冊成功！");
                                                    Navigator.pop(context);
                                                  } else {
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
                                            "註冊",
                                            style: textgetter.bodyMedium
                                                ?.copyWith(color: Colors.white),
                                          ),
                                          provider.loadingStatus
                                              ? Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      8, 0, 0, 0),
                                                  child:
                                                      CupertinoActivityIndicator(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : SizedBox.shrink(),
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
            );
          },
        );
      },
    );
  }

  //* Email 欄位
  Widget _emailTextFormField(TextGetter textgetter) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      margin: const EdgeInsets.only(top: 60),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text("*Email",
                style: textgetter.bodyMedium?.copyWith(color: Colors.white)),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: TextFormField(
              controller: emailController,
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
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
                return !emailValid ? "信箱格式錯誤" : null;
              },
            ),
          ),
        ],
      ),
    );
  }

  //* 密碼 欄位

  Widget _passwordTextFormField(
      TextGetter textgetter, RegisterViewModel provider) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text("*密碼",
                style: textgetter.bodyMedium?.copyWith(color: Colors.white)),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
              child: TextFormField(
            controller: passwordController,
            obscureText: provider.passwordVisible!,
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
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
                  ? "至少8個字元\n由英文與數字組成"
                  : null;
            },
          )),
        ],
      ),
    );
  }

  //* 確認密碼 欄位
  Widget _confirmPasswordTextFormField(
    TextGetter textgetter,
    RegisterViewModel provider,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text("*再次確認\n密碼",
                style: textgetter.bodyMedium?.copyWith(color: Colors.white)),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
              child: TextFormField(
            controller: confirmPasswordController,
            obscureText: provider.confirmPasswordVisible!,
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
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
                    color: Color(0xff2E2E2E),
                  ),
                ),
                errorStyle: textgetter.bodyMedium?.copyWith(color: Colors.red),
                contentPadding: EdgeInsets.fromLTRB(8, 4, 4, 4),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                )),
            validator: (value) {
              bool isSameAsPassword =
                  value?.isNotEmpty == true && value == passwordController.text;

              return !(isSameAsPassword) ? "與密碼不相符" : null;
            },
          )),
        ],
      ),
    );
  }

  //* 暱稱 欄位
  Widget _nickNameTextFormField(
    TextGetter textgetter,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text("*暱稱",
                style: textgetter.bodyMedium?.copyWith(color: Colors.white)),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
              child: TextFormField(
            controller: nicknameController,
            inputFormatters: [LengthLimitingTextInputFormatter(80)],
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
                return "暱稱為必填欄位喔";
              }
              return null;
            },
          )),
        ],
      ),
    );
  }
}
