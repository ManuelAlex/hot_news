import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hot_news/app_cores/app_prefs.dart';
import 'package:hot_news/app_cores/injection_container.dart';
import 'package:hot_news/features/news/data/models/params.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/news_state_provider.dart';

final getNewsProvider = FutureProvider((ref) {
  return ref.watch(newStateProvider.notifier).getNewsHeadlineUsecase.request(
        appPreferences: AppPreferences(
            hiveInterface: sl<HiveInterface>(), params: const Params()),
      );
});
