import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/data/models/params.dart' as cat
    show Category;
import 'package:hot_news/features/news/presentation/extension/int_to_category_extension.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/local_news_notifier_provider.dart';

import 'package:hot_news/features/news/presentation/widgets/hot_cards.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ScrollHotCards extends ConsumerWidget {
  ScrollHotCards({Key? key}) : super(key: key);
  final PageController pageController = PageController();

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: PageView.builder(
              itemCount: cat.Category.values.length,
              controller: pageController,
              itemBuilder: (context, index) {
                return HotCards(
                  category: index.intToCategory(),
                );
              },
            ),
          ),
          const SizedBox(
            height: AppPadding.p4,
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: cat.Category.values.length,
            effect: ExpandingDotsEffect(
                dotColor: ColorManager.darkGrey.withOpacity(0.3),
                activeDotColor: ColorManager.lightBlueInd.withOpacity(0.5),
                dotHeight: AppSize.s10,
                dotWidth: AppSize.s10),
          ),
        ],
      ),
    );
  }
}
//  const SizedBox(
//             height: AppSize.s10,
//           ),
//           SmoothPageIndicator(
//             controller: pageController,
//             count: cat.Category.values.length,
//             effect: const ExpandingDotsEffect(),
//           ),