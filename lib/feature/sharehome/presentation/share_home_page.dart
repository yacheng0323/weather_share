import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    final Padding gap = Padding(padding: EdgeInsets.all(4));

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
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffE6E6E6)),
                      child: Image.asset(
                        "image/avatar.png",
                        width: 16,
                        height: 16,
                      ),
                    ),
                    gap,
                    Text(
                      "Wsx#edc2023",
                      style: textgetter.bodyMedium
                          ?.copyWith(color: Color(0xff2E2E2E)),
                    ),
                  ],
                ),
                gap,
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.orange,
                  ),
                ),
                gap,
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.all(8),
                        constraints: BoxConstraints(),
                        iconSize: 24,
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border_outlined),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(8),
                        constraints: BoxConstraints(),
                        iconSize: 24,
                        onPressed: () {},
                        icon: Icon(Icons.share_outlined),
                      ),
                      Spacer(),
                      IconButton(
                        padding: EdgeInsets.all(8),
                        constraints: BoxConstraints(),
                        iconSize: 24,
                        onPressed: () {},
                        icon: Icon(Icons.star),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(8),
                        constraints: BoxConstraints(),
                        iconSize: 24,
                        onPressed: () {},
                        icon: Icon(Icons.sunny),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(8),
                        constraints: BoxConstraints(),
                        iconSize: 24,
                        onPressed: () {},
                        icon: Icon(Icons.notification_add),
                      ),
                    ],
                  ),
                ),
                gap,
                Container(
                  child: Text(
                    "墾丁這邊天氣超好！\n太陽超大～大家要注意防曬喔！",
                    maxLines: 300,
                    style: textgetter.bodyLarge
                        ?.copyWith(color: Color(0xff2E2E2E)),
                    // decoration: const InputDecoration(
                    // hintText: "內容", border: InputBorder.none),
                  ),
                ),
                gap,
                Container(
                  child: Text(
                    "2023/01/23",
                    style: textgetter.bodySmall
                        ?.copyWith(color: Color(0xff2E2E2E)),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: 3,
      ),
    );
  }
}
