import 'package:flutter/material.dart';
import 'package:weather_share/core/service/cloud_storage.dart';

final cloudStorageProvider = CloudStorage();

class AccountViewModel extends ChangeNotifier {
  String? _email;

  String? get email => _email;

  String? _nickName;

  String? get nickName => _nickName;

  Future<void> init() async {
    Map<String, dynamic> userAttributes =
        await cloudStorageProvider.getUserAttributes();

    _email = userAttributes["email"] ?? "";
    _nickName = userAttributes["nickName"] ?? "";

    notifyListeners();
  }

  Future<void> signOut() async {
    await authServiceProvider.signOut();
  }
}
