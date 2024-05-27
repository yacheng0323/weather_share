import 'package:flutter/foundation.dart';
import 'package:weather_share/core/service/auth_service.dart';
import 'package:weather_share/entities/remote/change_password_result.dart';
import 'package:weather_share/entities/remote/validate_password_result.dart';

final authServiceProvider = AuthServices();

class ChangePasswordViewModel extends ChangeNotifier {
  bool loadingStatus = false;

  ValidatePasswordResult? validatePasswordResult;

  ChangePasswordResult? changePasswordResult;

  bool _oldPasswordVisible = true;

  bool? get oldPasswordVisible => _oldPasswordVisible;

  bool _newPasswordVisible = true;

  bool? get newPasswordVisible => _newPasswordVisible;

  bool _confirmPasswordVisible = true;

  bool? get confirmPasswordVisible => _confirmPasswordVisible;

  void toggleVisibility(ChangePasswordVisibility type) {
    switch (type) {
      case ChangePasswordVisibility.oldPasswordVisible:
        _oldPasswordVisible = !_oldPasswordVisible;
        break;
      case ChangePasswordVisibility.newPasswordVisible:
        _newPasswordVisible = !_newPasswordVisible;
        break;
      case ChangePasswordVisibility.confirmPasswordVisible:
        _confirmPasswordVisible = !_confirmPasswordVisible;
        break;
    }
    notifyListeners();
  }

  //* 驗證舊密碼是否正確
  Future<void> validatePassword({required String password}) async {
    validatePasswordResult =
        await authServiceProvider.validateOldPassword(password: password);
    notifyListeners();
  }

  //* 送出修改密碼
  Future<void> changePassword({required String newPassword}) async {
    loadingStatus = true;
    notifyListeners();
    changePasswordResult =
        await authServiceProvider.changePassword(newPassword: newPassword);
    loadingStatus = false;

    notifyListeners();
  }
}

enum ChangePasswordVisibility {
  oldPasswordVisible,
  newPasswordVisible,
  confirmPasswordVisible,
}
