import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/data/models/params.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/news_state_provider.dart';

final getNewsProvider = FutureProvider((ref) {
  return ref.watch(newStateProvider.notifier).getNewsHeadlineUsecase.request(
        params: const Params(),
      );
});
