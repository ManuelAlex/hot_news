import 'package:hot_news/app_cores/extensions/constants/strings_ext.dart';
import 'package:hot_news/features/news/data/models/params.dart';

extension StringFromCountry on Object {
  String getCountry(Country country) {
    switch (country) {
      case Country.en:
        return Strings.en;
      case Country.fr:
        return Strings.fr;
      case Country.ru:
        return Strings.ru;
    }
  }
}

extension StringWithEMojiFromCountry on Country {
  String getCountryAndEmoji() {
    switch (this) {
      case Country.en:
        return '🚩 ${Strings.en}';
      case Country.fr:
        return '🏴 ${Strings.fr}';
      case Country.ru:
        return '🚩 ${Strings.ru}';
    }
  }
}

extension IndexToCountry on int {
  Country intToCountry() {
    switch (this) {
      case 0:
        return Country.en;

      case 1:
        return Country.fr;

      case 2:
        return Country.ru;
      default:
        return Country.en;
    }
  }
}

extension StringGetCountry on Country {
  String getAppCountry() {
    switch (this) {
      case Country.en:
        return Strings.en;
      case Country.fr:
        return Strings.fr;
      case Country.ru:
        return Strings.ru;
    }
  }
}
