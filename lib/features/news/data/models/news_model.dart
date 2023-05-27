import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/features/news/data/models/constants/json_string.dart';
import 'package:hot_news/features/news/data/models/source_model.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';
import 'package:hot_news/features/news/domain/entities/sources.dart';

@immutable
class NewsModel extends News {
  const NewsModel({
    required String? newsId,
    required Source? source,
    required String? author,
    required String? title,
    required String? description,
    required String? url,
    required String? urlToImage,
    required String? publishedAt,
    required String? content,
  }) : super(
          newsId: newsId,
          source: source,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt ?? '',
          content: content,
        );

  NewsModel.fromJson({required Map<String, dynamic> json})
      : this(
          source: SourceModel.fromJson(json[JsonStrings.source]),
          newsId: SourceModel.fromJson(json[JsonStrings.source]).id,
          author: json[JsonStrings.author] ?? '',
          title: json[JsonStrings.title] ?? '',
          description: json[JsonStrings.description] ?? '',
          url: json[JsonStrings.url] ?? '',
          urlToImage: json[JsonStrings.urlToImage] ?? '',
          publishedAt: json[JsonStrings.publishedAt] ?? '',
          content: json[JsonStrings.content] ?? '',
        );
}
