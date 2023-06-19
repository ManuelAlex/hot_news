import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/extensions/strings_from_category.dart';
import 'package:hot_news/features/news/presentation/extension/int_to_category_extension.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/data/models/params.dart' as cat
    show Category;
import 'package:hot_news/features/news/presentation/state_mgt/provider/local_news_notifier_provider.dart';

class NewsSavedChipWrap extends ConsumerWidget {
  const NewsSavedChipWrap({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final chipIndexProvider = ref.watch(localNewStateProvider).chipsIndex;
    final selectedIndex = chipIndexProvider;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cat.Category.values
            .map((eachCat) => NewsSavedChip(
                  textString: eachCat.getCategory(eachCat),
                  onTap: () {
                    // if (eachCat.catToInt() == selectedIndex) {}
                    ref.read(localNewStateProvider.notifier).getSavedNews(
                          eachCat.catToInt(),
                        );
                  },
                  color: eachCat.catToInt() == selectedIndex
                      ? ColorManager.primary
                      : ColorManager.grey,
                  textColor: eachCat.catToInt() == selectedIndex
                      ? ColorManager.lightGrey
                      : ColorManager.darkGrey,
                ))
            .toList(),
      ),
    );
  }
}

class NewsSavedChip extends StatelessWidget {
  final String textString;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;

  const NewsSavedChip({
    super.key,
    required this.textString,
    required this.onTap,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            // color: Colors.grey[300],
            color: color,
            borderRadius: BorderRadius.circular(
              AppRadius.r32,
            ),
          ),
          child: IntrinsicWidth(
              child: Padding(
            padding: const EdgeInsets.only(
                top: AppPadding.p12,
                left: AppPadding.p16,
                right: AppPadding.p16),
            child: Text(
              textString,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: textColor,
                  ),
            ),
          )),
        ),
      ),
    );
  }
}
