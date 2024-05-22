import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/feature/publish/domain/publish_view_model.dart';

@RoutePage()
class PublishPage extends StatefulWidget {
  const PublishPage({super.key});

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController contentController = TextEditingController();
  // List<Weather> weatherlist = [
  //   Weather(icon: Symbols.sunny, text: "晴天"),
  //   Weather(icon: Symbols.rainy, text: "雨天"),
  //   Weather(icon: Symbols.cloud, text: "多雲")
  // ];
  // Weather? dropdownValue;
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  final List<String> items2 = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue2;

  @override
  void initState() {
    // dropdownValue = weatherlist.first;

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
                iconTheme: IconThemeData(color: Colors.white),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close_outlined,
                        size: 30,
                      ))
                ],
                title: Text(
                  "新增貼文",
                  style: textgetter.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                backgroundColor: Color(0xff76B2F9),
              ),
              body: SingleChildScrollView(
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
                              title: const Text("請選擇上傳方式"),
                              actions: [
                                CupertinoActionSheetAction(
                                  child: const Text('從圖片庫'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    provider.setImage(fromCamera: false);
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: const Text('拍照'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    provider.setImage(fromCamera: true);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
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
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                            "image/selectImage_placeholder.png"),
                                        Padding(padding: EdgeInsets.all(2)),
                                        Text(
                                          "新增圖片",
                                          style: textgetter.bodyMedium
                                              ?.copyWith(
                                                  color: Color(0xffAAAAAA)),
                                        )
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: contentController,
                        focusNode: focusNode,
                        minLines: 10,
                        maxLines: 300,
                        style: textgetter.bodyLarge
                            ?.copyWith(color: Color(0xff2E2E2E)),
                        decoration: InputDecoration(
                            hintText: "輸入文字...",
                            hintStyle: textgetter.bodyMedium
                                ?.copyWith(color: Color(0xff787878)),
                            contentPadding: EdgeInsets.fromLTRB(24, 24, 24, 24),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffD9D9D9), width: 1))),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("天氣"),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: items
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 140,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            ),
                            Text("國家"),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: items2
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValue2,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedValue2 = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 140,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            backgroundColor: const Color(0xff448EF7),
                          ),
                          onPressed: () async {
                            await provider.publish();
                          },
                          child: Text(
                            "發表",
                            style: textgetter.bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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

class Weather {
  final IconData icon;
  final String text;

  Weather({required this.icon, required this.text});
}
