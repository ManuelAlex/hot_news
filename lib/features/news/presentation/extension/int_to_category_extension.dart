import 'package:hot_news/features/news/data/models/params.dart' as cat
    show Category;

extension IndexToString on int {
  cat.Category intToCategory() {
    switch (this) {
      case 0:
        return cat.Category.business;

      case 1:
        return cat.Category.entertainment;

      case 2:
        return cat.Category.general;

      case 3:
        return cat.Category.health;

      case 4:
        return cat.Category.science;

      case 5:
        return cat.Category.sports;

      case 6:
        return cat.Category.technology;
    }
    throw Exception();
  }
}
