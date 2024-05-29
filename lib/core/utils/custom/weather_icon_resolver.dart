import 'package:weather_share/feature/publish/data/weather_model.dart';

class WeatherIconResolver {
  static String resolveWeatherIcon(String weather) {
    switch (weather) {
      case "sunny":
        return "image/weather/sunny.png";
      case "rainy":
        return "image/weather/rainy.png";
      case "cloudy":
        return "image/weather/cloudy.png";
      default:
        return "";
    }
  }

  static List<WeatherModel> get weatherList => [
        WeatherModel(icon: "image/weather/sunny.png", text: "sunny"),
        WeatherModel(icon: "image/weather/rainy.png", text: "rainy"),
        WeatherModel(icon: "image/weather/cloudy.png", text: "cloudy"),
      ];
}
