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

  void modifyPasswordVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  void modifyConfirmPasswordVisible() {
    _confirmPasswordVisible = !_confirmPasswordVisible;
    notifyListeners();
  }

  void onPrivacyPolicyCheckboxChanged() {
    _isPrivacyPolicyAccepted = !_isPrivacyPolicyAccepted;
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
