import 'package:hot_news/app_cores/extensions/constants/strings_ext.dart';
import 'package:hot_news/features/news/data/models/params.dart';

extension StringFromCountry on Object {
  String getCountry(Country country) {
    switch (country) {
      case Country.us:
        return Strings.us;
      case Country.fr:
        return Strings.fr;
      case Country.ru:
        return Strings.ru;
      case Country.mx:
        return Strings.mx;
      case Country.ng:
        return Strings.ng;
    }
  }
}
