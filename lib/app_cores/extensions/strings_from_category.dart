import 'package:hot_news/features/news/data/models/params.dart';

extension StringFromCatC on Category {
  String getStringCategory() {
    switch (this) {
      case Category.business:
        return 'business';
      case Category.entertainment:
        return 'entertainment';
      case Category.general:
        return 'general';
      case Category.health:
        return 'health';
      case Category.science:
        return 'science';
      case Category.sports:
        return 'sports';

      case Category.technology:
        return 'technology';
    }
  }
}

extension StringFromCategory on Object {
  String getCategory(Category category) {
    switch (category) {
      case Category.business:
        return 'business';
      case Category.entertainment:
        return 'entertainment';
      case Category.general:
        return 'general';
      case Category.health:
        return 'health';
      case Category.science:
        return 'science';
      case Category.sports:
        return 'sports';

      case Category.technology:
        return 'technology';
    }
  }
}

extension StringWithEmojiFromCat on Category {
  String? getStrWithEmojiFrfomCat() {
    switch (this) {
      case Category.business:
        return '🅱️ Business';
      case Category.entertainment:
        return '🤪 Entertainment';
      case Category.general:
        return '🅰️ General ';
      case Category.health:
        return '🤕 Health';
      case Category.science:
        return '🧑‍💻 Science';
      case Category.sports:
        return '🏈 Sports';

      case Category.technology:
        return '🚀 Technology';
    }
  }
}
