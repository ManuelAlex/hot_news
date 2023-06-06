import 'package:flutter/material.dart' show immutable, FontWeight;

@immutable
class FontConstants {
  const FontConstants._();
  static const String fontFamily = 'NoticiaText';
}

@immutable
class FontWeightManager {
  const FontWeightManager._();
  static const FontWeight italic = FontWeight.w400;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight boldItalic = FontWeight.w700;
  static const FontWeight bold = FontWeight.w700;
}

@immutable
class FontSize {
  const FontSize._();
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s22 = 22.0;
  static const double s24 = 24.0;
}
