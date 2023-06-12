import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/injection_container.dart' as injection;
import 'package:hot_news/app_cores/injection_container.dart';
import 'package:hot_news/app_cores/network/network_info.dart';
import 'package:hot_news/features/news/data/data_sources/local_data_sources.dart';
import 'package:hot_news/features/news/data/repositories/new_repo_impl.dart';
import 'package:hot_news/features/news/domain/repositories/new_repo.dart';
import 'package:hot_news/features/news/presentation/animation/loading_animation_view.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:hot_news/features/news/presentation/resources/routes_manager.dart';
import 'package:hot_news/features/news/presentation/resources/theme_manager.dart';
import 'package:http/http.dart';

import 'features/news/data/data_sources/news_remote_data_source.dart';
import 'features/news/presentation/state_mgt/provider/news_state_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  injection.init();
  await Hive.initFlutter();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: NewsStringConst.appName,
      debugShowCheckedModeBanner: false,
      theme: getThemeData(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashScreen,
      //home: const MainView(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({super.key});

  final NewsRemoteDataSourceImpl get =
      NewsRemoteDataSourceImpl(client: Client());
  final NewsRepository repoImp = NewRepositaryImpl(
    netWorkInfo: sl<NetWorkInfo>(),
    newsRemoteDataSource: sl<NewsRemoteDataSource>(),
    localDataSources: sl<LocalDataSources>(),
  );

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final newsState = ref.watch(newStateProvider);
    final newsList = newsState.news;

    if (newsState.isLoading) {
      return const LoadingAnimationView();
    }
    if (newsList == null) {
      return const Center(
        child: Text("No  data"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hot New'),
      ),
      body: ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            final news = newsList.elementAt(index);
            return Card(
              child: Column(
                children: [
                  Text(news.title ?? "no title"),
                  Text(news.description ?? "No descripton"),
                  Text(news.content ?? "No Content"),
                  Image.network(news.urlToImage ??
                      "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.wallpapersafari.com%2F81%2F92%2FVAD5R2.jpg&tbnid=sk8Hr0t-hfx6YM&vet=12ahUKEwiE_tXX65D_AhXOpCcCHXdwAd4QMygHegUIARDyAQ..i&imgrefurl=https%3A%2F%2Fwallpapersafari.com%2Fnew-wallpaper-images%2F&docid=4Mqt5UTXcOh4EM&w=1280&h=960&q=new%20image&ved=2ahUKEwiE_tXX65D_AhXOpCcCHXdwAd4QMygHegUIARDyAQ"),
                  Text(news.newsId ?? "No id"),
                ],
              ),
            );
          }),
    );
  }
}
