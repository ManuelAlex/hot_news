import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hot_news/app_cores/app_prefs.dart';
import 'package:hot_news/app_cores/network/network_info.dart';
import 'package:hot_news/features/news/data/data_sources/local_data_sources.dart';
import 'package:hot_news/features/news/data/data_sources/news_remote_data_source.dart';
import 'package:hot_news/features/news/data/models/params.dart';
import 'package:hot_news/features/news/data/repositories/new_repo_impl.dart';
import 'package:hot_news/features/news/domain/repositories/new_repo.dart';
import 'package:hot_news/features/news/domain/use_cases/get_all_news_usecase.dart';
import 'package:hot_news/features/news/domain/use_cases/get_local_news_usecase.dart';
import 'package:hot_news/features/news/domain/use_cases/get_news_headline_usecase.dart';
import 'package:hot_news/features/news/domain/use_cases/search_all_news_usecase.dart';
import 'package:hot_news/features/news/presentation/state_mgt/notiers/loca_news_notifier.dart';
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
  sl.registerFactory(
    () => LocalNewsNotifier(
        deleteLocalNewsUsecase: sl(),
        saveLocalNewsUsecase: sl(),
        getLocalNewsUsecase: sl()),
  );

  sl.registerLazySingleton(
    () => GetAllNewsUseCase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => AppPreferences(
      hiveInterface: sl(),
      params: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => const Params(),
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
  sl.registerLazySingleton(
    () => GetLocalNewsUsecase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => DeleteLocalNewsUsecase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SaveLocalNewsUsecase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<NewsRepository>(
    () => NewRepositaryImpl(
      netWorkInfo: sl(),
      newsRemoteDataSource: sl(),
      localDataSources: sl(),
    ),
  );
  sl.registerLazySingleton<LocalDataSources>(
    () => LocalDataSourcesImpl(
      hiveInterface: sl(),
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
  sl.registerLazySingleton<HiveInterface>(
    () => Hive,
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
