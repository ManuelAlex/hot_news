import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hot_news/app_cores/app_prefs.dart';
import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/app_cores/injection_container.dart';
import 'package:hot_news/features/news/data/models/params.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/news_state_provider.dart';

final getNewsByCategoryProvider = FutureProvider.autoDispose
    .family<NewsResult, Category>((ref, category) async {
  return await ref
      .read(newStateProvider.notifier)
      .getNewsHeadlineUsecase
      .request(
        appPreferences: AppPreferences(
          hiveInterface: sl<HiveInterface>(),
          params: Params(category: category),
        ),
      );
});
