import 'package:hot_news/app_cores/network/network_info.dart';
import 'package:hot_news/features/news/data/data_sources/news_remote_data_source.dart';
import 'package:hot_news/features/news/data/models/news_model.dart';
import 'package:hot_news/features/news/data/models/params.dart';
import 'package:hot_news/app_cores/app_return_types/results.dart';
import 'package:hot_news/features/news/domain/repositories/new_repo.dart';

class NewRepositaryImpl extends NewsRepository {
  final NetWorkInfo netWorkInfo;
  final NewsRemoteDataSource newsRemoteDataSource;
  const NewRepositaryImpl({
    required this.netWorkInfo,
    required this.newsRemoteDataSource,
  });
  @override
  Future<NewsResult> getAllNews({required Params params}) => _getNew(
        getNews: newsRemoteDataSource.getAllNews(params: params),
      );

  @override
  Future<NewsResult> getNewsHeadLines({required Params params}) => _getNew(
        getNews: newsRemoteDataSource.getNewsHeadLines(params: params),
      );

  @override
  Future<NewsResult> searchAllNews({required Params params}) => _getNew(
        getNews: newsRemoteDataSource.searchAllNews(params: params),
      );

  Future<NewsResult> _getNew({
    required Future<Iterable<NewsModel>> getNews,
  }) async {
    final bool isConnected = await netWorkInfo.isConnected;
    if (isConnected) {
      try {
        final result = await getNews;
        print('-----------------------------------------');
        print(' result in NewRepositaryImpl is ${result.elementAt(0)}');
        return NewsResult(result: Result.success, news: result);
      } catch (_) {
        return const NewsResult(result: Result.failure, news: null);
      }
    } else {
      return const NewsResult(result: Result.offline, news: null);
    }
  }
}
