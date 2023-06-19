import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/app_cores/app_prefs.dart';
import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';

@immutable
abstract class NewsRepository {
  const NewsRepository();
  Future<NewsResult> getNewsHeadLines({
    required AppPreferences appPreferences,
  });

  Future<NewsResult> getAllNews({
    required AppPreferences appPreferences,
  });
  Future<NewsResult> searchAllNews({
    required AppPreferences appPreferences,
  });

  Future<NewsResult> localCachedNews();
  Future<bool> saveNewslocally({
    required News news,
  });
  Future<bool> deleteNewslocally({
    required String keyString,
  });
}
