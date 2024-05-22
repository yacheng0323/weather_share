import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_share/core/service/auth_service.dart';
import 'package:weather_share/entities/remote/signIn_result.dart';

final authServiceProvider = AuthServices();

class LoginViewModel extends ChangeNotifier {
  bool loadingStatus = false;

  User? user;

  SignInResult? signInResult;

  bool _passwordVisible = true;

  bool? get passwordVisible => _passwordVisible;

  void modifyPasswordVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  // Future<void> checkUserAuthState() async {
  //   authServiceProvider.authState.listen((user) {
  //     this.user = user;
  //     notifyListeners();
  //   });
  // }

  Future<void> signIn({required String email, required String password}) async {
    loadingStatus = true;
    notifyListeners();
    SignInResult result = await authServiceProvider.signInWithEmailPassword(
        email: email, password: password);
    signInResult = result;
    loadingStatus = false;
    notifyListeners();
  }
}
