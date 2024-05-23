import 'package:flutter/material.dart';
import 'package:weather_share/core/service/auth_service.dart';
import 'package:weather_share/core/service/cloud_storage.dart';
import 'package:weather_share/entities/remote/update_article_result.dart';
import 'package:weather_share/feature/sharehome/data/article_model.dart';

final cloudStorageProvider = CloudStorage();

final authServicesProvider = AuthServices();

class ShareHomeViewModel extends ChangeNotifier {
  UpdateArticleResult? updateArticleResult;

  bool loadingStatus = false;

  List<ArticleModel> articleList = [];

  Future<void> getAllArticle() async {
    loadingStatus = true;
    notifyListeners();
    articleList = await cloudStorageProvider.getArticle();
    articleList.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
    loadingStatus = false;
    notifyListeners();
  }

  Future<void> toggleLike({
    required String postId,
    required ArticleModel article,
    required bool like,
  }) async {
    updateArticleResult = await cloudStorageProvider.updateLiked(
      postId: postId,
      article: article,
    );

    final index = articleList.indexWhere((element) => element.postId == postId);
    if (index != -1) {
      articleList[index] = article.copyWith(isLike: like);
      notifyListeners();
    }
    // articleList = await cloudStorageProvider.getArticle();
    // articleList.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));

    notifyListeners();
  }

  Future<void> reportContent({
    required String postId,
    required ArticleModel article,
  }) async {
    updateArticleResult = await cloudStorageProvider.updateReportCount(
        postId: postId, article: article);

    // final index = articleList.indexWhere((element) => element.postId == postId);
    // if (index != -1) {
    //   articleList[index] = article.copyWith(isLike: like);
    //   notifyListeners();
    // }
    // articleList = await cloudStorageProvider.getArticle();
    // articleList.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));

    notifyListeners();
  }
}
