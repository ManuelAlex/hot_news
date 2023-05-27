import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:hot_news/app_cores/network/network_info.dart';
import 'package:hot_news/features/news/data/data_sources/news_remote_data_source.dart';
import 'package:hot_news/features/news/data/repositories/new_repo_impl.dart';
import 'package:hot_news/features/news/domain/repositories/new_repo.dart';
import 'package:hot_news/features/news/domain/use_cases/get_all_news_usecase.dart';
import 'package:hot_news/features/news/domain/use_cases/get_news_headline_usecase.dart';
import 'package:hot_news/features/news/domain/use_cases/search_all_news_usecase.dart';
import 'package:hot_news/features/news/presentation/state_mgt/notiers/news_notifier.dart';
import 'package:http/http.dart';

final sl = GetIt.instance;
void init() async {
  sl.registerFactory(
    () => NewsNotifer(
      getAllNewsUseCase: sl(),
      getNewsHeadlineUsecase: sl(),
      searchAllNewsUsecase: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetAllNewsUseCase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetNewsHeadlineUsecase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SearchAllNewsUsecase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<NewsRepository>(
    () => NewRepositaryImpl(
      netWorkInfo: sl(),
      newsRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<NetWorkInfo>(
    () => NetWorkInfoImpl(
      dataConnectionChecker: sl(),
    ),
  );
  sl.registerLazySingleton<DataConnectionChecker>(
    () => DataConnectionChecker(),
  );
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<Client>(
    () => Client(),
  );
}
