import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_share/core/service/auth_service.dart';
import 'package:weather_share/entities/remote/delete_article_result.dart';
import 'package:weather_share/entities/remote/get_attributes_result.dart';
import 'package:weather_share/entities/remote/publish_result.dart';
import 'package:weather_share/entities/remote/update_article_result.dart';
import 'package:weather_share/feature/publish/data/publish_model.dart';
import 'package:weather_share/feature/sharehome/data/article_model.dart';
import 'package:weather_share/feature/sharehome/data/user_model.dart';

final authServiceProvider = AuthServices();

class CloudStorage extends ChangeNotifier {
  final FirebaseFirestore _fireStoreDB = FirebaseFirestore.instance;

  //* 取得使用者屬性
  Future<GetAttributesResult<Map<String, dynamic>>> getUserAttributes() async {
    try {
      User? user = await authServiceProvider.getUser();
      String uid = user != null ? user.uid : "";
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _fireStoreDB.collection("users").doc(uid).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        return GetAttributesResult(data: data);
      }
      return GetAttributesResult(data: {});
    } catch (err) {
      return GetAttributesResult(error: err.toString());
    }
  }

  //* 儲存使用者資料
  Future<void> saveUserData({
    required String uid,
    required String email,
    required String nickName,
  }) async {
    Map<String, dynamic> userAttributes = {
      "email": email,
      "nickName": nickName
    };
    try {
      await _fireStoreDB.collection("users").doc(uid).set(userAttributes);
    } catch (err, s) {
      throw Error.throwWithStackTrace(err, s);
    }
  }

  //* 更新使用者屬性
  Future<bool> updateUserData({required String nickName}) async {
    try {
      User? user = await authServiceProvider.getUser();
      String uid = user != null ? user.uid : "";
      Map<String, dynamic> userAttributes = {"nickName": nickName};
      // 使用此方法，新增沒有的屬性
      await _fireStoreDB.collection("users").doc(uid).update(userAttributes);

      return true;
    } catch (err, s) {
      log("$err");
      return false;
    }
  }

  //* 取得文章列表
  Future<List<ArticleModel>> getArticle() async {
    List<ArticleModel> articleList = [];
    try {
      final postsSnapshot = await _fireStoreDB.collection("posts").get();
      for (var doc in postsSnapshot.docs) {
        final authorId = doc.data()["author"];
        final userDoc =
            await _fireStoreDB.collection("users").doc(authorId).get();

        ArticleModel article = ArticleModel.fromFirestore(doc, userDoc, null);

        articleList.add(article);
      }
      return articleList;
    } catch (e) {
      log("Error getting articles: $e");
      return articleList;
    }
  }

//* 取得文章列表
  Future<List<ArticleModel>> getArticleWithUid() async {
    List<ArticleModel> articleList = [];
    try {
      User? user = await authServiceProvider.getUser();
      String uid = user != null ? user.uid : "";
      final postsSnapshot = await _fireStoreDB
          .collection("posts")
          .where("author", isEqualTo: uid)
          .get();
      for (var doc in postsSnapshot.docs) {
        final authorId = doc.data()["author"];
        final userDoc =
            await _fireStoreDB.collection("users").doc(authorId).get();

        ArticleModel article = ArticleModel.fromFirestore(doc, userDoc, null);

        articleList.add(article);
      }
      return articleList;
    } catch (e) {
      log("Error getting articles: $e");
      return articleList;
    }
  }

  //* 點擊關注
  Future<UpdateArticleResult> updateLiked(
      {required String postId, required ArticleModel article}) async {
    User? user = await authServiceProvider.getUser();
    String? email = user != null ? user.email : "";
    DocumentReference postRef = _fireStoreDB.collection("posts").doc(postId);

    DocumentSnapshot postSnapshot = await postRef.get();

    if (postSnapshot.exists) {
      List<String> likedByList = List<String>.from(postSnapshot.get("likedBy"));

      if (likedByList.contains(email)) {
        likedByList.removeWhere((element) => element == email);
        await postRef.update({"likedBy": likedByList});
        return UpdateArticleResult(isSuccess: true);
      }
      likedByList.add(email!);

      await postRef.update({"likedBy": likedByList});
      return UpdateArticleResult(isSuccess: true, message: "");
    } else {
      return UpdateArticleResult(isSuccess: false, message: "關注失敗。");
    }
  }

  //* 舉報貼文
  Future<UpdateArticleResult> updateReportCount(
      {required String postId, required ArticleModel article}) async {
    User? user = await authServiceProvider.getUser();
    String? email = user != null ? user.email : "";
    DocumentReference postRef = _fireStoreDB.collection("posts").doc(postId);

    DocumentSnapshot postSnapshot = await postRef.get();

    if (postSnapshot.exists) {
      List<String> reportCountList =
          List<String>.from(postSnapshot.get("reportCount"));

      if (reportCountList.contains(email)) {
        return UpdateArticleResult(isSuccess: false, message: "已經舉報過此貼文了。");
      }
      reportCountList.add(email!);

      await postRef.update({"reportCount": reportCountList});
      return UpdateArticleResult(isSuccess: true, message: "舉報成功。");
    } else {
      return UpdateArticleResult(isSuccess: false, message: "舉報失敗。");
    }
  }

  //* 發表貼文
  Future<PublishResult> createArticle(
      {required PublishModel publishModel}) async {
    try {
      // 生成id
      String postId = _fireStoreDB.collection('posts').doc().id;

      await _fireStoreDB
          .collection("posts")
          .doc(postId)
          .set({...publishModel.toMap(), "postId": postId});
      return PublishResult(isPublished: true);
    } catch (e) {
      return PublishResult(isPublished: false, errorMessage: "發表文章失敗。");
    }
  }

  Future<DeleteArticleResult> deleteArticle({required String postId}) async {
    try {
      await _fireStoreDB.collection("posts").doc(postId).delete();
      return DeleteArticleResult(isSuccess: true);
    } catch (e) {
      return DeleteArticleResult(isSuccess: false, errorMessage: "刪除失敗。");
    }
  }
}
