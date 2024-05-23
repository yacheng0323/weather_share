import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_share/feature/sharehome/data/user_model.dart';

class ArticleModel {
  final String? author;
  final String? content;
  final String? country;
  final String? imageURL;
  final List<String>? likeBy;
  final String? postId;
  final int? timestamp;
  final String? weather;
  final String? nickName;
  final String? avatar;

  ArticleModel({
    this.author,
    this.content,
    this.country,
    this.imageURL,
    this.likeBy,
    this.postId,
    this.timestamp,
    this.weather,
    this.nickName,
    this.avatar,
  });

  factory ArticleModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> articleSnapshot,
      DocumentSnapshot<Map<String, dynamic>> userSnapshot,
      SnapshotOptions? options) {
    try {
      final articleData = articleSnapshot.data();
      final userData = userSnapshot.data();

      return ArticleModel(
          author: articleData?["author"],
          content: articleData?["content"],
          country: articleData?["country"],
          imageURL: articleData?["imageURL"],
          likeBy: articleData?["likeBy"],
          postId: articleData?["postId"],
          timestamp: articleData?["timestamp"],
          weather: articleData?["weather"],
          nickName: userData?["nickName"],
          avatar: userData?["avatar"]);
    } catch (err, s) {
      log("ArticleModel.fromJson", error: err, stackTrace: s);
      Error.throwWithStackTrace(err, s);
    }
  }
}
