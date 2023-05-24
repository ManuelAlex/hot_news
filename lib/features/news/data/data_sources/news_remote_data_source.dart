// https://newsapi.org/v2/everything?q=Apple&from=2023-05-23&sortBy=popularity&apiKey=API_KEY
//https://newsapi.org/v2/everything?pageSize=2&domains=techcrunch.com,thenextweb.com&apiKey=75b6a8e9caea4d73bddab280b40d616e
// var url = 'https://newsapi.org/v2/everything?' +
//           'q=Apple&' +
//           'from=2023-05-23&' +
//           'sortBy=popularity&' +
//           'apiKey=75b6a8e9caea4d73bddab280b40d616e';
//           https://newsapi.org/v2/everything?/q=Apple&from=2023-05-23&sortBy=popularity&apiKey=75b6a8e9caea4d73bddab280b40d616e
//           https://newsapi.org/v2/everything?q=bitcoin&&apiKey=75b6a8e9caea4d73bddab280b40d616e

import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/app_cores/extensions/strings_from_category.dart';
import 'package:hot_news/features/news/data/models/news_model.dart';
import 'package:hot_news/features/news/domain/use_cases/params.dart';
import 'package:http/http.dart' as http;

@immutable
abstract class NewsRemoteDataSource {
  Future<NewsModel> getNewsHeadLines({
    required Params params,
  });
  Future<NewsModel> getAllNews({
    required Params params,
  });
  Future<NewsModel> searchAllNews({
    required Params params,
  });
}

class ApiConstants {
  const ApiConstants._();
  static const String url = 'https://newsapi.org/v2/';
  static const String apiKey = '75b6a8e9caea4d73bddab280b40d616e';

  static const String everything = 'everything';
  static const String topHeadlines = 'top-headlines';
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;
  const NewsRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<NewsModel> getAllNews({
    required Params params,
  }) async {
    String generalKeyword = getCategory(
          params.category,
        ) ??
        Constants.generalKeyword;
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': ApiConstants.apiKey,
    };
    final response = await client.get(
      Uri.parse('${ApiConstants.url}?q=$generalKeyword'),
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return NewsModel.fromJson(
        json: jsonDecode(
          response.body,
        ),
      );
    }
    throw Exception();
  }

  @override
  Future<NewsModel> getNewsHeadLines({
    required Params params,
  }) {
    // TODO: implement getNewsHeadLines
    throw UnimplementedError();
  }

  @override
  Future<NewsModel> searchAllNews({
    required Params params,
  }) {
    // TODO: implement searchAllNews
    throw UnimplementedError();
  }
}

class Constants {
  Constants._();
  static const String generalKeyword =
      'business AND entertainment AND health AND sports AND technology AND science';
}
