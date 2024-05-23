import 'package:weather_share/feature/publish/data/weather_model.dart';

class WeatherIconResolver {
  static String resolveWeatherIcon(String weather) {
    switch (weather) {
      case "晴天":
        return "image/weather/sunny.png";
      case "雨天":
        return "image/weather/rainy.png";
      case "陰天":
        return "image/weather/cloudy.png";
      default:
        return "";
    }
  }

  static List<WeatherModel> get weatherList => [
        WeatherModel(icon: "image/weather/sunny.png", text: "晴天"),
        WeatherModel(icon: "image/weather/rainy.png", text: "雨天"),
        WeatherModel(icon: "image/weather/cloudy.png", text: "陰天"),
      ];
}
