import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/extensions/strings_from_country.dart';
import 'package:hot_news/features/news/data/models/params.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/routes_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/presentation/extension/country_to_int.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/cat_chip_state_provider.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/setting_provider.dart';

class OnBoardingCountryChipsWrap extends ConsumerWidget {
  final bool isSettingView;
  const OnBoardingCountryChipsWrap({
    Key? key,
    this.isSettingView = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontWeight: FontWeight.bold);
    final selectedIndex = ref.watch(onBoardingChipsStateProvider).countryIndex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: AppRadius.r20,
        ),
        Center(
          child: isSettingView
              ? const SizedBox()
              : Text(
                  NewsStringConst.language,
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
                children: Country.values
                    .map(
                      (country) => OnBoardingCountryChips(
                        onTap: () {
                          ref
                              .read(onBoardingChipsStateProvider.notifier)
                              .setIndex(country.countryToInt());
                        },
                        textString: country.getCountryAndEmoji(),
                        isTapped: country.countryToInt() == selectedIndex,
                        color: country.countryToInt() == selectedIndex
                            ? ColorManager.primary
                            : ColorManager.grey,
                        textColor: country.countryToInt() == selectedIndex
                            ? ColorManager.primary
                            : ColorManager.darkGrey,
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
        NextButton(
          isSettingsView: isSettingView,
        ),
      ],
    );
  }
}

class OnBoardingCountryChips extends ConsumerWidget {
  final String textString;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final bool isTapped;

  const OnBoardingCountryChips({
    Key? key,
    required this.onTap,
    required this.textString,
    required this.color,
    required this.textColor,
    required this.isTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: color,
                // color: isTapped ? ColorManager.primary : ColorManager.grey,
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
                            color: textColor,
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

class NextButton extends ConsumerWidget {
  final bool isSettingsView;
  const NextButton({
    this.isSettingsView = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppMagine.m32,
        right: AppMagine.m32,
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              if (isSettingsView == false) {
                ref.read(onBoardingChipsStateProvider.notifier).next();
                Navigator.pushReplacement(
                  context,
                  RouteGenerator.getRoute(
                    const RouteSettings(name: Routes.home),
                  ),
                );
              } else {
                ref.read(settingsStateProvider.notifier).setCon();
              }
            },
            style: Theme.of(context).elevatedButtonTheme.style,
            child: Text(
              isSettingsView
                  ? NewsStringConst.save
                  : NewsStringConst.saveAndCont,
            ),
          ),
          const Spacer(),
          if (isSettingsView == false)
            TextButton(
                onPressed: () {
                  ref.read(onBoardingChipsStateProvider.notifier).next();
                  Navigator.pushReplacement(
                    context,
                    RouteGenerator.getRoute(
                      const RouteSettings(name: Routes.home),
                    ),
                  );
                },
                child: Text(
                  NewsStringConst.skip,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.s14),
                )),
        ],
      ),
    );
  }
}
