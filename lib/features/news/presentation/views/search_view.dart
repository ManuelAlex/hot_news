import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/extensions/constants/strings_ext.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';
import 'package:hot_news/features/news/presentation/animation/loading_animation_view.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/news_state_provider.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/search_provider.dart';
import 'package:hot_news/features/news/presentation/widgets/news_card.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/news_iterable_provider.dart';
import 'package:hot_news/features/news/presentation/widgets/news_skeleton_loader.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  late final TextEditingController textController;
  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsState = ref.watch(newStateProvider);
    final newsList = newsState.news;

    if (newsState.isLoading) {
      return const NewsCardSkeletonLoader(
        itemCount: 3,
      );
    }
    if (newsList == null) {
      return const Center(
        child: NotFoundAnimationView(),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: AppSize.s32,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'News from all around the world',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: AppMagine.m12,
                ),
                Container(
                  height: AppSize.s50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(
                      AppRadius.r32,
                    ),
                  ),
                  child: TextField(
                    maxLines: 1,
                    onChanged: (value) {
                      setState(() {
                        value;
                      });
                    },
                    onSubmitted: (value) {
                      textController.clear();
                      setState(() {
                        value;
                      });
                    },
                    textInputAction: TextInputAction.search,
                    controller: textController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomContainer(
                        textString: Strings.general,
                      ),
                      CustomContainer(
                        textString: Strings.business,
                      ),
                      CustomContainer(
                        textString: Strings.science,
                      ),
                      CustomContainer(
                        textString: Strings.sports,
                      ),
                      CustomContainer(
                        textString: Strings.technology,
                      ),
                      CustomContainer(
                        textString: Strings.entertainment,
                      ),
                      CustomContainer(
                        textString: Strings.health,
                      ),
                      const SizedBox(
                        height: AppPadding.p16,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                _allNewsOrSearchedNews(
                  context,
                  newsList,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _allNewsOrSearchedNews(
    BuildContext context,
    Iterable<News> newsList,
  ) {
    final searchNews = ref.watch(searchNewsProvider(textController.text));
    if (textController.text.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return NewsCard(news: newsList.elementAt(index));
          },
          itemCount: newsList.length,
        ),
      );
    }

    return searchNews.when(
      data: (newsResult) {
        if (newsResult.isEmpty) {
          return const NotFoundAnimationView();
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return NewsCard(news: newsResult.elementAt(index));
            },
            itemCount: newsResult.length,
          ),
        );
      },
      error: (error, stackTrace) => const ErrorAnimationView(),
      loading: () => const NewsCardSkeletonLoader(itemCount: 3),
    );
  }
}

class CustomContainer extends ConsumerWidget {
  final String textString;

  CustomContainer({
    super.key,
    required this.textString,
  });
  bool onPressed = false;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final boolProvider = Provider(
      (ref) {
        if (!onPressed) {
          onPressed = true;
          print(onPressed);
          return onPressed;
        } else {
          print(onPressed);
          return onPressed;
        }
      },
    );
    final onPressedState = ref.watch(boolProvider);
    return GestureDetector(
      onTap: () {
        ref.read(boolProvider);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: onPressedState ? ColorManager.primary : Colors.grey[300],
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
              style: onPressedState
                  ? Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: ColorManager.white)
                  : Theme.of(context).textTheme.bodySmall,
            ),
          )),
        ),
      ),
    );
  }
}
