import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_share/core/service/auth_service.dart';

final authServiceProvider = AuthServices();

class CloudStorage extends ChangeNotifier {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserAttributes() async {
    try {
      User? user = await authServiceProvider.getUser();
      String uid = user != null ? user.uid : "";
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _storage.collection("users").doc(uid).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        return data;
      }
      return {};
    } catch (err, s) {
      return {};
    }
  }

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
      await _storage.collection("users").doc(uid).set(userAttributes);
    } catch (err, s) {
      throw Error.throwWithStackTrace(err, s);
    }
  }

  Future<bool> updateUserData({required String nickName}) async {
    try {
      User? user = await authServiceProvider.getUser();
      String uid = user != null ? user.uid : "";
      Map<String, dynamic> userAttributes = {"nickName": nickName};
      // 使用此方法，新增沒有的屬性
      await _storage.collection("users").doc(uid).update(userAttributes);

      return true;
    } catch (err, s) {
      log("$err");
      return false;
    }
  }
}
