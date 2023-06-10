import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';
import 'package:hot_news/features/news/domain/repositories/new_repo.dart';
import 'package:hot_news/features/news/domain/use_cases/abs_news_usecase.dart';

@immutable
class GetLocalNewsUsecase implements LocalDataNewsUseCase {
  final NewsRepository repository;
  const GetLocalNewsUsecase({required this.repository});
  @override
  Future<NewsResult> getCachedNews() async {
    final result = await repository.localCachedNews();
    try {
      return NewsResult(result: result.result, news: result.news);
    } catch (_) {
      return const NewsResult(result: Result.failure, news: null);
    }
  }
}

@immutable
class SaveLocalNewsUsecase implements SaveNewsUseCase {
  final NewsRepository repository;
  const SaveLocalNewsUsecase({required this.repository});

  @override
  Future<bool> save({required News news}) async {
    if (await repository.saveNewslocally(news: news)) {
      return true;
    } else {
      return false;
    }
  }
}

@immutable
class DeleteLocalNewsUsecase implements DeletNewsUseCase {
  final NewsRepository repository;
  const DeleteLocalNewsUsecase({required this.repository});

  @override
  Future<bool> delete({required int newsIndex}) async {
    if (await repository.deleteNewslocally(newsIndex: newsIndex)) {
      return true;
    } else {
      return false;
    }
  }
}
