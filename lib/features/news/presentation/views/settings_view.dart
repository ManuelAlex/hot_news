import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/data/models/settings_state.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/setting_provider.dart';
import 'package:hot_news/features/news/presentation/widgets/custom_button.dart';
import 'package:hot_news/features/news/presentation/constants/settings_const.dart';
import 'package:hot_news/features/news/presentation/widgets/onboarding_chips_widget.dart';
import 'package:hot_news/features/news/presentation/widgets/onboarding_country_chip_widget.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final bool catState = ref.watch(settingsStateProvider).catState;
    final bool conState = ref.watch(settingsStateProvider).conState;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          SettingsConst.settings,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorManager.grey,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              const SizedBox(height: AppSize.s50),
              Container(
                height: AppSize.s80,
                width: AppSize.s80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppRadius.r10,
                  ),
                  color: ColorManager.lightBlue,
                ),
                child: Icon(
                  Icons.settings,
                  color: ColorManager.black,
                  size: AppSize.s50,
                ),
              ),
              const SizedBox(height: AppSize.s50),
              CustomListTile(
                textString: SettingsConst.lang,
                visibilityChild: const OnBoardingCountryChipsWrap(
                  isSettingView: true,
                ),
                callback: () {
                  ref.read(settingsStateProvider.notifier).setCon();
                },
                state: conState,
              ),
              const SizedBox(height: AppSize.s16),
              CustomListTile(
                textString: SettingsConst.newsCategory,
                callback: () {
                  ref.read(settingsStateProvider.notifier).setCat();
                },
                state: catState,
                visibilityChild: const OnBoardingWrapChips(
                  isSettingView: true,
                ),
              ),
              const SizedBox(height: AppSize.s16),
              CustomListTile(
                textString: SettingsConst.notification,
                callback: () {},
                state: false,
              ),
              const SizedBox(height: AppSize.s50),
            ],
          ),
        )),
      ),
    );
  }
}

class CustomListTile extends ConsumerWidget {
  final String textString;
  final Widget? visibilityChild;
  final VoidCallback callback;
  final bool state;

  const CustomListTile({
    required this.textString,
    this.visibilityChild,
    required this.callback,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r10),
        color: ColorManager.white,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              textString,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            trailing: CustomButton(
              onTap: callback,
              height: AppSize.s32,
              width: AppSize.s32,
              child: Icon(
                state
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.arrow_forward_ios,
                color: ColorManager.black,
                size: AppSize.s16,
              ),
            ),
          ),
          Visibility(
            visible: state,
            child: visibilityChild ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}
