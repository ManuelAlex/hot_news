import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/features/news/data/models/constants/json_string.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:uuid/uuid.dart';

@immutable
class NewsModel extends News {
  const NewsModel({
    required String? newsId,
    required Map<String, dynamic>? source,
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
          source: json[JsonStrings.source] ?? {},
          newsId: json[JsonStrings.newsId] ?? const Uuid().v4(),
          author: json[JsonStrings.author] ?? '',
          title: json[JsonStrings.title] ?? '',
          description: json[JsonStrings.description] ?? '',
          url: json[JsonStrings.url] ?? '',
          urlToImage:
              json[JsonStrings.urlToImage] ?? NewsStringConst.defaultImageUrl,
          publishedAt: json[JsonStrings.publishedAt] ?? '',
          content: json[JsonStrings.content] ?? '',
        );

  factory NewsModel.fromHiveJson(Map<dynamic, dynamic>? json) {
    if (json == null) {
      throw ArgumentError.notNull('json');
    }
    final stringJson = json.cast<String, dynamic>();
    final source = stringJson[JsonStrings.source];
    final sourceMap = source != null && source is Map<dynamic, dynamic>
        ? {
            JsonStrings.id: source[JsonStrings.id]?.toString(),
            JsonStrings.name: source[JsonStrings.name]?.toString(),
          }
        : null;

    return NewsModel(
      source: sourceMap,
      newsId: stringJson[JsonStrings.newsId],
      author: stringJson[JsonStrings.author] ?? '',
      title: stringJson[JsonStrings.title] ?? '',
      description: stringJson[JsonStrings.description] ?? '',
      url: stringJson[JsonStrings.url] ?? '',
      urlToImage:
          stringJson[JsonStrings.urlToImage] ?? NewsStringConst.defaultImageUrl,
      publishedAt: stringJson[JsonStrings.publishedAt] ?? '',
      content: stringJson[JsonStrings.content] ?? '',
    );
  }
}
