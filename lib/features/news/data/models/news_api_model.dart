import 'package:hot_news/features/news/data/models/news_model.dart';

class NewsApiModel {
  final String? status;
  final int totalResults;
  final List<NewsModel> articles;

  NewsApiModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsApiModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> articleData = json['articles'];
    List<NewsModel> articles =
        articleData.map((data) => NewsModel.fromJson(json: data)).toList();

    return NewsApiModel(
      status: json['status'] ?? '',
      totalResults: json['totalResults'],
      articles: articles,
    );
  }
}
