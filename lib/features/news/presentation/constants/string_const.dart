import 'package:flutter/foundation.dart' show immutable;

@immutable
class ErrorStringConst {
  const ErrorStringConst._();
  static const networkError = 'No Network\n please check your connection';
  static const nullResult = 'Unable to retrieve data';
}

@immutable
class NewsStringConst {
  const NewsStringConst._();
  static const String appName = 'Hot News';
  static const String defaultImageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLP27uoWKc3tO33a1vh7i--Z3DXiCr4vTYAw&usqp=CAU';
  static const String defaultCat = 'businness';
  static const String trendingNo1 = '🚀  Trending No 1';
  static const String today = 'Today';
  static const String title = 'No Title';
  static const String author = 'No author';
  static const String save = 'Save';
  static const String share = 'Share';
  static const String source = 'Source';
  static const String localImageSource = 'assets/images/news_image.jpg';
}
