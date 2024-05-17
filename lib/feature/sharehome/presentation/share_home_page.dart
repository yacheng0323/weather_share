import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather_share/core/router/app_router.gr.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/feature/account/account_page.dart';

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
      drawer: Drawer(
        child: AccountPage(
            // appBloc: bloc,
            ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "分享首頁",
          style: textgetter.titleLarge
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xff76B2F9),
        actions: [
          IconButton(
              onPressed: () {
                AutoRouter.of(context).push(const PublishPageRoute());
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
