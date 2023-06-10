import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/app_return_types/new_app_state.dart';
import 'package:hot_news/app_cores/injection_container.dart';
import 'package:hot_news/features/news/presentation/state_mgt/notiers/loca_news_notifier.dart';

final localNewStateProvider =
    StateNotifierProvider<LocalNewsNotifier, NewsState>((ref) {
  final newsStateNotifier = sl<LocalNewsNotifier>();

  return newsStateNotifier;
});
