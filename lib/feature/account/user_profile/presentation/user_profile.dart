import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        userProfileViewModel.init();

        return userProfileViewModel;
      },
      builder: (context, child) {
        return Consumer<UserProfileViewModel>(
          builder: (context, provider, child) {
            nicknameController.text = provider.nickName ?? "";
            return Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                title: Text(
                  "Edit Member Information",
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
                                  GestureDetector(
                                      onTap: () async {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) =>
                                              CupertinoActionSheet(
                                            title: const Text(
                                                "Please select upload method"),
                                            actions: [
                                              CupertinoActionSheetAction(
                                                child: const Text(
                                                    'From Photo Library'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  provider.setImage(
                                                      fromCamera: false);
                                                },
                                              ),
                                              CupertinoActionSheetAction(
                                                child: const Text('Take Photo'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  provider.setImage(
                                                      fromCamera: true);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 90, 0, 0),
                                        width: 130,
                                        height: 130,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: provider.imagePath != null
                                            ? provider
                                                    .isUrl(provider.imagePath!)
                                                ? ClipOval(
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          provider.imagePath!,
                                                      width: 130,
                                                      height: 130,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : ClipOval(
                                                    child: Image.file(
                                                      File(provider.imagePath!),
                                                      width: 130,
                                                      height: 130,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      "image/avatar.png"),
                                                  const Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    "Select Image",
                                                    style: textgetter.bodyMedium
                                                        ?.copyWith(
                                                            color: const Color(
                                                                0xffAAAAAA)),
                                                  ),
                                                ],
                                              ),
                                      )),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(45, 0, 45, 0),
                                    margin: const EdgeInsets.only(top: 50),
                                    // height: 40,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 70,
                                          child: Text("Nickname",
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
                                                  const EdgeInsets.fromLTRB(
                                                      8, 4, 4, 4),
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              )),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Nickname is a required field.";
                                            }
                                            return null;
                                          },
                                        )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 170),
                                    padding:
                                        const EdgeInsets.fromLTRB(45, 0, 45, 0),
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
                                                await provider.update(
                                                    nickName: nicknameController
                                                        .text);

                                                if (provider.isSuccess ==
                                                    true) {
                                                  if (!context.mounted) return;
                                                  ShowSnackBarHelper
                                                          .successSnackBar(
                                                              context: context)
                                                      .showSnackbar(
                                                          "Modification Successful!");
                                                  Navigator.pop(context);
                                                } else {
                                                  if (!context.mounted) return;

                                                  ShowSnackBarHelper
                                                          .errorSnackBar(
                                                              context: context)
                                                      .showSnackbar(
                                                          "Modification Failed!");
                                                }
                                              }
                                            },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Confirm",
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
                                                  ))
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
          },
        );
      },
    );
  }
}
