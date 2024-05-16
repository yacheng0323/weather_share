import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather_share/core/styles/textgetter.dart';

@RoutePage()
class ShareHomePage extends StatefulWidget {
  const ShareHomePage({super.key});

  @override
  State<ShareHomePage> createState() => _ShareHomePageState();
}

class _ShareHomePageState extends State<ShareHomePage> {
  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "分享首頁",
          style: textgetter.titleLarge
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xff76B2F9),
      ),
    );
  }
}
