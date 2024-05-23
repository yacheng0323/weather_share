class PublishModel {
  final String author;
  final String content;
  final int timestamp;
  final String imageURL;
  final String weather;
  final String country;
  final List<String> likedBy;
  final List<String> reportCount;
  PublishModel({
    required this.author,
    required this.content,
    required this.timestamp,
    required this.imageURL,
    required this.weather,
    required this.country,
    this.reportCount = const [],
    this.likedBy = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      "author": author,
      "content": content,
      "timestamp": timestamp,
      "imageURL": imageURL,
      "weather": weather,
      "country": country,
      "likedBy": likedBy,
      "reportCount": reportCount,
    };
  }
}
