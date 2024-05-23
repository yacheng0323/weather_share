import 'package:flutter/foundation.dart';
import 'package:weather_share/core/service/cloud_storage.dart';
import 'package:weather_share/entities/remote/delete_article_result.dart';
import 'package:weather_share/feature/sharehome/data/article_model.dart';

final cloudStorageProvider = CloudStorage();

class ManageArticleViewModel extends ChangeNotifier {
  DeleteArticleResult? deleteArticleResult;

  bool loadingStatus = false;

  List<ArticleModel> articleList = [];

  Future<void> getArticle() async {
    loadingStatus = true;
    notifyListeners();
    articleList = await cloudStorageProvider.getArticleWithUid();
    articleList.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
    loadingStatus = false;
    notifyListeners();
  }

  Future<void> delete({required String postId}) async {
    loadingStatus = true;
    notifyListeners();
    deleteArticleResult =
        await cloudStorageProvider.deleteArticle(postId: postId);
    articleList = await cloudStorageProvider.getArticleWithUid();
    articleList.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
    loadingStatus = false;

    notifyListeners();
  }
}
