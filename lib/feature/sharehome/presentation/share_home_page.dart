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
import 'package:weather_share/core/utils/custom/show_snack.bar.dart';
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
              drawer: Drawer(
                child: AccountPage(
                  shareHomeViewModel: provider,
                ),
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
                        AutoRouter.of(context).push(
                            PublishPageRoute(shareHomeViewModel: provider));
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
                                    item.avatar != null
                                        ? ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: item.avatar ?? "",
                                              width: 32,
                                              height: 32,
                                            ),
                                          )
                                        : Container(
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
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: item.imageURL ?? "",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    ),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) {
                                      return const CupertinoActivityIndicator();
                                    },
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
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
                                        onPressed: () async {
                                          await provider.toggleLike(
                                              postId: item.postId ?? "",
                                              article: item,
                                              like: !item.isLike!);
                                        },
                                        style: ButtonStyle(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap),
                                        icon: Consumer<ShareHomeViewModel>(
                                          builder: (context, provider, _) {
                                            return item.isLike!
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : Icon(Icons
                                                    .favorite_border_outlined);
                                          },
                                        ),
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
                                                        Navigator.pop(context);
                                                        await provider
                                                            .reportContent(
                                                                postId:
                                                                    item.postId ??
                                                                        "",
                                                                article: item);

                                                        if (provider
                                                                .updateArticleResult
                                                                ?.isSuccess ==
                                                            true) {
                                                          ShowSnackBarHelper
                                                                  .successSnackBar(
                                                                      context:
                                                                          context)
                                                              .showSnackbar(provider
                                                                      .updateArticleResult
                                                                      ?.message ??
                                                                  "");
                                                        } else {
                                                          ShowSnackBarHelper
                                                                  .errorSnackBar(
                                                                      context:
                                                                          context)
                                                              .showSnackbar(provider
                                                                      .updateArticleResult
                                                                      ?.message ??
                                                                  "");
                                                        }
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
