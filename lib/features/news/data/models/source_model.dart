import 'package:flutter/foundation.dart' show immutable;
import 'package:hot_news/features/news/data/models/constants/json_string.dart';
import 'package:hot_news/features/news/domain/entities/sources.dart';

@immutable
class SourceModel extends Source {
  const SourceModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  SourceModel.fromJson(
    Map<String, dynamic> json,
  ) : this(
          id: json[JsonStrings.id],
          name: json[JsonStrings.name],
        );
}
