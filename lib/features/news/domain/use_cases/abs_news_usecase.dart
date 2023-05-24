import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/app_cores/app_return_types/results.dart';

@immutable
abstract class NewsUseCase<Type, Params> {
  Future<NewsResult> request({
    required Params params,
  });
}
