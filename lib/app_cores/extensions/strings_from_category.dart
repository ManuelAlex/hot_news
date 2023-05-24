import 'package:hot_news/features/news/domain/use_cases/params.dart';

extension StringFromCategory on Object {
  String? getCategory(Category category) {
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
