import 'package:flutter/material.dart';
import 'package:weather_share/core/service/auth_service.dart';

final authServiceProvider = AuthServices();

class AccountViewModel extends ChangeNotifier {
  Future<void> signOut() async {
    await authServiceProvider.signOut();
  }
}
