import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_share/feature/sharehome/data/user_model.dart';

class ArticleModel {
  final String? author;
  final String? content;
  final String? country;
  final String? imageURL;
  final List<String>? likedBy;
  final String? postId;
  final int? timestamp;
  final String? weather;
  final String? nickName;
  final String? avatar;
  final List<String>? reportCount;
  final bool? isLike;

  ArticleModel({
    this.author,
    this.content,
    this.country,
    this.imageURL,
    this.likedBy,
    this.postId,
    this.timestamp,
    this.weather,
    this.nickName,
    this.avatar,
    this.reportCount,
    this.isLike,
  });

  ArticleModel copyWith({
    String? author,
    String? content,
    String? country,
    String? imageURL,
    List<String>? likedBy,
    String? postId,
    int? timestamp,
    String? weather,
    String? nickName,
    String? avatar,
    List<String>? reportCount,
    bool? isLike,
  }) {
    return ArticleModel(
      author: author ?? this.author,
      content: content ?? this.content,
      country: country ?? this.country,
      imageURL: imageURL ?? this.imageURL,
      likedBy: likedBy ?? this.likedBy,
      postId: postId ?? this.postId,
      timestamp: timestamp ?? this.timestamp,
      weather: weather ?? this.weather,
      nickName: nickName ?? this.nickName,
      avatar: avatar ?? this.avatar,
      reportCount: reportCount ?? this.reportCount,
      isLike: isLike ?? this.isLike,
    );
  }

  factory ArticleModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> articleSnapshot,
      DocumentSnapshot<Map<String, dynamic>> userSnapshot,
      DocumentSnapshot<Map<String, dynamic>> displayAuthorSnapshot,
      SnapshotOptions? options) {
    try {
      final articleData = articleSnapshot.data();
      final userData = userSnapshot.data();
      final displayAuthor = displayAuthorSnapshot.data();

      bool isLike = (articleData?["likedBy"] as List)
          .contains(userData?["email"].toString());

      List<String>? likedByList =
          (articleData?["likedBy"] as List<dynamic>?)?.cast<String>();

      List<String>? reportCountList =
          (articleData?["reportCount"] as List<dynamic>?)?.cast<String>();

      return ArticleModel(
          author: articleData?["author"],
          content: articleData?["content"],
          country: articleData?["country"],
          imageURL: articleData?["imageURL"],
          likedBy: likedByList,
          postId: articleData?["postId"],
          timestamp: articleData?["timestamp"],
          weather: articleData?["weather"],
          reportCount: reportCountList,
          nickName: displayAuthor?["nickName"],
          avatar: displayAuthor?["avatar"],
          isLike: isLike);
    } catch (err, s) {
      log("ArticleModel.fromJson", error: err, stackTrace: s);
      Error.throwWithStackTrace(err, s);
    }
  }
}
