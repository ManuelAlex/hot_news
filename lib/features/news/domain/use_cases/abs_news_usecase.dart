import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';

@immutable
abstract class NewsUseCase<Type, AppPreferences> {
  Future<NewsResult> request({
    required AppPreferences appPreferences,
  });
}

abstract class LocalDataNewsUseCase {
  Future<NewsResult> getCachedNews();
}

abstract class SaveNewsUseCase {
  Future<bool> save({
    required News news,
  });
}

abstract class DeletNewsUseCase {
  Future<bool> delete({
    required String keyString,
  });
}
