import 'package:flutter/foundation.dart' show immutable;
import 'package:hive/hive.dart';
import 'package:hot_news/app_cores/extensions/constants/strings_ext.dart';
import 'package:hot_news/app_cores/extensions/strings_from_category.dart';
import 'package:hot_news/app_cores/extensions/strings_from_country.dart';
import 'package:hot_news/features/news/data/models/params.dart';

class AppPreferences {
  final HiveInterface hiveInterface;
  final Params params;
  AppPreferences({
    required this.hiveInterface,
    required this.params,
  });
  final boxName = AppPrefsConst.boxName;

  Future<bool?> getAppPrefBoolState() async {
    await hiveInterface.openBox(boxName);

    final newsCollection = hiveInterface.box(boxName);
    return await newsCollection.get(AppPrefsConst.getbool);
  }

  Future<String> getAppCategory() async {
    await hiveInterface.openBox(boxName);

    final newsCollection = hiveInterface.box(boxName);
    final cat = await newsCollection.get(AppPrefsConst.getCatKey);
    if (cat == null) {
      return Strings.general;
    } else {
      return cat.toString();
    }
  }

  Future<String> getAppCountry() async {
    await hiveInterface.openBox(boxName);

    final newsCollection = hiveInterface.box(boxName);
    final country = await newsCollection.get(AppPrefsConst.getCountryKey);
    if (country == null) {
      return Strings.en;
    }
    return country;
  }

  Future<void> putCategory({required Category category}) async {
    await hiveInterface.openBox(boxName);
    final newsCollection = hiveInterface.box(boxName);
    await newsCollection.put(
        AppPrefsConst.getCatKey, category.getStringCategory());
  }

  Future<void> putCountry({required Country country}) async {
    await hiveInterface.openBox(boxName);
    final newsCollection = hiveInterface.box(boxName);
    await newsCollection.put(
      AppPrefsConst.getCountryKey,
      country.getAppCountry(),
    );
  }

  Future<void> putAppPrefBoolState() async {
    await hiveInterface.openBox(boxName);

    final newsCollection = hiveInterface.box(boxName);
    await newsCollection.put(
      AppPrefsConst.getbool,
      true,
    );
  }

  Future<bool> onBoardingBoolState() async {
    await hiveInterface.openBox(boxName);

    final newsCollection = hiveInterface.box(boxName);
    return newsCollection.get(AppPrefsConst.getbool);
  }
}

@immutable
class AppPrefsConst {
  static const boxName = 'APP_PREFRENCES';
  static const getbool = 'GET_bool_KEY';
  static const getCatKey = 'GET_CATEGORY_KEY';
  static const getCountryKey = 'GET_COUNTRY_KEY';
}
