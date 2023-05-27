import 'package:flutter/foundation.dart' show immutable;

@immutable
class Source {
  final String id;
  final String name;

  const Source({
    this.id = 'no id',
    this.name = 'no Name',
  });
}
