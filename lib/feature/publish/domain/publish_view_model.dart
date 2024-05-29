import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_share/core/service/auth_service.dart';
import 'package:weather_share/core/service/cloud_storage.dart';
import 'package:weather_share/core/service/image_helper.dart';
import 'package:weather_share/core/utils/custom/country_icon_resolver.dart';
import 'package:weather_share/core/utils/custom/weather_icon_resolver.dart';
import 'package:weather_share/entities/remote/publish_result.dart';
import 'package:weather_share/feature/publish/data/country_model.dart';
import 'package:weather_share/feature/publish/data/publish_model.dart';
import 'package:weather_share/feature/publish/data/weather_model.dart';

final imageHelperProvider = ImageHelper();

final cloudStorageProvider = CloudStorage();

final authServicesProvider = AuthServices();

class PublishViewModel extends ChangeNotifier {
  PublishResult? publishResult;

  bool loadingStatus = false;

  List<WeatherModel> weatherList = WeatherIconResolver.weatherList;

  List<CountryModel> countryList = CountryIconResolver.countryList;

  String? _imagePath;

  String? get imagePath => _imagePath;

  String? _content;

  String? get content => _content;

  WeatherModel? _weather;

  WeatherModel? get weather => _weather;

  CountryModel? _country;

  CountryModel? get country => _country;

  PublishModel? _publishModel;

  PublishModel? get publishModel => _publishModel;

  String? _notValidateMessage;

  String? get notValidateMessage => _notValidateMessage;

  Future<void> setImage({required bool fromCamera}) async {
    _imagePath = await imageHelperProvider.getImage(fromCamera: fromCamera);
    notifyListeners();
  }

  void selectWeather({required WeatherModel weather}) {
    _weather = weather;
    notifyListeners();
  }

  void selectCountry({required CountryModel country}) {
    _country = country;
    notifyListeners();
  }

  void onChangeContent({required String value}) {
    _content = value;
    notifyListeners();
  }

  void validateForm() {
    String message = "";
    if (_imagePath == null) {
      message += "Please upload an image.\n";
    }

    if (_content == null) {
      message += "Please enter post content.\n";
    }

    if (_weather == null) {
      message += "Please select weather.\n";
    }
    if (_country == null) {
      message += "Please select country.";
    }
    _notValidateMessage = message;
    notifyListeners();
  }

  Future<void> publish() async {
    loadingStatus = true;
    notifyListeners();
    try {
      String imageURL = await imageHelperProvider.uploadImageToFirebaseStorage(
          _imagePath!, false);
      String? uid;

      User? user = await authServicesProvider.getUser();
      if (user != null) {
        uid = user.uid;
      }

      PublishModel data = PublishModel(
          author: uid ?? "",
          content: _content ?? "",
          timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          imageURL: imageURL,
          weather: _weather!.text,
          country: _country!.text);
      publishResult =
          await cloudStorageProvider.createArticle(publishModel: data);
      loadingStatus = false;

      notifyListeners();
    } catch (e) {
      publishResult = PublishResult(
          isPublished: false, errorMessage: "Failed to publish post.");
      loadingStatus = false;
      notifyListeners();
    }
  }
}
