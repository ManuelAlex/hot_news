import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/extensions/strings_from_category.dart';
import 'package:hot_news/features/news/data/models/params.dart' as cat
    show Category;
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:hot_news/features/news/presentation/extension/int_to_category_extension.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/cat_chip_state_provider.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/setting_provider.dart';

class OnBoardingWrapChips extends ConsumerWidget {
  final bool isSettingView;
  const OnBoardingWrapChips({
    this.isSettingView = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontWeight: FontWeight.bold);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppRadius.r16,
        ),
        Center(
          child: isSettingView
              ? const SizedBox()
              : Text(
                  NewsStringConst.newsCat,
                  style: textTheme,
                ),
        ),
        const SizedBox(
          height: AppSize.s8,
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppRadius.r10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: cat.Category.values
                    .map(
                      (eachCat) => OnBoardingChips(
                        onPressed: () {
                          ref
                              .read(onBoardingChipsStateProvider.notifier)
                              .setIsTapped(eachCat.catToInt());
                        },
                        textString: eachCat.getStrWithEmojiFrfomCat()!,
                        isTapped: ref
                            .watch(onBoardingChipsStateProvider)
                            .catBoolList
                            .elementAt(eachCat.catToInt()),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: AppRadius.r32,
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p32),
          child: Row(
            children: [
              if (isSettingView != true)
                ElevatedButton(
                  onPressed: () {
                    ref.read(onBoardingChipsStateProvider.notifier).selectAll();
                  },
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        maximumSize: const MaterialStatePropertyAll(
                          Size(200, 50),
                        ),
                      ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select All',
                      ),
                      SizedBox(
                        width: AppPadding.p10,
                      ),
                      Icon(
                        Icons.check,
                      ),
                    ],
                  ),
                ),
              if (isSettingView == true)
                ElevatedButton(
                  onPressed: () {
                    ref.read(settingsStateProvider.notifier).setCat();
                  },
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        maximumSize: MaterialStatePropertyAll(
                          Size(
                            isSettingView ? 100 : 200,
                            50,
                          ),
                        ),
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        NewsStringConst.save,
                      ),
                      if (isSettingView != true)
                        const SizedBox(
                          width: AppPadding.p10,
                        ),
                      if (isSettingView != true)
                        const Icon(
                          Icons.check,
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class OnBoardingChips extends ConsumerWidget {
  final String textString;
  final VoidCallback onPressed;
  final bool isTapped;

  const OnBoardingChips({
    Key? key,
    required this.onPressed,
    required this.textString,
    required this.isTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: isTapped ? ColorManager.primary : ColorManager.grey,
                width: AppSize.s4),
            borderRadius: BorderRadius.circular(AppRadius.r10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSize.s4),
            child: IntrinsicWidth(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppPadding.p12,
                      left: AppPadding.p16,
                      right: AppPadding.p16,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: AppPadding.p4),
                      child: Text(
                        textString,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: isTapped
                                ? ColorManager.primary
                                : ColorManager.darkGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: AppSize.s14),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isTapped,
                    child: Icon(
                      Icons.check,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
