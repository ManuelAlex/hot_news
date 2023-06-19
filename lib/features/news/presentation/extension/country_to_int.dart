import 'package:hot_news/features/news/data/models/params.dart';

extension CountryToIndex on Country {
  int countryToInt() {
    switch (this) {
      case Country.en:
        return 0;

      case Country.fr:
        return 1;

      case Country.ru:
        return 2;
    }
  }
}
