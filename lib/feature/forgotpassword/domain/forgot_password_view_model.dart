import 'package:flutter/material.dart';
import 'package:weather_share/core/service/auth_service.dart';
import 'package:weather_share/entities/remote/forgot_password_result.dart';

final authServiceProvider = AuthServices();

class ForgotPasswordViewModel extends ChangeNotifier {
  ForgotPasswordResult? forgotPasswordResult;

  Future<void> resetPassword({required String email}) async {
    final result = await authServiceProvider.forgotPassword(email: email);
    forgotPasswordResult = result;
    notifyListeners();
  }
}
