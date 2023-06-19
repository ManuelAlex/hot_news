import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';
import 'package:hot_news/features/news/presentation/animation/loading_animation_view.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/intdex_state_local_provider.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/local_news_notifier_provider.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/saved_news_search_provider.dart';
import 'package:hot_news/features/news/presentation/views/news_details_view.dart';
import 'package:hot_news/features/news/presentation/widgets/custom_chips.dart';
import 'package:hot_news/features/news/presentation/widgets/news_card.dart';
import 'package:hot_news/features/news/presentation/widgets/news_skeleton_loader.dart';
import 'package:hot_news/features/news/presentation/widgets/show_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

class SavedNewsView extends ConsumerStatefulWidget {
  const SavedNewsView({super.key});

  @override
  ConsumerState<SavedNewsView> createState() => _SavedNewsViewState();
}

class _SavedNewsViewState extends ConsumerState<SavedNewsView> {
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
    final chipsIndex = ref.watch(indexStateLocalProvider);
    final newsState = ref.watch(localNewStateProvider);

    final newsList = newsState.news;

    if (newsState.isLoading) {
      return const NewsCardSkeletonLoader(
        itemCount: 3,
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
                  'Your Saved News',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: AppSize.s32,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'Search from within your saved news',
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
                const NewsChipWrap(),
                const SizedBox(
                  height: AppSize.s10,
                ),
                RefreshIndicator(
                  color: ColorManager.primary,
                  onRefresh: () async {
                    return await ref
                        .read(localNewStateProvider.notifier)
                        .getSavedNews(
                          chipsIndex,
                        );
                  },
                  child: newsState.news!.isEmpty
                      ? const Center(
                          child: NotFoundAnimationView(),
                        )
                      : _allNewsOrSearchedNews(
                          context,
                          newsList!.toList().reversed.toList(),
                        ),
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
    final chipsIndex = ref.watch(indexStateLocalProvider);
    final searchNews = ref.watch(savedNewsSearchProvider(textController.text));
    if (textController.text.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailView(
                      news: newsList.elementAt(index),
                    ),
                  )),
              child: NewsCard(
                news: newsList.elementAt(index),
                onPressed: () {
                  showBottomSheet(
                    context: context,
                    builder: (_) {
                      return CustomShowBottomSheetWidget(
                        onPressd2: () {
                          Share.share('${newsList.elementAt(index).url}',
                              subject: NewsStringConst.checkNews);
                          Navigator.of(context).pop();
                        },
                        color: Colors.red,
                        textToDisplay: NewsStringConst.delete,
                        onPressed: () {
                          if (newsList.elementAt(index).newsId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(NewsStringConst.deleteMessage),
                              ),
                            );
                            return;
                          }
                          ref.read(localNewStateProvider.notifier).deleteNews(
                              keyString: newsList.elementAt(index).newsId!);
                          ref.refresh(localNewStateProvider);
                          Navigator.pop(_);
                        },
                      );
                    },
                  );
                },
              ),
            );
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
              return NewsCard(
                news: newsResult.elementAt(index),
                onPressed: () {
                  showBottomSheet(
                    context: context,
                    builder: (_) {
                      return CustomShowBottomSheetWidget(
                        color: ColorManager.primary,
                        textToDisplay: 'Save',
                        onPressed: () {
                          if (newsList.elementAt(index).newsId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Unable to delete at the moment'),
                              ),
                            );
                            return;
                          }
                          ref.read(localNewStateProvider.notifier).deleteNews(
                              keyString: newsResult.elementAt(index).newsId!);
                          Navigator.pop(_);
                          ref
                              .read(localNewStateProvider.notifier)
                              .getSavedNews(chipsIndex);
                        },
                      );
                    },
                  );
                },
              );
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
