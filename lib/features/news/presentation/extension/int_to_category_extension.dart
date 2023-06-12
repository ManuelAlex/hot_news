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

extension CatToIndex on cat.Category {
  int catToInt() {
    switch (this) {
      case cat.Category.general:
        return 0;

      case cat.Category.entertainment:
        return 1;

      case cat.Category.business:
        return 2;

      case cat.Category.health:
        return 3;

      case cat.Category.science:
        return 4;

      case cat.Category.sports:
        return 5;

      case cat.Category.technology:
        return 6;
    }
  }
}
