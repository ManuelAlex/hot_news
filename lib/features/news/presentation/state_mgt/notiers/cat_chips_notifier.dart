import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/app_prefs.dart';
import 'package:hot_news/app_cores/extensions/strings_from_country.dart';
import 'package:hot_news/app_cores/injection_container.dart';
import 'package:hot_news/features/news/data/models/params.dart' as cat
    show Category;
import 'package:hot_news/features/news/data/models/onboarding_state.dart';
import 'package:hot_news/features/news/presentation/extension/int_to_category_extension.dart';

class OnBoardingChipNotifier extends StateNotifier<OnBoardingState> {
  OnBoardingChipNotifier()
      : super(
          OnBoardingState(
            catBoolList: getBoolState(false),
            countryIndex: 0,
            isLoading: false,
          ),
        );
  final appPrefs = sl<AppPreferences>();

  void setIsTapped(int index) async {
    final currentState = state.catBoolList.toList();
    currentState[index] = !currentState[index];
    state.catBoolList = currentState;
    await appPrefs.putCategory(category: index.intToCategory());
    state = OnBoardingState(
      catBoolList: currentState,
      countryIndex: state.countryIndex,
      isLoading: state.isLoading,
    );
  }

  void selectAll() {
    state = OnBoardingState(
        catBoolList: getBoolState(true),
        countryIndex: state.countryIndex,
        isLoading: state.isLoading);
  }

  //country
  void setIndex(int index) async {
    state = OnBoardingState(
      catBoolList: state.catBoolList,
      countryIndex: index,
      isLoading: state.isLoading,
    );
    await appPrefs.putCountry(country: index.intToCountry());
  }

  void next() async {
    await appPrefs.putAppPrefBoolState();
  }

  void getOnBoardingState() async {
    final onBoardingSet = await appPrefs.onBoardingBoolState();
    state = OnBoardingState(
      catBoolList: state.catBoolList,
      countryIndex: state.countryIndex,
      isLoading: state.isLoading,
      setOnBordingState: onBoardingSet,
    );
  }
}

Iterable<bool> getBoolState(bool statebool) {
  return List<bool>.generate(
    cat.Category.values.length,
    (index) => statebool,
  );
}
