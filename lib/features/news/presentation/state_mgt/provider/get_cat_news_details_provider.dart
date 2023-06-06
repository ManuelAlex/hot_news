import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/features/news/data/models/params.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/news_state_provider.dart';

final getNewsByCategoryProvider =
    FutureProvider.autoDispose.family<NewsResult, Category>((
  ref,
  Category category,
) {
  return ref.read(newStateProvider.notifier).getAllNewsUseCase.request(
          params: Params(
        category: category,
      ));
});
