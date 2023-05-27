import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/features/news/domain/entities/sources.dart';

@immutable
class News {
  final String? newsId;
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  const News({
    required this.newsId,
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  @override
  bool operator ==(covariant News other) =>
      newsId == other.newsId &&
      source == other.source &&
      author == other.author &&
      title == other.title &&
      description == other.description &&
      url == other.url &&
      urlToImage == other.urlToImage &&
      publishedAt == other.publishedAt &&
      content == other.content;

  @override
  int get hashCode => Object.hashAll(
        [
          newsId,
          author,
          title,
          description,
          url,
          urlToImage,
          publishedAt,
          content,
        ],
      );
}
