import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_share/core/styles/textgetter.dart';

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

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "修改密碼",
          style: textgetter.titleLarge
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
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
              final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
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
                            padding: const EdgeInsets.fromLTRB(45, 0, 45, 0),
                            margin: const EdgeInsets.only(top: 50),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                  child: Text("舊密碼",
                                      style: textgetter.bodyMedium
                                          ?.copyWith(color: Colors.white)),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    child: TextFormField(
                                  controller: oldPasswordController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(80)
                                  ],
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorStyle: textgetter.bodyMedium
                                          ?.copyWith(color: Colors.red),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(8, 4, 4, 4),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      )),
                                  validator: (value) {
                                    bool isPasswordLengthQualified =
                                        (value?.length ?? 0) >= 8;

                                    RegExp numReg = RegExp(r".*[0-9].*");
                                    RegExp letterReg = RegExp(r".*[A-Za-z].*");
                                    bool isPasswordFormatQualified =
                                        letterReg.hasMatch(value ?? '') &&
                                            numReg.hasMatch(value ?? '');
                                    return !(isPasswordFormatQualified &&
                                            isPasswordLengthQualified)
                                        ? "至少8個字元\n*由英文與數字組成"
                                        : null;
                                  },
                                )),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 170),
                            padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff448BF7),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4))),
                              onPressed: () async {
                                // if (formKey.currentState?.validate() == true) {
                                //   await provider.update(
                                //       nickName: nicknameController.text);

                                //   if (provider.isSuccess == true) {
                                //     ShowSnackBarHelper.successSnackBar(
                                //             context: context)
                                //         .showSnackbar("修改成功！");
                                //     Navigator.pop(context);
                                //   } else {
                                //     ShowSnackBarHelper.errorSnackBar(
                                //             context: context)
                                //         .showSnackbar("修改失敗！");
                                //   }
                                // }
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
  }
}
