import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';
import 'package:hot_news/features/news/presentation/animation/loading_animation_view.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/intdex_state_local_provider.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/local_news_notifier_provider.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/news_state_provider.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/search_provider.dart';
import 'package:hot_news/features/news/presentation/views/news_details_view.dart';
import 'package:hot_news/features/news/presentation/widgets/custom_chips.dart';
import 'package:hot_news/features/news/presentation/widgets/news_card.dart';

import 'package:hot_news/features/news/presentation/widgets/news_skeleton_loader.dart';
import 'package:hot_news/features/news/presentation/widgets/show_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

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
    final chipIndex = ref.watch(indexStateLocalProvider);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                NewsStringConst.discover,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: AppSize.s32,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                NewsStringConst.worldString,
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
              if (newsState.isLoading)
                NewsCardSkeletonLoader(
                  itemCount: newsList?.length ?? 15,
                ),
              if (newsList == null)
                Center(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return ref
                          .read(newStateProvider.notifier)
                          .getAllNews(chipIndex);
                    },
                    child: const NotFoundAnimationView(),
                  ),
                ),
              if (newsList != null)
                RefreshIndicator(
                  onRefresh: () {
                    return ref
                        .read(newStateProvider.notifier)
                        .getAllNews(chipIndex);
                  },
                  child: _allNewsOrSearchedNews(
                    context,
                    newsList,
                  ),
                ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _allNewsOrSearchedNews(
    BuildContext context,
    Iterable<News> newsList,
  ) {
    final chipIndex = ref.watch(indexStateLocalProvider);
    final searchNews = ref.watch(searchNewsProvider(textController.text));
    if (textController.text.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailView(
                      news: newsList.elementAt(index),
                    ),
                  ),
                );
              },
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
                        color: ColorManager.primary,
                        textToDisplay: NewsStringConst.save,
                        onPressed: () {
                          ref
                              .read(localNewStateProvider.notifier)
                              .saveNews(news: newsList.elementAt(index));
                          Navigator.pop(_);
                          ref
                              .read(localNewStateProvider.notifier)
                              .getSavedNews(chipIndex);
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
          return RefreshIndicator(
            onRefresh: () {
              return ref.read(newStateProvider.notifier).getAllNews(chipIndex);
            },
            child: const NotFoundAnimationView(),
          );
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailView(
                        news: newsResult.elementAt(index),
                      ),
                    ),
                  );
                },
                child: NewsCard(
                  news: newsResult.elementAt(index),
                  onPressed: () {
                    showBottomSheet(
                      context: context,
                      builder: (_) {
                        return CustomShowBottomSheetWidget(
                          onPressd2: () {
                            Share.share('${newsResult.elementAt(index).url}',
                                subject: NewsStringConst.checkNews);
                            Navigator.of(context).pop();
                          },
                          color: ColorManager.primary,
                          textToDisplay: 'Save',
                          onPressed: () {
                            ref
                                .read(localNewStateProvider.notifier)
                                .saveNews(news: newsResult.elementAt(index));
                            Navigator.pop(_);
                            ref
                                .read(localNewStateProvider.notifier)
                                .getSavedNews(chipIndex);
                          },
                        );
                      },
                    );
                  },
                ),
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







// final newsState = ref.watch(newStateProvider);
//     final newsList = newsState.news;

//     if (newsState.isLoading) {
//       return const NewsCardSkeletonLoader(
//         itemCount: 3,
//       );
//     }
//     if (newsList == null) {
//       return const Center(
//         child: NotFoundAnimationView(),
//       );
//     }
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(AppPadding.p8),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Discover',
//                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                         fontSize: AppSize.s32,
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//                 Text(
//                   'News from all around the world',
//                   style: Theme.of(context).textTheme.bodySmall,
//                 ),
//                 const SizedBox(
//                   height: AppMagine.m12,
//                 ),
//                 Container(
//                   height: AppSize.s50,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(
//                       AppRadius.r32,
//                     ),
//                   ),
//                   child: TextField(
//                     maxLines: 1,
//                     onChanged: (value) {
//                       setState(() {
//                         value;
//                       });
//                     },
//                     onSubmitted: (value) {
//                       textController.clear();
//                       setState(() {
//                         value;
//                       });
//                     },
//                     textInputAction: TextInputAction.search,
//                     controller: textController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       prefixIcon: Icon(
//                         Icons.search,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const NewsChipWrap(),
//                 const SizedBox(
//                   height: AppSize.s10,
//                 ),
//                 _allNewsOrSearchedNews(
//                   context,
//                   newsList,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );