import 'package:flutter/foundation.dart' show immutable;

@immutable
class Params {
  final String? country;
  final Category category;
  final String? sources;
  final String? searchPhrase;
  final int? pageSize;

  const Params({
    this.country = 'us',
    this.category = Category.general,
    this.pageSize = 20,
    this.sources,
    this.searchPhrase,
  });
}

enum NewSources {
  bbcnews,
}

enum Country {
  us,
  fr,
  ru,
  mx,
  ng,
}

enum Category {
  business,
  entertainment,
  general,
  health,
  science,
  sports,
  technology,
}
