import 'package:collection/collection.dart' show IterableEquality;
import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/features/news/domain/entities/news_entity.dart';

enum Result {
  success,
  failure,
  offline,
}

@immutable
class NewsResult {
  final Result result;
  final Iterable<News>? news;

  const NewsResult({
    required this.result,
    required this.news,
  });

  @override
  bool operator ==(covariant NewsResult other) =>
      result == other.result &&
      const IterableEquality<News>().equals(news, other.news) &&
      runtimeType == other.runtimeType;

  @override
  int get hashCode => Object.hashAll(
        [
          result,
          const IterableEquality<News>().hash(news),
          runtimeType,
        ],
      );
}
