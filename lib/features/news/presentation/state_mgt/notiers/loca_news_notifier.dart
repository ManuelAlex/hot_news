import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/app_return_types/new_app_state.dart';
import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/app_cores/extensions/strings_from_category.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';
import 'package:hot_news/features/news/domain/use_cases/get_local_news_usecase.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:hot_news/features/news/presentation/extension/int_to_category_extension.dart';

class LocalNewsNotifier extends StateNotifier<NewsState> {
  final GetLocalNewsUsecase getLocalNewsUsecase;
  final SaveLocalNewsUsecase saveLocalNewsUsecase;
  final DeleteLocalNewsUsecase deleteLocalNewsUsecase;
  LocalNewsNotifier({
    required this.getLocalNewsUsecase,
    required this.saveLocalNewsUsecase,
    required this.deleteLocalNewsUsecase,
  }) : super(
          NewsState.initial(),
        ) {
    getSavedNews(0);
  }
  Future<void> getSavedNews(int index) async {
    state = state.copyWithIsLoading(true);
    try {
      state.chipsIndex = index;
      final result = await getLocalNewsUsecase.getCachedNews();
      if (state.chipsIndex == 0 && result.news != null) {
        state = NewsState(
            chipsIndex: state.chipsIndex,
            news: result.news?.toList().reversed,
            result: result.result,
            isLoading: false,
            errorMessage: null);
      } else {
        final filteredNews = state.news?.where(
          (news) =>
              news.title!
                  .toLowerCase()
                  .contains(index.intToCategory().getStringCategory()) ||
              news.description!
                  .toLowerCase()
                  .contains(index.intToCategory().getStringCategory()) ||
              news.content!
                  .toLowerCase()
                  .contains(index.intToCategory().getStringCategory()),
        );

        state = NewsState(
            chipsIndex: state.chipsIndex,
            news: filteredNews,
            result: result.result,
            isLoading: false,
            errorMessage: null);
      }
    } catch (_) {
      state = NewsState(
          chipsIndex: state.chipsIndex,
          news: null,
          result: Result.failure,
          isLoading: false,
          errorMessage: ErrorStringConst.nullResult);
    }
  }

  Future<void> saveNews({required News news}) async {
    state = NewsState(
      news: state.news,
      result: Result.offline,
      chipsIndex: state.chipsIndex,
      isLoading: true,
      errorMessage: null,
    );

    if (await saveLocalNewsUsecase.save(news: news)) {
      state = NewsState(
          chipsIndex: state.chipsIndex,
          news: state.news,
          result: Result.success,
          isLoading: false,
          errorMessage: null);
    } else {
      state = NewsState(
          chipsIndex: state.chipsIndex,
          news: state.news,
          result: Result.failure,
          isLoading: false,
          errorMessage: null);
    }
  }

  Future<void> deleteNews({required String keyString}) async {
    state = NewsState(
      chipsIndex: state.chipsIndex,
      news: state.news,
      result: Result.offline,
      isLoading: true,
      errorMessage: null,
    );

    if (await deleteLocalNewsUsecase.delete(keyString: keyString)) {
      state = NewsState(
          chipsIndex: state.chipsIndex,
          news: state.news,
          result: Result.success,
          isLoading: false,
          errorMessage: null);
    } else {
      state = NewsState(
          chipsIndex: state.chipsIndex,
          news: state.news,
          result: Result.failure,
          isLoading: false,
          errorMessage: null);
    }
  }
}
