import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';
import 'package:weather_share/core/styles/textgetter.dart';
import 'package:weather_share/core/utils/custom/show_snack.bar.dart';
import 'package:weather_share/feature/account/manage_article/domain/manage_article_view_model.dart';
import 'package:weather_share/feature/sharehome/domain/share_home_view_model.dart';

@RoutePage()
class ManageArticle extends StatefulWidget {
  const ManageArticle({super.key, required this.shareHomeViewModel});
  final ShareHomeViewModel shareHomeViewModel;

  @override
  State<ManageArticle> createState() => _ManageArticleState();
}

class _ManageArticleState extends State<ManageArticle> {
  @override
  Widget build(BuildContext context) {
    final TextGetter textgetter = TextGetter(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back_ios),
          onPressed: () async {
            Navigator.pop(context);
            await widget.shareHomeViewModel.getAllArticle();
          },
        ),
        title: Text(
          "管理貼文",
          style: textgetter.titleLarge
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xff76B2F9),
      ),
      body: ChangeNotifierProvider(
        create: (context) {
          ManageArticleViewModel manageArticleViewModel =
              ManageArticleViewModel();

          manageArticleViewModel.getArticle();
          return manageArticleViewModel;
        },
        builder: (context, child) {
          return Consumer<ManageArticleViewModel>(
            builder: (context, provider, child) {
              return provider.loadingStatus
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : provider.articleList.isEmpty
                      ? Center(
                          child: Text(
                            "目前還沒有任何貼文喔！",
                            style: textgetter.titleMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            provider.getArticle();
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.articleList.length,
                            itemBuilder: (context, index) {
                              final item = provider.articleList[index];

                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                leading: CachedNetworkImage(
                                  imageUrl: item.imageURL ?? "",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const CupertinoActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                title: Text(
                                  item.nickName ?? "",
                                  style: textgetter.bodyMedium?.copyWith(
                                      color: const Color(0xff2E2E2E),
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.content ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: textgetter.bodySmall?.copyWith(
                                          color: const Color(0xff2E2E2E)),
                                    ),
                                    Text(
                                      DateFormat("yyyy/MM/dd HH:mm:ss").format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              item.timestamp! * 1000)),
                                      style: textgetter.bodySmall?.copyWith(
                                          color: const Color(0xff2E2E2E)),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: const Text("刪除貼文?"),
                                          content: const Text("是否刪除該則貼文?"),
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
                                                await provider.delete(
                                                    postId: item.postId!);

                                                if (provider.deleteArticleResult
                                                        ?.isSuccess ==
                                                    true) {
                                                  if (!context.mounted) return;

                                                  ShowSnackBarHelper
                                                          .successSnackBar(
                                                              context: context)
                                                      .showSnackbar("刪除成功");
                                                } else {
                                                  if (!context.mounted) return;

                                                  ShowSnackBarHelper
                                                          .errorSnackBar(
                                                              context: context)
                                                      .showSnackbar(provider
                                                              .deleteArticleResult
                                                              ?.errorMessage ??
                                                          "");
                                                }
                                              },
                                              child: const Text("確定"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        );
            },
          );
        },
      ),
    );
  }
}
