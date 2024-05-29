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
        CountryModel(icon: "image/country/Taiwan.png", text: "Taiwan"),
        CountryModel(icon: "image/country/China.png", text: "China"),
        CountryModel(icon: "image/country/Japan.png", text: "Japan"),
        CountryModel(icon: "image/country/Korean.png", text: "Korean"),
        CountryModel(icon: "image/country/America.png", text: "America"),
        CountryModel(icon: "image/country/Canada.png", text: "Canada"),
        CountryModel(icon: "image/country/England.png", text: "England"),
        CountryModel(icon: "image/country/France.png", text: "France"),
        CountryModel(icon: "image/country/Australia.png", text: "Australia"),
        CountryModel(icon: "image/country/Italy.png", text: "Italy"),
        CountryModel(icon: "image/country/Spain.png", text: "Spain"),
      ];
}
