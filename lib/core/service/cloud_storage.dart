import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_share/core/service/auth_service.dart';

final authServiceProvider = AuthServices();

class CloudStorage extends ChangeNotifier {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

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
    User? user = await authServiceProvider.getUser();
    String uid = user != null ? user.uid : "";
    Map<String, dynamic> userAttributes = {"nickName": nickName};
    try {
      await _storage.collection("users").doc(uid).update(userAttributes);
      return true;
    } catch (err, s) {
      log("$err");
      return false;
    }
  }
}
