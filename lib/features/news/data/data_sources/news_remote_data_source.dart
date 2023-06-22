import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/app_cores/app_prefs.dart';
import 'package:hot_news/app_cores/extensions/strings_from_category.dart';
import 'package:hot_news/features/news/data/api_constants.dart';
import 'package:hot_news/features/news/data/models/news_model.dart';
import 'package:http/http.dart' as http;

@immutable
abstract class NewsRemoteDataSource {
  Future<Iterable<NewsModel>> getNewsHeadLines({
    required AppPreferences appPreferences,
  });
  Future<Iterable<NewsModel>> getAllNews({
    required AppPreferences appPreferences,
  });
  Future<Iterable<NewsModel>> searchAllNews({
    required AppPreferences appPreferences,
  });
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;
  const NewsRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<Iterable<NewsModel>> getAllNews({
    required AppPreferences appPreferences,
  }) =>
      _getNews(appPreferences: appPreferences);

  @override
  Future<Iterable<NewsModel>> getNewsHeadLines({
    required AppPreferences appPreferences,
  }) =>
      _getNews(appPreferences: appPreferences);

  @override
  Future<Iterable<NewsModel>> searchAllNews({
    required AppPreferences appPreferences,
  }) =>
      _getNews(appPreferences: appPreferences);

  Future<Iterable<NewsModel>> _getNews({
    required AppPreferences appPreferences,
  }) async {
    final generalKeyword = appPreferences.params.category.getStringCategory();

    final strCountry = await appPreferences.getAppCountry();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    final response = await client.get(
      Uri.parse(
        '${ApiConstants.url}everything?q=$generalKeyword&language=$strCountry&apiKey=${ApiConstants.apiKey}',
      ),
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final dynamic responseBody = response.body;

      try {
        final Map<String, dynamic> json = jsonDecode(responseBody);

        final List<dynamic> articles = json['articles'];
        final docLists = articles.map<NewsModel>(
          (data) {
            return NewsModel.fromJson(json: data);
          },
        );

        return docLists;
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      throw Exception('API request failed');
    }
  }
}
