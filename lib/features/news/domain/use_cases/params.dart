import 'package:flutter/foundation.dart' show immutable;

@immutable
class Params {
  final String? country;
  final Category category;
  final String? sources;
  final String? searchPhrase;
  final int? pageSize;

  const Params(
    this.searchPhrase,
    this.sources,
  )   : country = 'us',
        category = Category.general,
        pageSize = 20;
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
