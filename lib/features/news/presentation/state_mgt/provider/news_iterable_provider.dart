import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/news_state_provider.dart';

final newsIterableProvider = Provider(
  (ref) => ref.watch(newStateProvider).news,
);
