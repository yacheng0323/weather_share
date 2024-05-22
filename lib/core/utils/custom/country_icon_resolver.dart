import 'package:weather_share/feature/publish/data/country_model.dart';

class CountryIconResolver {
  static String resolveCountryIcon(String country) {
    switch (country) {
      case "Taiwan":
        return "image/country/Taiwan.png";
      case "China":
        return "image/country/China.png";
      case "Japan":
        return "image/country/Japan.png";
      case "Korean":
        return "image/country/Korean.png";
      case "America":
        return "image/country/America.png";
      case "Canada":
        return "image/country/Canada.png";
      case "England":
        return "image/country/England.png";
      case "France":
        return "image/country/France.png";
      case "Australia":
        return "image/country/Australia.png";
      case "Italy":
        return "image/country/Italy.png";
      case "Spain":
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
