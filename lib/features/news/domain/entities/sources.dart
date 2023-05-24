import 'package:flutter/foundation.dart' show immutable;

@immutable
class Source {
  final String? id;
  final String? name;

  const Source({
    required this.id,
    required this.name,
  });
}
