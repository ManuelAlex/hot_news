import 'dart:collection';
import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/features/news/data/models/constants/json_string.dart';
import 'package:hot_news/features/news/data/models/news_model.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';
import 'package:hive/hive.dart';

@immutable
abstract class LocalDataSources {
  Future<Iterable<News>> getLocalCachedNews();
  Future<bool> saveNewLocally({required News news});
  Future<bool> deleteNewLocally({required String keyString});
}

const boxName = "NEWS_BOX";

class LocalDataSourcesImpl implements LocalDataSources {
  final HiveInterface hiveInterface;

  LocalDataSourcesImpl({required this.hiveInterface});

  @override
  Future<Iterable<News>> getLocalCachedNews() async {
    await hiveInterface.openBox(boxName);
    final newsCollection = hiveInterface.box(boxName);

    if (newsCollection.isEmpty) {
      return [];
    } else {
      return newsCollection.values.map<NewsModel>(
        (news) => NewsModel.fromHiveJson(news),
      );
    }
  }

  @override
  Future<bool> saveNewLocally({
    required News news,
  }) async {
    final payload = LocalNewsHivePayLoad(
      newsId: news.newsId!,
      source: {
        FieldModelConst.id: news.source?[JsonStrings.id] ?? '',
        FieldModelConst.name: news.source?[JsonStrings.name] ?? '',
      },
      content: news.content!,
      author: news.author!,
      description: news.description!,
      title: news.title!,
      publishedAt: news.publishedAt!,
      url: news.url!,
      urlToImage: news.urlToImage!,
    );

    try {
      await hiveInterface.openBox(boxName);
      final newsCollection = hiveInterface.box(
        boxName,
      );
      if (!newsCollection.containsKey(news.newsId!)) {
        await newsCollection.put(news.newsId, payload);
      }

      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteNewLocally({required String keyString}) async {
    await hiveInterface.openBox(boxName);
    final newsCollection = hiveInterface.box(boxName);

    try {
      if (newsCollection.containsKey(keyString)) {
        newsCollection.delete(keyString);
      }

      return true;
    } catch (_) {
      return false;
    }
  }
}

class LocalNewsHivePayLoad extends MapView {
  LocalNewsHivePayLoad({
    required String newsId,
    required Map<String, String> source,
    required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String content,
  }) : super({
          FieldModelConst.newsId: newsId,
          FieldModelConst.source: source,
          FieldModelConst.author: author,
          FieldModelConst.title: title,
          FieldModelConst.description: description,
          FieldModelConst.url: url,
          FieldModelConst.urlToImage: urlToImage,
          FieldModelConst.publishedAt: publishedAt,
          FieldModelConst.content: content,
        });
}

class FieldModelConst {
  const FieldModelConst._();
  static const String id = 'id';
  static const String newsId = 'newsId';
  static const String name = 'name';
  static const String source = 'source';
  static const String author = 'author';
  static const String title = 'title';
  static const String description = 'description';
  static const String url = 'url';
  static const String urlToImage = 'urlToImage';
  static const String publishedAt = 'publishedAt';
  static const String content = 'content';
}
