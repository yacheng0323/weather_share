import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_share/core/service/auth_service.dart';
import 'package:weather_share/core/service/cloud_storage.dart';

final authServiceProvider = AuthServices();

final cloudStorageProvider = CloudStorage();

class UserProfileViewModel extends ChangeNotifier {
  bool? _isSuccess;

  bool? get isSuccess => _isSuccess;

  Future<void> update({required String nickName}) async {
    try {
      await cloudStorageProvider.updateUserData(nickName: nickName);
      _isSuccess = true;
      notifyListeners();
    } catch (e) {
      _isSuccess = false;
      notifyListeners();
    }
  }
}
