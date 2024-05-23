import 'package:weather_share/feature/publish/data/country_model.dart';

class CountryIconResolver {
  static String resolveCountryIcon(String country) {
    switch (country) {
      case "臺灣":
        return "image/country/Taiwan.png";
      case "中國":
        return "image/country/China.png";
      case "日本":
        return "image/country/Japan.png";
      case "韓國":
        return "image/country/Korean.png";
      case "美國":
        return "image/country/America.png";
      case "加拿大":
        return "image/country/Canada.png";
      case "英格蘭":
        return "image/country/England.png";
      case "法國":
        return "image/country/France.png";
      case "澳洲":
        return "image/country/Australia.png";
      case "義大利":
        return "image/country/Italy.png";
      case "西班牙":
        return "image/country/Spain.png";
      default:
        return "";
    }
  }

  static List<CountryModel> get countryList => [
        CountryModel(icon: "image/country/Taiwan.png", text: "臺灣"),
        CountryModel(icon: "image/country/China.png", text: "中國"),
        CountryModel(icon: "image/country/Japan.png", text: "日本"),
        CountryModel(icon: "image/country/Korean.png", text: "韓國"),
        CountryModel(icon: "image/country/America.png", text: "美國"),
        CountryModel(icon: "image/country/Canada.png", text: "加拿大"),
        CountryModel(icon: "image/country/England.png", text: "英格蘭"),
        CountryModel(icon: "image/country/France.png", text: "法國"),
        CountryModel(icon: "image/country/Australia.png", text: "澳洲"),
        CountryModel(icon: "image/country/Italy.png", text: "義大利"),
        CountryModel(icon: "image/country/Spain.png", text: "西班牙"),
      ];
}
