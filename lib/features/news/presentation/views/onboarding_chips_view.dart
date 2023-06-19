import 'package:flutter/material.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/widgets/onboarding_chips_widget.dart';
import 'package:hot_news/features/news/presentation/widgets/onboarding_country_chip_widget.dart';

class OnBoardingChipsView extends StatelessWidget {
  const OnBoardingChipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.grey,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'App Preferences',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: ColorManager.primary, fontWeight: FontWeight.bold),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            OnBoardingWrapChips(),
            OnBoardingCountryChipsWrap(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
