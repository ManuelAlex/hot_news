import 'package:flutter/material.dart';
import 'package:hot_news/features/news/data/models/params.dart' as cat
    show Category;
import 'package:hot_news/features/news/presentation/extension/int_to_category_extension.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';

import 'package:hot_news/features/news/presentation/widgets/avatar_card.dart';

class ScrollAvatars extends StatelessWidget {
  const ScrollAvatars({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: AppSize.s120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cat.Category.values.length,
          itemBuilder: (context, index) {
            return AvatarCard(
              category: index.intToCategory(),
            );
          },
        ),
      ),
    );
  }
}
