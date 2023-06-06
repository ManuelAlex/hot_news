import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/routes_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Timer? timer;
  void delay() {
    timer = Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        RouteGenerator.getRoute(
          const RouteSettings(name: Routes.home),
        ),
      );
    });
  }

  @override
  void initState() {
    delay();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightBlueInd,
      body: Center(
          child: Text(
        NewsStringConst.appName,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: AppSize.s32,
              color: ColorManager.white,
            ),
      )),
    );
  }
}
