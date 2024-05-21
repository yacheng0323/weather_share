import 'package:flutter/foundation.dart';

class ChangePasswordViewModel extends ChangeNotifier {
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
}

enum ChangePasswordVisibility {
  oldPasswordVisible,
  newPasswordVisible,
  confirmPasswordVisible,
}
