import 'package:flutter/foundation.dart' show immutable;

@immutable
class News {
  final String? id;
  final String? name;
  final String? author;
  final String? tittle;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  const News({
    required this.id,
    required this.name,
    required this.author,
    required this.tittle,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  @override
  bool operator ==(covariant News other) =>
      id == other.id &&
      name == other.name &&
      author == other.author &&
      tittle == other.tittle &&
      description == other.description &&
      url == other.url &&
      urlToImage == other.urlToImage &&
      publishedAt == other.publishedAt &&
      content == other.content;

  @override
  int get hashCode => Object.hashAll(
        [
          int,
          num,
          author,
          tittle,
          description,
          url,
          urlToImage,
          publishedAt,
          content,
        ],
      );
}
