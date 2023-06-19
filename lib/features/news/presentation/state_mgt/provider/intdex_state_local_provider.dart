import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/local_news_notifier_provider.dart';

final indexStateLocalProvider = Provider<int>((ref) {
  return ref.watch(localNewStateProvider).chipsIndex;
});
