import 'package:hot_news/app_cores/app_return_types/app_state_constants.dart';
import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/app_cores/typedefs.dart';
import 'package:collection/collection.dart' show IterableEquality;
import 'package:hot_news/features/news/domain/entities/news_entity.dart';

class NewsState {
  final Iterable<News>? news;
  final Result result;
  final IsLoading isLoading;
  late int chipsIndex;
  final ErrorMessage? errorMessage;
  NewsState({
    required this.news,
    required this.result,
    required this.isLoading,
    required this.errorMessage,
    required this.chipsIndex,
  });
  NewsState.initial()
      : news = [],
        result = Result.failure,
        isLoading = false,
        chipsIndex = 0,
        errorMessage = AppStateConst.loadingData;
  NewsState copyWithIsLoading(IsLoading isLoading) => NewsState(
        news: news,
        result: result,
        isLoading: isLoading,
        chipsIndex: chipsIndex,
        errorMessage: errorMessage,
      );

  @override
  bool operator ==(covariant NewsState other) =>
      const IterableEquality<News>().equals(news, other.news) &&
      result == other.result &&
      isLoading == other.isLoading &&
      chipsIndex == other.chipsIndex &&
      errorMessage == other.errorMessage &&
      runtimeType == other.runtimeType;

  @override
  int get hashCode => Object.hashAll(
        [
          const IterableEquality<News>().hash(news),
          result,
          isLoading,
          chipsIndex,
          errorMessage,
          runtimeType,
        ],
      );
}
