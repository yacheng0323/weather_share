import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/show_snack.bar.dart';
import 'package:weather_share/feature/account/change_password/domain/change_password_view_model.dart';

@RoutePage()
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return ChangeNotifierProvider(
      create: (context) {
        ChangePasswordViewModel changePasswordViewModel =
            ChangePasswordViewModel();

        return changePasswordViewModel;
      },
      builder: (context, child) {
        return Consumer<ChangePasswordViewModel>(
            builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: Text(
                "Change Password",
                style: textgetter.titleLarge?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
              backgroundColor: const Color(0xff76B2F9),
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
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(45, 0, 45, 0),
                                  margin: const EdgeInsets.only(top: 50),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        child: Text("Old Password",
                                            style: textgetter.bodyMedium
                                                ?.copyWith(
                                                    color: Colors.white)),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        controller: oldPasswordController,
                                        obscureText:
                                            provider.oldPasswordVisible!,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(80)
                                        ],
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                provider.oldPasswordVisible!
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: const Color(0xff2E2E2E),
                                              ),
                                              onPressed: () {
                                                provider.toggleVisibility(
                                                    ChangePasswordVisibility
                                                        .oldPasswordVisible);
                                              },
                                            ),
                                            errorStyle: textgetter.bodyMedium
                                                ?.copyWith(color: Colors.red),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    8, 4, 4, 4),
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            )),
                                        validator: (value) {
                                          bool isPasswordLengthQualified =
                                              (value?.length ?? 0) >= 8;

                                          RegExp numReg = RegExp(r".*[0-9].*");
                                          RegExp letterReg =
                                              RegExp(r".*[A-Za-z].*");
                                          bool isPasswordFormatQualified =
                                              letterReg.hasMatch(value ?? '') &&
                                                  numReg.hasMatch(value ?? '');
                                          return !(isPasswordFormatQualified &&
                                                  isPasswordLengthQualified)
                                              ? "At least 8 characters\nConsists of letters and numbers"
                                              : null;
                                        },
                                      )),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(45, 0, 45, 0),
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        child: Text("New Password",
                                            style: textgetter.bodyMedium
                                                ?.copyWith(
                                                    color: Colors.white)),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        controller: newPasswordController,
                                        obscureText:
                                            provider.newPasswordVisible!,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(80)
                                        ],
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                provider.confirmPasswordVisible!
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: const Color(0xff2E2E2E),
                                              ),
                                              onPressed: () {
                                                provider.toggleVisibility(
                                                    ChangePasswordVisibility
                                                        .newPasswordVisible);
                                              },
                                            ),
                                            errorStyle: textgetter.bodyMedium
                                                ?.copyWith(color: Colors.red),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    8, 4, 4, 4),
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            )),
                                        validator: (value) {
                                          bool isPasswordLengthQualified =
                                              (value?.length ?? 0) >= 8;

                                          RegExp numReg = RegExp(r".*[0-9].*");
                                          RegExp letterReg =
                                              RegExp(r".*[A-Za-z].*");
                                          bool isPasswordFormatQualified =
                                              letterReg.hasMatch(value ?? '') &&
                                                  numReg.hasMatch(value ?? '');
                                          return !(isPasswordFormatQualified &&
                                                  isPasswordLengthQualified)
                                              ? "At least 8 characters\nConsists of letters and numbers"
                                              : null;
                                        },
                                      )),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(45, 0, 45, 0),
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        child: Text("Confirm Password",
                                            style: textgetter.bodyMedium
                                                ?.copyWith(
                                                    color: Colors.white)),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        controller: confirmPasswordController,
                                        obscureText:
                                            provider.confirmPasswordVisible!,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(80)
                                        ],
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                provider.toggleVisibility(
                                                    ChangePasswordVisibility
                                                        .confirmPasswordVisible);
                                              },
                                              icon: Icon(
                                                provider.confirmPasswordVisible!
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: const Color(0xff2E2E2E),
                                              ),
                                            ),
                                            errorStyle: textgetter.bodyMedium
                                                ?.copyWith(color: Colors.red),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    8, 4, 4, 4),
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            )),
                                        validator: (value) {
                                          bool isSameAsPassword =
                                              value?.isNotEmpty == true &&
                                                  value ==
                                                      newPasswordController
                                                          .text;

                                          return !(isSameAsPassword)
                                              ? "Does not match the password"
                                              : null;
                                        },
                                      )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 120),
                                  padding:
                                      const EdgeInsets.fromLTRB(45, 0, 45, 0),
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff448BF7),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4))),
                                    onPressed: () async {
                                      if (formKey.currentState?.validate() ==
                                          true) {
                                        await provider.validatePassword(
                                            password:
                                                oldPasswordController.text);

                                        if (provider.validatePasswordResult
                                                ?.isValidate ==
                                            true) {
                                          await provider.changePassword(
                                              newPassword:
                                                  newPasswordController.text);

                                          if (provider.changePasswordResult
                                                  ?.isChanged ==
                                              true) {
                                            if (!context.mounted) return;

                                            ShowSnackBarHelper.successSnackBar(
                                                    context: context)
                                                .showSnackbar(
                                                    "Password changed successfully");
                                            Navigator.pop(context);
                                          } else {
                                            if (!context.mounted) return;

                                            ShowSnackBarHelper.errorSnackBar(
                                                    context: context)
                                                .showSnackbar(provider
                                                        .changePasswordResult
                                                        ?.errorMessage ??
                                                    "");
                                          }
                                        } else {
                                          if (!context.mounted) return;

                                          ShowSnackBarHelper.errorSnackBar(
                                                  context: context)
                                              .showSnackbar(provider
                                                      .validatePasswordResult
                                                      ?.errorMessage ??
                                                  "");
                                        }
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Submit",
                                          style: textgetter.bodyMedium
                                              ?.copyWith(color: Colors.white),
                                        ),
                                        provider.loadingStatus
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
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
          );
        });
      },
    );
  }
}
