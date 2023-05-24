import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/features/news/domain/use_cases/params.dart';

@immutable
abstract class NewsRepository {
  Future<NewsResult> getNewsHeadLines({
    required Params params,
  });

  Future<NewsResult> getAllNews({
    required Params params,
  });
  Future<NewsResult> searchAllNews({
    required Params params,
  });
}
