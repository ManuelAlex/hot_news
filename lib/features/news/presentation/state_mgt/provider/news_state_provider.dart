import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/app_return_types/new_app_state.dart';
import 'package:hot_news/features/news/presentation/state_mgt/notiers/news_notifier.dart';
import 'package:hot_news/app_cores/injection_container.dart';

final newStateProvider = StateNotifierProvider<NewsNotifer, NewsState>(
  (_) => sl<NewsNotifer>(),
);
