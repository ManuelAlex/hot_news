import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/features/news/data/models/constants/json_string.dart';
import 'package:hot_news/features/news/domain/entities/sources.dart';

@immutable
class SourceModel extends Source {
  const SourceModel({
    String? id,
    String? name,
  }) : super();

  SourceModel.fromJson(
    Map<String, dynamic> json,
  ) : this(
          id: json[JsonStrings.id] ?? 'no Id',
          name: json[JsonStrings.name] ?? 'no Name',
        );
}
