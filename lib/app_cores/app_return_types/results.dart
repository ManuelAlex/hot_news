import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/features/news/domain/entities/news_entity.dart';

enum Result {
  success,
  failure,
}

@immutable
class NewsResult {
  final Result result;
  final News? news;

  const NewsResult({
    required this.result,
    required this.news,
  });

  @override
  bool operator ==(covariant NewsResult other) =>
      result == other.result &&
      news == other.news &&
      runtimeType == other.runtimeType;

  @override
  int get hashCode => Object.hashAll(
        [
          result,
          news,
          runtimeType,
        ],
      );
}
