import 'package:flutter/material.dart' show immutable, Color;
import 'package:hot_news/features/news/presentation/extension/color_extension.dart';

@immutable
class ColorManager {
  const ColorManager._();
  static Color primary = "#0099ff".stringToColor();
  static Color darkGrey = "#000f1a".stringToColor();
  static Color white = "#ffffff".stringToColor();
  static Color customGrey = "#737373".stringToColor();
  static Color lightGrey = "#ebedeb".stringToColor();

  static Color black = '#0c0d0c'.stringToColor();
  static Color lightBlue = "#b3e0ff".stringToColor();
  static Color lightBlueInd = "#3399ff".stringToColor();
}
