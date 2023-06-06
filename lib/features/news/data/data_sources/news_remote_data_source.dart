// https://newsapi.org/v2/everything?q=Apple&from=2023-05-23&sortBy=popularity&apiKey=API_KEY
//https://newsapi.org/v2/everything?pageSize=2&domains=techcrunch.com,thenextweb.com&apiKey=75b6a8e9caea4d73bddab280b40d616e
// var url = 'https://newsapi.org/v2/everything?' +
//           'q=Apple&' +
//           'from=2023-05-23&' +
//           'sortBy=popularity&' +
//           'apiKey=75b6a8e9caea4d73bddab280b40d616e';
//           https://newsapi.org/v2/everything?/q=Apple&from=2023-05-23&sortBy=popularity&apiKey=75b6a8e9caea4d73bddab280b40d616e
//           https://newsapi.org/v2/everything?q=bitcoin&apiKey=75b6a8e9caea4d73bddab280b40d616e

import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/app_cores/extensions/strings_from_category.dart';
import 'package:hot_news/features/news/data/api_constants.dart';
import 'package:hot_news/features/news/data/models/news_model.dart';
import 'package:hot_news/features/news/data/models/params.dart';
import 'package:http/http.dart' as http;

@immutable
abstract class NewsRemoteDataSource {
  Future<Iterable<NewsModel>> getNewsHeadLines({
    required Params params,
  });
  Future<Iterable<NewsModel>> getAllNews({
    required Params params,
  });
  Future<Iterable<NewsModel>> searchAllNews({
    required Params params,
  });
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;
  const NewsRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<Iterable<NewsModel>> getAllNews({
    required Params params,
  }) =>
      _getNews(params: params);

  @override
  Future<Iterable<NewsModel>> getNewsHeadLines({
    required Params params,
  }) =>
      _getNews(params: params);

  @override
  Future<Iterable<NewsModel>> searchAllNews({
    required Params params,
  }) =>
      _getNews(params: params);

  Future<Iterable<NewsModel>> _getNews({
    required Params params,
  }) async {
    String generalKeyword =
        getCategory(params.category) ?? Constants.generalKeyword;
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    final response = await client.get(
      Uri.parse(
        '${ApiConstants.url}everything?q=$generalKeyword&apiKey=75b6a8e9caea4d73bddab280b40d616e',
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
