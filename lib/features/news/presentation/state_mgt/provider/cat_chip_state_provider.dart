import 'package:flutter_riverpod/flutter_riverpod.dart'
    show StateNotifierProvider;
import 'package:hot_news/features/news/data/models/onboarding_state.dart';
import 'package:hot_news/features/news/presentation/state_mgt/notiers/cat_chips_notifier.dart';

final onBoardingChipsStateProvider =
    StateNotifierProvider<OnBoardingChipNotifier, OnBoardingState>(
  (_) => OnBoardingChipNotifier(),
);
