import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hot_news/app_cores/app_prefs.dart';
import 'package:hot_news/app_cores/app_return_types/new_app_state.dart';
import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/app_cores/injection_container.dart';
import 'package:hot_news/features/news/data/models/params.dart';
import 'package:hot_news/features/news/domain/use_cases/abs_news_usecase.dart';
import 'package:hot_news/features/news/domain/use_cases/get_all_news_usecase.dart';
import 'package:hot_news/features/news/domain/use_cases/get_news_headline_usecase.dart';
import 'package:hot_news/features/news/domain/use_cases/search_all_news_usecase.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:hot_news/features/news/presentation/extension/int_to_category_extension.dart';

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
          NewsState.initial(),
        ) {
    getAllNews(
      0,
    );
  }

  Future<void> getAllNews(int chipsIndex) => _getNews(
        newsUseCase: getAllNewsUseCase,
        appPreferences: AppPreferences(
          hiveInterface: sl<HiveInterface>(),
          params: Params(
            category: chipsIndex.intToCategory(),
          ),
        ),
        index: chipsIndex,
      );
  Future<void> getNewsHeadline(int chipsIndex) => _getNews(
        newsUseCase: getNewsHeadlineUsecase,
        appPreferences: AppPreferences(
          hiveInterface: sl<HiveInterface>(),
          params: Params(
            category: chipsIndex.intToCategory(),
          ),
        ),
        index: chipsIndex,
      );
  Future<void> searchAllNews(
    int chipsIndex, {
    required String searchTerm,
  }) =>
      _getNews(
        newsUseCase: searchAllNewsUsecase,
        appPreferences: AppPreferences(
          hiveInterface: sl<HiveInterface>(),
          params: Params(
            category: chipsIndex.intToCategory(),
            searchPhrase: searchTerm,
          ),
        ),
        index: chipsIndex,
      );
  Future<void> _getNews({
    required AppPreferences appPreferences,
    required int index,
    required NewsUseCase newsUseCase,
  }) async {
    state = state.copyWithIsLoading(true);
    // final isConnected = await netWorkInfo.isConnected;
    // if (isConnected) {
    try {
      state.chipsIndex = index;
      final result = await newsUseCase.request(appPreferences: appPreferences);

      if (result.result == Result.failure) {
        state = NewsState(
          news: null,
          chipsIndex: state.chipsIndex,
          result: Result.failure,
          isLoading: false,
          errorMessage: ErrorStringConst.nullResult,
        );
      } else if (result.result == Result.success) {
        state = NewsState(
          news: result.news,
          chipsIndex: index,
          result: Result.success,
          isLoading: false,
          errorMessage: null,
        );
      } else if (result.result == Result.offline) {
        state = NewsState(
          news: null,
          chipsIndex: index,
          result: Result.offline,
          isLoading: false,
          errorMessage: ErrorStringConst.networkError,
        );
      }
    } catch (_) {
      state = NewsState.initial();
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
