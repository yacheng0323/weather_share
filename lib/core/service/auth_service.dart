import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_share/entities/remote/change_password_result.dart';
import 'package:weather_share/entities/remote/forgot_password_result.dart';
import 'package:weather_share/entities/remote/register_result.dart';
import 'package:weather_share/entities/remote/signIn_result.dart';
import 'package:weather_share/entities/remote/signout_result.dart';
import 'package:weather_share/entities/remote/validate_password_result.dart';

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
          return SignInResult(
              isSignIn: false, errorMessage: "Invalid email address.");
        case "user-not-found":
          return SignInResult(isSignIn: false, errorMessage: "User not found.");
        case "user-disabled":
          return SignInResult(
              isSignIn: false, errorMessage: "User account has been disabled.");
        case "wrong-password":
          return SignInResult(
              isSignIn: false, errorMessage: "Incorrect password.");
        // Firebase auth setting，如果Email enumeration protection (recommended) 有勾選的話，只會拋出這個錯誤
        // 目的是，“找不到該使用者”怕有心人利用這點一直去試帳號。
        case "invalid-credential":
          return SignInResult(
              isSignIn: false,
              errorMessage: "Invalid email address or incorrect password.");
        default:
          return SignInResult(
              isSignIn: false,
              errorMessage:
                  "An unknown error occurred. Please try again later.");
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
              isRegistered: false,
              errorMessage: "Email address already in use.");
        case "invalid-email":
          return RegisteredResult(
              isRegistered: false, errorMessage: "Invalid email address.");
        case "operation-not-allowed":
          return RegisteredResult(
              isRegistered: false, errorMessage: "Operation not allowed.");
        case "weak-password":
          return RegisteredResult(
              isRegistered: false,
              errorMessage: "Password strength insufficient.");
        default:
          return RegisteredResult(
              isRegistered: false,
              errorMessage:
                  "An unknown error occurred. Please try again later.");
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
              isSuccess: false, errorMessage: "Invalid email address.");
        case "missing-continue-uri":
          return ForgotPasswordResult(
              isSuccess: false,
              errorMessage: "Please provide the requested URL.");
        case "missing-ios-bundle-id":
          return ForgotPasswordResult(
              isSuccess: false,
              errorMessage:
                  "Please provide the Bundle ID for the iOS app, if App Store ID is provided.");
        case "invalid-continue-uri":
          return ForgotPasswordResult(
              isSuccess: false, errorMessage: "The provided URL is invalid.");
        case "unauthorized-continue-uri":
          return ForgotPasswordResult(
              isSuccess: false,
              errorMessage:
                  "The domain of the URL is not authorized. Please add the domain to the whitelist in the Firebase console.");
        case "user-not-found":
          return ForgotPasswordResult(
              isSuccess: false,
              errorMessage:
                  "No user corresponding to the email address was found.");
        default:
          return ForgotPasswordResult(
              isSuccess: false,
              errorMessage:
                  "An unknown error occurred. Please try again later.");
      }
    }
  }

  //* 驗證舊密碼
  Future<ValidatePasswordResult> validateOldPassword(
      {required String password}) async {
    User? user = _auth.currentUser;

    if (user != null) {
      AuthCredential authCredential =
          EmailAuthProvider.credential(email: user.email!, password: password);

      try {
        await user.reauthenticateWithCredential(authCredential);
        return ValidatePasswordResult(isValidate: true);
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "user-mismatch":
            return ValidatePasswordResult(
                isValidate: false,
                errorMessage:
                    "The provided credentials do not match the current user.");

          case "user-not-found":
            return ValidatePasswordResult(
                isValidate: false,
                errorMessage:
                    "No user corresponding to the provided credentials was found.");

          case "invalid-credential":
            return ValidatePasswordResult(
                isValidate: false,
                errorMessage:
                    "The provided credentials are invalid. This may be due to expired credentials or the use of invalid credentials. Please check your provider credentials documentation and ensure you are passing the correct parameters.");
          case "invalid-email":
            return ValidatePasswordResult(
                isValidate: false,
                errorMessage: "The provided email address is invalid.");
          case "wrong-password":
            return ValidatePasswordResult(
                isValidate: false,
                errorMessage:
                    "The provided old password is incorrect, or the user associated with the provided email address has not set a password.");
          case "invalid-verification-code":
            return ValidatePasswordResult(
                isValidate: false,
                errorMessage:
                    "The provided verification code is invalid. Please re-enter the correct verification code.");
          case "invalid-verification-id":
            return ValidatePasswordResult(
                isValidate: false,
                errorMessage:
                    "The provided verification ID is invalid. Please check and re-enter the correct verification ID.");
          default:
            return ValidatePasswordResult(
                isValidate: false,
                errorMessage:
                    "An unknown error occurred. Please try again later.");
        }
      }
    }
    return ValidatePasswordResult(
        isValidate: false,
        errorMessage: "An unknown error occurred. Please try again later.");
  }

  Future<ChangePasswordResult> changePassword(
      {required String newPassword}) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
      return ChangePasswordResult(isChanged: true);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          return ChangePasswordResult(
              isChanged: false,
              errorMessage:
                  "Password strength is insufficient. Please use a more complex password.");
        case "requires-recent-login":
          return ChangePasswordResult(
              isChanged: false,
              errorMessage:
                  "This operation requires a recent login. Please log in again and try again.");
        default:
          return ChangePasswordResult(
              isChanged: false,
              errorMessage:
                  "An unknown error occurred. Please try again later.");
      }
    }
  }

  //* 登出
  Future<SignOutResult> signOut() async {
    try {
      await _auth.signOut();
      return SignOutResult(isSuccess: true);
    } catch (e) {
      return SignOutResult(isSuccess: false, errorMessage: "Logout failed.");
    }
  }
}
