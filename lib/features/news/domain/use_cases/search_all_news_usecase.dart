import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/features/news/domain/repositories/new_repo.dart';
import 'package:hot_news/features/news/domain/use_cases/abs_news_usecase.dart';
import 'package:hot_news/features/news/data/models/params.dart';

class SearchAllNewsUsecase implements NewsUseCase<NewsResult, Params> {
  final NewsRepository repository;
  SearchAllNewsUsecase({
    required this.repository,
  });
  @override
  Future<NewsResult> request({required Params params}) async {
    try {
      final result = await repository.searchAllNews(params: params);
      return NewsResult(result: Result.success, news: result.news);
    } catch (_) {
      return const NewsResult(result: Result.failure, news: null);
    }
  }
}
