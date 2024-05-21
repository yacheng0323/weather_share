import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/show_snack.bar.dart';
import 'package:weather_share/feature/account/user_profile/domain/user_profile_view_model.dart';

@RoutePage()
class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nicknameController = TextEditingController();

  @override
  void dispose() {
    nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return ChangeNotifierProvider(
      create: (context) {
        UserProfileViewModel userProfileViewModel = UserProfileViewModel();

        // userProfileViewModel.getEmail();
        // emailController.value =
        //     TextEditingValue(text: userProfileViewModel.email ?? "");
        return userProfileViewModel;
      },
      builder: (context, child) {
        return Consumer<UserProfileViewModel>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                title: Text(
                  "修改會員資料",
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
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            child: IntrinsicHeight(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 90, 0, 0),
                                    width: 100,
                                    height: 100,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "image/avatar.png",
                                        ),
                                        Padding(padding: EdgeInsets.all(2)),
                                        Text(
                                          "選擇圖片",
                                          style: textgetter.bodyMedium
                                              ?.copyWith(
                                                  color: Color(0xffAAAAAA)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(45, 0, 45, 0),
                                    margin: const EdgeInsets.only(top: 50),
                                    // height: 40,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          child: Text("暱稱",
                                              style: textgetter.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white)),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                            child: TextFormField(
                                          controller: nicknameController,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(80)
                                          ],
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
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "暱稱為必填欄位喔";
                                            }
                                            return null;
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
                                              borderRadius:
                                                  BorderRadius.circular(4))),
                                      onPressed: () async {
                                        if (formKey.currentState?.validate() ==
                                            true) {
                                          await provider.update(
                                              nickName:
                                                  nicknameController.text);

                                          if (provider.isSuccess == true) {
                                            ShowSnackBarHelper.successSnackBar(
                                                    context: context)
                                                .showSnackbar("修改成功！");
                                            Navigator.pop(context);
                                          } else {
                                            ShowSnackBarHelper.errorSnackBar(
                                                    context: context)
                                                .showSnackbar("修改失敗！");
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
