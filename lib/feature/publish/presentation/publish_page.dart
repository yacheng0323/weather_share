import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/show_snack.bar.dart';
import 'package:weather_share/feature/publish/data/country_model.dart';
import 'package:weather_share/feature/publish/data/weather_model.dart';
import 'package:weather_share/feature/publish/domain/publish_view_model.dart';
import 'package:weather_share/feature/sharehome/domain/share_home_view_model.dart';

@RoutePage()
class PublishPage extends StatefulWidget {
  const PublishPage({super.key, required this.shareHomeViewModel});
  final ShareHomeViewModel shareHomeViewModel;

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return ChangeNotifierProvider(
      create: (context) {
        PublishViewModel publishViewModel = PublishViewModel();

        return publishViewModel;
      },
      builder: (context, child) {
        return Consumer<PublishViewModel>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                      onPressed: () {
                        showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  title: const Text(
                                      "Are you sure you want to discard editing this post?"),
                                  actions: [
                                    CupertinoActionSheetAction(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoActionSheetAction(
                                      child: const Text("Confirm"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ));
                      },
                      icon: const Icon(
                        Icons.close_outlined,
                        size: 30,
                      ))
                ],
                title: Text(
                  "Add Post",
                  style: textgetter.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                backgroundColor: const Color(0xff76B2F9),
              ),
              body: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //* 圖片
                        GestureDetector(
                          onTap: () async {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                title:
                                    const Text("Please select upload method"),
                                actions: [
                                  CupertinoActionSheetAction(
                                    child: const Text("From Photo Library"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      provider.setImage(fromCamera: false);
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: const Text("Take Photo"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      provider.setImage(fromCamera: true);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xffE6E6E6),
                                borderRadius: BorderRadius.circular(4)),
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: provider.imagePath != null
                                  ? Image.file(
                                      File(provider.imagePath!),
                                      fit: BoxFit.cover,
                                    )
                                  : SizedBox(
                                      height: 220,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              "image/selectImage_placeholder.png"),
                                          const Padding(
                                              padding: EdgeInsets.all(2)),
                                          Text(
                                            "Add Image",
                                            style: textgetter.bodyMedium
                                                ?.copyWith(
                                                    color: const Color(
                                                        0xffAAAAAA)),
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: contentController,
                          focusNode: focusNode,
                          minLines: 10,
                          maxLines: 300,
                          style: textgetter.bodyLarge
                              ?.copyWith(color: const Color(0xff2E2E2E)),
                          onChanged: (value) {
                            provider.onChangeContent(value: value);
                          },
                          decoration: InputDecoration(
                              hintText: "Enter text...",
                              hintStyle: textgetter.bodyMedium
                                  ?.copyWith(color: const Color(0xff787878)),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(24, 24, 24, 24),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffD9D9D9), width: 1))),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Weather",
                              style: textgetter.bodyMedium
                                  ?.copyWith(color: const Color(0xff2E2E2E)),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<WeatherModel>(
                                isExpanded: true,
                                hint: Text("Select",
                                    style: textgetter.bodyMedium?.copyWith(
                                        color: const Color(0xff2E2E2E))),
                                items: provider.weatherList
                                    .map(
                                      (item) => DropdownMenuItem<WeatherModel>(
                                        value: item,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(item.icon),
                                            const Padding(
                                                padding: EdgeInsets.all(2)),
                                            Text(
                                              item.text,
                                              style: textgetter.bodyMedium
                                                  ?.copyWith(
                                                      color: const Color(
                                                          0xff2E2E2E)),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                                value: provider.weather,
                                onChanged: (value) {
                                  provider.selectWeather(weather: value!);
                                },
                                buttonStyleData: ButtonStyleData(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(0xffD9D9D9),
                                      ),
                                      borderRadius: BorderRadius.circular(4)),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  height: 35,
                                  width: 120,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            ),
                            Text(
                              "Country",
                              style: textgetter.bodyMedium
                                  ?.copyWith(color: const Color(0xff2E2E2E)),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<CountryModel>(
                                isExpanded: true,
                                hint: Text('Select',
                                    style: textgetter.bodyMedium?.copyWith(
                                        color: const Color(0xff2E2E2E))),
                                items: provider.countryList
                                    .map((item) =>
                                        DropdownMenuItem<CountryModel>(
                                          value: item,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image.asset(item.icon),
                                              const Padding(
                                                  padding: EdgeInsets.all(2)),
                                              Text(
                                                item.text,
                                                style: textgetter.bodyMedium
                                                    ?.copyWith(
                                                        color: const Color(
                                                            0xff2E2E2E)),
                                              )
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                value: provider.country,
                                onChanged: (value) {
                                  provider.selectCountry(country: value!);
                                },
                                buttonStyleData: ButtonStyleData(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(0xffD9D9D9),
                                      ),
                                      borderRadius: BorderRadius.circular(4)),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  height: 35,
                                  width: 120,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              disabledBackgroundColor: const Color(0xffA9D3FC),
                              backgroundColor: const Color(0xff448EF7),
                            ),
                            onPressed: () async {
                              provider.validateForm();

                              if (provider.notValidateMessage!.isNotEmpty) {
                                ShowSnackBarHelper.errorSnackBar(
                                        context: context)
                                    .showSnackbar(
                                        provider.notValidateMessage ?? "");
                                return;
                              }

                              await provider.publish();

                              if (provider.publishResult?.isPublished == true) {
                                if (!context.mounted) return;

                                ShowSnackBarHelper.successSnackBar(
                                        context: context)
                                    .showSnackbar("Post added successfully!");
                                await widget.shareHomeViewModel.getAllArticle();

                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Publish",
                                  style: textgetter.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                                provider.loadingStatus
                                    ? Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 0, 0),
                                        child: const CupertinoActivityIndicator(
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
        );
      },
    );
  }
}
