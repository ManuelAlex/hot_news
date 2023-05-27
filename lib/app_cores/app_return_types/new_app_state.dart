import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/app_cores/app_return_types/app_state_constants.dart';
import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/app_cores/typedefs.dart';
import 'package:collection/collection.dart' show IterableEquality;
import 'package:hot_news/features/news/domain/entities/news_entity.dart';

@immutable
class NewsState {
  final Iterable<News>? news;
  final Result result;
  final IsLoading isLoading;
  final ErrorMessage? errorMessage;
  const NewsState({
    required this.news,
    required this.result,
    required this.isLoading,
    required this.errorMessage,
  });
  const NewsState.initial()
      : news = null,
        result = Result.failure,
        isLoading = false,
        errorMessage = AppStateConst.loadingData;
  NewsState copyWithIsLoading(IsLoading isLoading) => NewsState(
        news: news,
        result: result,
        isLoading: isLoading,
        errorMessage: errorMessage,
      );

  @override
  bool operator ==(covariant NewsState other) =>
      const IterableEquality<News>().equals(news, other.news) &&
      result == other.result &&
      isLoading == other.isLoading &&
      errorMessage == other.errorMessage &&
      runtimeType == other.runtimeType;

  @override
  int get hashCode => Object.hashAll(
        [
          const IterableEquality<News>().hash(news),
          result,
          isLoading,
          errorMessage,
          runtimeType,
        ],
      );
}
