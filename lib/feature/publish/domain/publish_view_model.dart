import 'package:flutter/material.dart';
import 'package:weather_share/core/service/image_helper.dart';
import 'package:weather_share/core/utils/custom/weather_icon_resolver.dart';
import 'package:weather_share/entities/remote/publish_result.dart';
import 'package:weather_share/feature/publish/data/country_model.dart';
import 'package:weather_share/feature/publish/data/publish_model.dart';
import 'package:weather_share/feature/publish/data/weather_model.dart';

final imageHelperProvider = ImageHelper();

class PublishViewModel extends ChangeNotifier {
  PublishResult? publishResult;

  List<WeatherModel> weatherList = WeatherIconResolver.weatherList;

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

  Future<void> setImage({required bool fromCamera}) async {
    _imagePath = await imageHelperProvider.getImage(fromCamera: fromCamera);
    notifyListeners();
  }

  Future<void> publish() async {
    try {
      String imageURL =
          await imageHelperProvider.uploadImageToFirebaseStorage(_imagePath!);
      // PublishModel data = PublishModel(postId: postId, authorId: authorId, content: content, timestamp: timestamp, imageURL: imageURL, weather: weather, country: country)
    } catch (e) {}
  }
}
