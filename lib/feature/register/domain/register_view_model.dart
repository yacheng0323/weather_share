import 'package:flutter/material.dart';
import 'package:weather_share/core/service/auth_service.dart';
import 'package:weather_share/core/service/cloud_storage.dart';
import 'package:weather_share/entities/remote/register_result.dart';

final authServiceProvider = AuthServices();

final cloudStorageProvider = CloudStorage();

class RegisterViewModel extends ChangeNotifier {
  RegisteredResult? registeredResult;

  bool _passwordVisible = true;

  bool? get passwordVisible => _passwordVisible;

  bool _confirmPasswordVisible = true;

  bool? get confirmPasswordVisible => _confirmPasswordVisible;

  bool _isPrivacyPolicyAccepted = false;

  bool? get isPrivacyPolicyAccepted => _isPrivacyPolicyAccepted;

  void toggleVisibility(RegisterVisibilityType type) {
    switch (type) {
      case RegisterVisibilityType.passwordVisible:
        _passwordVisible = !_passwordVisible;
        break;
      case RegisterVisibilityType.confirmPasswordVisible:
        _confirmPasswordVisible = !_confirmPasswordVisible;
        break;
      case RegisterVisibilityType.isPrivacyPolicyAccepted:
        _isPrivacyPolicyAccepted = !_isPrivacyPolicyAccepted;

        break;
    }
    notifyListeners();
  }

  Future<void> register(
      {required String email,
      required String password,
      required String nickName}) async {
    RegisteredResult result = await authServiceProvider
        .registerWithEmailPassword(email: email, password: password);

    if (result.isRegistered) {
      await cloudStorageProvider.saveUserData(
          uid: result.uid!, email: email, nickName: nickName);
      registeredResult = result;
      notifyListeners();
    } else {
      registeredResult = result;
      notifyListeners();
    }
  }
}

enum RegisterVisibilityType {
  passwordVisible,
  confirmPasswordVisible,
  isPrivacyPolicyAccepted,
}
