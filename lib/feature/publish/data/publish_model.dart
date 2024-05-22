class PublishModel {
  final String postId;
  final String authorId;
  final String content;
  final int timestamp;
  final String imageURL;
  final String weather;
  final String country;
  final List<String> likedBy;
  PublishModel(
      {required this.postId,
      required this.authorId,
      required this.content,
      required this.timestamp,
      required this.imageURL,
      required this.weather,
      required this.country,
      List<String>? likedBy})
      : likedBy = likedBy ?? [];

  Map<String, dynamic> toMap() {
    return {
      "authorId": authorId,
      "content": content,
      "timestamp": timestamp,
      "imageURL": imageURL,
      "weather": weather,
      "country": country,
      "likedBy": likedBy,
    };
  }
}
