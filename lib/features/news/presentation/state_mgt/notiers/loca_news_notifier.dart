import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/app_return_types/new_app_state.dart';
import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';
import 'package:hot_news/features/news/domain/use_cases/get_local_news_usecase.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';

class LocalNewsNotifier extends StateNotifier<NewsState> {
  final GetLocalNewsUsecase getLocalNewsUsecase;
  final SaveLocalNewsUsecase saveLocalNewsUsecase;
  final DeleteLocalNewsUsecase deleteLocalNewsUsecase;
  LocalNewsNotifier({
    required this.getLocalNewsUsecase,
    required this.saveLocalNewsUsecase,
    required this.deleteLocalNewsUsecase,
  }) : super(
          const NewsState.initial(),
        ) {
    getSavedNews();
  }
  Future<void> getSavedNews() async {
    state = state.copyWithIsLoading(true);
    try {
      final result = await getLocalNewsUsecase.getCachedNews();
      state = NewsState(
          news: result.news,
          result: result.result,
          isLoading: false,
          errorMessage: null);
      print('calling local saved news-----------------');
    } catch (_) {
      state = const NewsState(
          news: null,
          result: Result.failure,
          isLoading: false,
          errorMessage: ErrorStringConst.nullResult);
    }
  }

  Future<void> saveNews({required News news}) async {
    state = state.copyWithIsLoading(true);

    if (await saveLocalNewsUsecase.save(news: news)) {
      state = NewsState(
          news: state.news,
          result: Result.success,
          isLoading: false,
          errorMessage: null);
    } else {
      state = NewsState(
          news: state.news,
          result: Result.failure,
          isLoading: false,
          errorMessage: null);
    }
  }

  Future<void> deleteNews({required String keyString}) async {
    state = state.copyWithIsLoading(true);

    if (await deleteLocalNewsUsecase.delete(keyString: keyString)) {
      state = NewsState(
          news: state.news,
          result: Result.success,
          isLoading: false,
          errorMessage: null);
    } else {
      state = NewsState(
          news: state.news,
          result: Result.failure,
          isLoading: false,
          errorMessage: null);
    }
  }
}
