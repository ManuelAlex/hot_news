import 'package:collection/collection.dart' show IterableEquality;
import 'package:hot_news/app_cores/typedefs.dart';

class OnBoardingState {
  late Iterable<bool> catBoolList;
  final int countryIndex;
  final IsLoading isLoading;
  final bool? setOnBordingState;
  OnBoardingState({
    required this.catBoolList,
    required this.countryIndex,
    required this.isLoading,
    this.setOnBordingState,
  });

  @override
  bool operator ==(covariant OnBoardingState other) =>
      countryIndex == other.countryIndex &&
      isLoading == other.isLoading &&
      const IterableEquality().equals(
        catBoolList,
        other.catBoolList,
      );

  @override
  int get hashCode => Object.hashAll(
      [countryIndex, const IterableEquality().hash(catBoolList)]);
}
