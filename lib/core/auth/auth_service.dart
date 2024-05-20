import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_share/entities/register_result.dart';
import 'package:weather_share/entities/signIn_result.dart';

class AuthServices extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authState => _auth.authStateChanges();

  Future<SignInResult> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return SignInResult(isSignIn: true);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return SignInResult(isSignIn: false, errorMessage: "電子郵件地址無效。");
        case "user-not-found":
          return SignInResult(isSignIn: false, errorMessage: "找不到使用者。");
        case "user-disabled":
          return SignInResult(isSignIn: false, errorMessage: "使用者帳戶已被禁用。");
        case "wrong-password":
          return SignInResult(isSignIn: false, errorMessage: "密碼錯誤。");
        case "invalid-credential": // Firebase 設定，沒有回傳“找不到該使用者”是因為怕有心人利用這點一直去試帳號。
          return SignInResult(isSignIn: false, errorMessage: "發生未知錯誤。");
        default:
          return SignInResult(isSignIn: false, errorMessage: "發生未知錯誤。");
      }
    }
  }

  Future<RegisteredResult> registerWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return RegisteredResult(isRegistered: true);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return RegisteredResult(
              isRegistered: false, errorMessage: "電子郵件地址已被使用。");
        case "invalid-email":
          return RegisteredResult(
              isRegistered: false, errorMessage: "電子郵件地址無效。");
        case "operation-not-allowed":
          return RegisteredResult(isRegistered: false, errorMessage: "操作不被允許。");
        case "weak-password":
          return RegisteredResult(isRegistered: false, errorMessage: "密碼強度不足。");
        default:
          return RegisteredResult(isRegistered: false, errorMessage: "發生未知錯誤。");
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
