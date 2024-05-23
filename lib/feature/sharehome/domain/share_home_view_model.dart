import 'package:flutter/material.dart';
import 'package:weather_share/core/service/auth_service.dart';
import 'package:weather_share/core/service/cloud_storage.dart';
import 'package:weather_share/feature/sharehome/data/article_model.dart';

final cloudStorageProvider = CloudStorage();

final authServicesProvider = AuthServices();

class ShareHomeViewModel extends ChangeNotifier {
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

  // Future<void> reportArticle() {

  // }

  Future<void> updateArticle() async {}
}
