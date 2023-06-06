import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/app_return_types/new_app_state.dart';
import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/features/news/data/models/params.dart';
import 'package:hot_news/features/news/domain/use_cases/abs_news_usecase.dart';
import 'package:hot_news/features/news/domain/use_cases/get_all_news_usecase.dart';
import 'package:hot_news/features/news/domain/use_cases/get_news_headline_usecase.dart';
import 'package:hot_news/features/news/domain/use_cases/search_all_news_usecase.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';

class NewsNotifer extends StateNotifier<NewsState> {
  final GetAllNewsUseCase getAllNewsUseCase;
  final GetNewsHeadlineUsecase getNewsHeadlineUsecase;
  final SearchAllNewsUsecase searchAllNewsUsecase;
  // final NetWorkInfo netWorkInfo;
  NewsNotifer({
    required this.getAllNewsUseCase,
    required this.getNewsHeadlineUsecase,
    required this.searchAllNewsUsecase,
    // required this.netWorkInfo,
  }) : super(
          const NewsState.initial(),
        ) {
    getAllNews();
  }

  Future<void> getAllNews() => _getNews(
        newsUseCase: getAllNewsUseCase,
        params: const Params(),
      );
  Future<void> getNewsHeadline() => _getNews(
        newsUseCase: getNewsHeadlineUsecase,
        params: const Params(),
      );
  Future<void> searchAllNews({
    required String searchTerm,
  }) =>
      _getNews(
        newsUseCase: searchAllNewsUsecase,
        params: Params(searchPhrase: searchTerm),
      );
  Future<void> _getNews({
    required Params params,
    required NewsUseCase newsUseCase,
  }) async {
    state = state.copyWithIsLoading(true);
    // final isConnected = await netWorkInfo.isConnected;
    // if (isConnected) {
    try {
      final result = await newsUseCase.request(params: params);

      if (result.result == Result.failure) {
        state = const NewsState(
          news: null,
          result: Result.failure,
          isLoading: false,
          errorMessage: ErrorStringConst.nullResult,
        );
      } else if (result.result == Result.success) {
        state = NewsState(
          news: result.news,
          result: Result.success,
          isLoading: false,
          errorMessage: null,
        );
      } else if (result.result == Result.offline) {
        state = const NewsState(
          news: null,
          result: Result.offline,
          isLoading: false,
          errorMessage: ErrorStringConst.networkError,
        );
      }
    } catch (_) {
      state = const NewsState.initial();
    }
    // }
    // else {
    //   state = const NewsState(
    //     news: null,
    //     result: Result.offline,
    //     isLoading: false,
    //     errorMessage: ErrorStringConst.networkError,
    //   );
    // }
  }
}
