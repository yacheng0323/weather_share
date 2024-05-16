import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/feature/account/account_page.dart';
import 'package:weather_share/feature/publish/presentation/publish_page.dart';
import 'package:weather_share/feature/sharehome/presentation/share_home_page.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [
          ShareHomePage(),
          PublishPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff62B4FF),
        unselectedItemColor: Colors.white,
        selectedLabelStyle: textgetter.bodyMedium,
        unselectedLabelStyle: textgetter.bodyMedium,
        backgroundColor: Color(0xff2F2F2F),
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(label: "首頁", icon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(
              label: "發表", icon: Icon(Symbols.edit_document)),
          BottomNavigationBarItem(
              label: "帳戶", icon: Icon(Symbols.group_rounded)),
        ],
      ),
    );
  }
}
