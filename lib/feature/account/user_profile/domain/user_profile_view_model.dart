import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:weather_share/core/service/auth_service.dart';
import 'package:weather_share/core/service/cloud_storage.dart';
import 'package:weather_share/core/service/image_helper.dart';
import 'package:weather_share/entities/remote/get_attributes_result.dart';

final authServiceProvider = AuthServices();

final cloudStorageProvider = CloudStorage();

final imageHelperProvider = ImageHelper();

class UserProfileViewModel extends ChangeNotifier {
  bool loadingStatus = false;

  bool? _isSuccess;

  bool? get isSuccess => _isSuccess;

  String? _imagePath;

  String? get imagePath => _imagePath;

  String? _nickName;

  String? get nickName => _nickName;

  Future<void> init() async {
    loadingStatus = true;
    notifyListeners();
    GetAttributesResult<Map<String, dynamic>> result =
        await cloudStorageProvider.getUserAttributes();

    if (result.isSuccess) {
      Map<String, dynamic> data = result.data!;
      _imagePath = data["avatar"];
      _nickName = data["nickName"] ?? "";
    } else if (result.isError) {
      _imagePath = null;
      _nickName = "";
    }
    loadingStatus = false;
    notifyListeners();
  }

  Future<void> update({required String nickName}) async {
    try {
      loadingStatus = true;
      notifyListeners();

      String? imageURL;
      if (_imagePath != null && File(_imagePath!).existsSync()) {
        imageURL = await imageHelperProvider.uploadImageToFirebaseStorage(
            _imagePath!, true);
      } else {
        imageURL = _imagePath;
      }
      await cloudStorageProvider.updateUserData(
          nickName: nickName, imageURL: imageURL);

      _isSuccess = true;
      loadingStatus = false;
      notifyListeners();
    } catch (e) {
      _isSuccess = false;
      loadingStatus = false;
      notifyListeners();
    }
  }

  Future<void> setImage({required bool fromCamera}) async {
    _imagePath = await imageHelperProvider.getImage(
        fromCamera: fromCamera, isCircular: true);
    notifyListeners();
  }

  bool isUrl(String path) {
    // ignore: prefer_const_declarations
    final urlPattern = r'^https?:\/\/';
    return RegExp(urlPattern).hasMatch(path);
  }
}
