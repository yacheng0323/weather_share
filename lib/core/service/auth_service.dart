import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_share/entities/remote/forgot_password_result.dart';
import 'package:weather_share/entities/remote/register_result.dart';
import 'package:weather_share/entities/remote/signIn_result.dart';
import 'package:weather_share/entities/remote/signout_result.dart';

class AuthServices extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authState => _auth.authStateChanges();

  Future<User?> getUser() async {
    return _auth.currentUser;
  }

  //* 登入
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
        // Firebase auth setting，如果Email enumeration protection (recommended) 有勾選的話，只會拋出這個錯誤
        // 目的是，“找不到該使用者”怕有心人利用這點一直去試帳號。
        case "invalid-credential":
          return SignInResult(isSignIn: false, errorMessage: "電子郵件地址無效或密碼錯誤。");
        default:
          return SignInResult(isSignIn: false, errorMessage: "發生未知錯誤。");
      }
    }
  }

  //* 註冊
  Future<RegisteredResult> registerWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return RegisteredResult(
          isRegistered: true, uid: userCredential.user!.uid);
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

  //* 忘記密碼
  Future<ForgotPasswordResult> forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return ForgotPasswordResult(isSuccess: true);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return ForgotPasswordResult(
              isSuccess: false, errorMessage: "電子郵件地址無效。");
        case "missing-continue-uri":
          return ForgotPasswordResult(
              isSuccess: false, errorMessage: "請提供請求中的連續網址。");
        case "missing-ios-bundle-id":
          return ForgotPasswordResult(
              isSuccess: false,
              errorMessage: "請提供 iOS 應用程式的 Bundle ID，若提供了 App Store ID。");
        case "invalid-continue-uri":
          return ForgotPasswordResult(
              isSuccess: false, errorMessage: "提供的連續網址無效。");
        case "unauthorized-continue-uri":
          return ForgotPasswordResult(
              isSuccess: false,
              errorMessage: "連續網址的域名未被授權。請在 Firebase 控制台中將該域名加入白名單。");
        case "user-not-found":
          return ForgotPasswordResult(
              isSuccess: false, errorMessage: "找不到與該電子郵件地址相對應的使用者。");
        default:
          return ForgotPasswordResult(
              isSuccess: false, errorMessage: "發生未知錯誤。");
      }
    }
  }

  //* 登出
  Future<SignOutResult> signOut() async {
    try {
      await _auth.signOut();
      return SignOutResult(isSuccess: true);
    } catch (e) {
      return SignOutResult(isSuccess: false, errorMessage: "登出失敗。");
    }
  }
}
