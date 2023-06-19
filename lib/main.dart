import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/injection_container.dart' as injection;
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:hot_news/features/news/presentation/resources/routes_manager.dart';
import 'package:hot_news/features/news/presentation/resources/theme_manager.dart';
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
    );
  }
}
