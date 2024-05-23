import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_share/core/router/app_router.gr.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/country_icon_resolver.dart';
import 'package:weather_share/core/utils/custom/weather_icon_resolver.dart';
import 'package:weather_share/feature/account/account_page.dart';
import 'package:weather_share/feature/sharehome/domain/share_home_view_model.dart';

@RoutePage()
class ShareHomePage extends StatefulWidget {
  const ShareHomePage({super.key});

  @override
  State<ShareHomePage> createState() => _ShareHomePageState();
}

class _ShareHomePageState extends State<ShareHomePage> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);
    final Padding gap = Padding(padding: EdgeInsets.all(4));

    return ChangeNotifierProvider(
      create: (context) {
        ShareHomeViewModel shareHomeViewModel = ShareHomeViewModel();
        shareHomeViewModel.getAllArticle();
        return shareHomeViewModel;
      },
      builder: (context, child) {
        return Consumer<ShareHomeViewModel>(
          builder: (context, provider, child) {
            return Scaffold(
              drawer: const Drawer(
                child: AccountPage(),
              ),
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                title: Text(
                  "分享首頁",
                  style: textgetter.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                backgroundColor: const Color(0xff76B2F9),
                actions: [
                  IconButton(
                      onPressed: () {
                        AutoRouter.of(context).push(const PublishPageRoute());
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ))
                ],
              ),
              body: provider.loadingStatus
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : RefreshIndicator(
                      key: refreshIndicatorKey,
                      onRefresh: () async {
                        await provider.getAllArticle();
                      },
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.articleList.length,
                        itemBuilder: (context, index) {
                          final item = provider.articleList[index];
                          return Container(
                            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffE6E6E6)),
                                      child: Image.asset(
                                        "image/avatar.png",
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                                    gap,
                                    Text(
                                      item.nickName ?? "",
                                      style: textgetter.bodyMedium?.copyWith(
                                          color: const Color(0xff2E2E2E)),
                                    ),
                                  ],
                                ),
                                gap,
                                Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    // color: Colors.orange,
                                  ),
                                  child: ImageNetwork(
                                    image: item.imageURL ?? "",
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    duration: 500,
                                    debugPrint: false,
                                    fullScreen: false,
                                    fitAndroidIos: BoxFit.cover,
                                    fitWeb: BoxFitWeb.cover,
                                    borderRadius: BorderRadius.circular(8),
                                    onLoading: const CircularProgressIndicator(
                                      color: Colors.indigoAccent,
                                    ),
                                    onError: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                // gap,
                                Container(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.all(8),
                                        constraints: BoxConstraints(),
                                        iconSize: 20,
                                        onPressed: () {},
                                        style: ButtonStyle(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap),
                                        icon: Icon(
                                            Icons.favorite_border_outlined),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        iconSize: 20, // desired size
                                        padding: EdgeInsets.all(8),
                                        constraints:
                                            const BoxConstraints(), // override default min size of 48px
                                        style: const ButtonStyle(
                                          tapTargetSize: MaterialTapTargetSize
                                              .shrinkWrap, // the '2023' part
                                        ),
                                        icon: const Icon(Icons.share_outlined),
                                      ),
                                      Spacer(),
                                      Image.asset(CountryIconResolver
                                          .resolveCountryIcon(
                                              item.country ?? "")),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Image.asset(WeatherIconResolver
                                          .resolveWeatherIcon(
                                              item.weather ?? "")),
                                      IconButton(
                                        padding: EdgeInsets.all(8),
                                        constraints: BoxConstraints(),
                                        iconSize: 24,
                                        onPressed: () {
                                          showCupertinoDialog(
                                              context: context,
                                              builder: (context) {
                                                return CupertinoAlertDialog(
                                                  title: const Text("舉報貼文?"),
                                                  content:
                                                      const Text("是否舉報該則貼文?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("取消"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        // await provider
                                                        //     .signOut();
                                                        // // Navigator.pop(context);
                                                        // AutoRouter.of(context)
                                                        //     .replaceAll([
                                                        //   const LoginPageRoute()
                                                        // ]);
                                                      },
                                                      child: const Text("確定"),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon:
                                            Image.asset("image/alertIcon.png"),
                                      ),
                                    ],
                                  ),
                                ),
                                gap,
                                Text(
                                  item.content ?? "",
                                  maxLines: 300,
                                  style: textgetter.bodyLarge?.copyWith(
                                      color: const Color(0xff2E2E2E)),
                                ),
                                gap,
                                Text(
                                  DateFormat("yyyy/MM/dd HH:mm:ss").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          item.timestamp! * 1000)),
                                  style: textgetter.bodySmall?.copyWith(
                                      color: const Color(0xff2E2E2E)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
