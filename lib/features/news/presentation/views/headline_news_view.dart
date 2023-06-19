import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/presentation/widgets/news_card.dart';
import 'package:hot_news/features/news/presentation/widgets/scroll_avartar_card.dart';
import 'package:hot_news/features/news/presentation/widgets/scroll_hot_news.dart';

class HeadLineNewsView extends ConsumerWidget {
  const HeadLineNewsView({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: CustomScrollView(slivers: [
            SliverAppBar(
              elevation: AppSize.s0,
              floating: true,
              centerTitle: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.46,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: ScrollHotCards(),
            ),
            SliverAppBar(
              pinned: true,
              elevation: AppSize.s0,
              toolbarHeight: AppSize.s120,
              centerTitle: false,
              expandedHeight: AppSize.s120,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: const ScrollAvatars(),
            ),
            const NewsCardList(),
          ]),
        ),
      ),
    );
  }
}
