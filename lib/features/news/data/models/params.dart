import 'package:flutter/foundation.dart' show immutable;

@immutable
class Params {
  final Country country;
  final Category category;
  final String? sources;
  final String? searchPhrase;
  final int? pageSize;

  const Params({
    this.country = Country.en,
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
  en,
  fr,
  ru,
}

enum Category {
  general,
  business,
  entertainment,
  health,
  science,
  sports,
  technology,
}
