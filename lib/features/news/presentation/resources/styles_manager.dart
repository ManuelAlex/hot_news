import 'package:flutter/material.dart';
import 'package:hot_news/features/news/presentation/resources/font_manager.dart';

TextStyle _getTextStyle({
  required double fontSize,
  required String fontFamily,
  required Color color,
  required FontWeight fontWeight,
}) =>
    TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: color,
    );
TextStyle getRegular({
  double fontSize = FontSize.s12,
  required Color color,
  String fontFamily = FontConstants.fontFamily,
}) =>
    _getTextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: FontWeightManager.regular,
    );
TextStyle getItalics({
  double fontSize = FontSize.s12,
  required Color color,
  String fontFamily = FontConstants.fontFamily,
}) =>
    _getTextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: FontWeightManager.italic,
    );
TextStyle getBoldItalic({
  double fontSize = FontSize.s18,
  required Color color,
  String fontFamily = FontConstants.fontFamily,
}) =>
    _getTextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: FontWeightManager.boldItalic,
    );
TextStyle getBold({
  double fontSize = FontSize.s18,
  required Color color,
  String fontFamily = FontConstants.fontFamily,
}) =>
    _getTextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: FontWeightManager.bold,
    );
