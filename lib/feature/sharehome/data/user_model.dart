import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? email;
  final String? nickName;
  final String? authorImage;

  UserModel({
    this.email,
    this.nickName,
    this.authorImage,
  });

  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserModel(
      email: data?["email"],
      nickName: data?["nickName"],
      authorImage: data?["authorImage"],
    );
  }
}
