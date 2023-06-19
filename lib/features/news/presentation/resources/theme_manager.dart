import 'package:flutter/material.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/font_manager.dart';
import 'package:hot_news/features/news/presentation/resources/styles_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';

ThemeData getThemeData() => ThemeData(
      //main app color
      primaryColor: ColorManager.primary,
      useMaterial3: true,

      //card color
      cardTheme: CardTheme(
        color: ColorManager.white,
        elevation: AppSize.s4,
        shadowColor: ColorManager.darkGrey,
      ),
      //text theme
      textTheme: TextTheme(
        displayLarge:
            getBold(color: ColorManager.darkGrey, fontSize: FontSize.s18),
        displayMedium: getBold(
          color: ColorManager.darkGrey,
          fontSize: FontSize.s24,
        ),
        bodySmall: getRegular(
          color: ColorManager.customGrey,
          fontSize: FontSize.s14,
        ),
        headlineSmall: getItalics(
          color: ColorManager.white,
          fontSize: FontSize.s16,
        ),
        bodyLarge: getItalics(
          color: ColorManager.darkGrey,
          fontSize: FontSize.s22,
        ),
        bodyMedium: getItalics(
          color: ColorManager.darkGrey,
          fontSize: FontSize.s18,
        ),
      ),
      //appBar theme
      appBarTheme: AppBarTheme(
        color: ColorManager.white,
        centerTitle: true,
        elevation: AppSize.s0,
        titleTextStyle: getRegular(
          fontSize: FontSize.s16,
          color: ColorManager.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
