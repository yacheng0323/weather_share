import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper extends ChangeNotifier {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> getImage({required bool fromCamera}) async {
    final pickedFile = await ImagePicker().pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1280,
      maxHeight: 720,
    );

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      File? croppedImage = await cropImage(pickerImage: image);

      if (croppedImage != null) {
        return croppedImage.path;
      } else {
        return image.path;
      }
    }
    return null;
  }

  Future<File?> cropImage({required File pickerImage}) async {
    final cropped = await ImageCropper().cropImage(
        maxHeight: 720,
        maxWidth: 1280,
        sourcePath: pickerImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
        aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
        cropStyle: CropStyle.rectangle,
        uiSettings: [
          IOSUiSettings(title: "Cropper", aspectRatioLockEnabled: true)
        ],
        compressQuality: 100);

    if (cropped != null) {
      return File(cropped.path);
    }
    return null;
  }

  // 上傳圖片 並回傳圖片網址
  Future<String> uploadImageToFirebaseStorage(String imagePath) async {
    try {
      Reference storageReference = _storage
          .ref()
          .child("images/${DateTime.now().millisecondsSinceEpoch ~/ 1000}.png");
      UploadTask uploadTask = storageReference.putFile(File(imagePath));
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      return "";
    }
  }
}