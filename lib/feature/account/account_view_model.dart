import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_share/core/service/cloud_storage.dart';
import 'package:weather_share/entities/remote/get_attributes_result.dart';

final cloudStorageProvider = CloudStorage();

class AccountViewModel extends ChangeNotifier {
  String? _email;

  String? get email => _email;

  String? _nickName;

  String? get nickName => _nickName;

  String? _avatar;

  String? get avatar => _avatar;

  Future<void> init() async {
    GetAttributesResult<Map<String, dynamic>> result =
        await cloudStorageProvider.getUserAttributes();

    if (result.isSuccess) {
      Map<String, dynamic> data = result.data!;
      _email = data["email"] ?? "";
      _nickName = data["nickName"] ?? "";
      _avatar = data["avatar"];
    } else if (result.isError) {
      _email = "信箱";
      _nickName = "暱稱";
      _avatar = null;
    }

    notifyListeners();
  }

  Future<void> navToURL({required String uri}) async {
    final Uri url = Uri.parse(uri);

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> signOut() async {
    await authServiceProvider.signOut();
  }
}
