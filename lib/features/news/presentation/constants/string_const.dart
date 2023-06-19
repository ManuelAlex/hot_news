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
  static const String writtenBy = 'Written by';
  static const String unKnownAuthor = 'UnKnown author';
  static const String title = 'No Title';
  static const String author = 'No author';
  static const String newsCat = 'News Category';
  static const String language = 'Language';
  static const String checkNews = 'Check out this article ';
  static const String save = 'Save';
  static const String saveAndCont = 'Save and Continue';
  static const String skip = 'Skip ->';
  static const String delete = 'Delete';
  static const String deleteMessage = 'Unable to delete at the moment';
  static const String discover = 'Discover';
  static const String worldString = 'News from all around the world';
  static const String share = 'Share';
  static const String source = 'unknown source';

  static const String home = "Home";
  static const String settings = "Settings";
  static const String news = "News";
  static const String saved = "Saved";
  static const String noContent = 'oops no content';

  static const String clickLink = "Click to visit source website";
  static const String localImageSource = 'assets/images/news_image.jpg';
}
