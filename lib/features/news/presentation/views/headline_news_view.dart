import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(slivers: [
            SliverAppBar(
              elevation: 0,
              floating: true,
              centerTitle: false,
              expandedHeight: 400,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: ScrollHotCards(),
            ),
            SliverAppBar(
              pinned: true,
              elevation: 0,
              toolbarHeight: 120,
              centerTitle: false,
              expandedHeight: 120,
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
