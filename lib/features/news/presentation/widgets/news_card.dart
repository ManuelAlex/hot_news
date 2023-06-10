import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/data/models/constants/json_string.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';
import 'package:hot_news/features/news/presentation/animation/loading_animation_view.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/get_news_provider.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/local_news_notifier_provider.dart';
import 'package:hot_news/features/news/presentation/views/news_details_view.dart';
import 'package:hot_news/features/news/presentation/widgets/double_row_string.dart';
import 'package:hot_news/features/news/presentation/extension/date_deducer_ext.dart';
import 'package:hot_news/features/news/presentation/widgets/news_skeleton_loader.dart';
import 'package:hot_news/features/news/presentation/widgets/show_bottom_sheet.dart';

class NewsCardList extends ConsumerWidget {
  const NewsCardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsState = ref.watch(getNewsProvider);

    return newsState.when(
      data: (data) {
        final newsList = data.news;

        if (newsList == null) {
          return const SliverFillRemaining(
            child: Center(
              child: Text("No data"),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final news = newsList.elementAt(index);
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailView(
                      news: news,
                    ),
                  ),
                ),
                child: NewsCard(
                  news: news,
                  onPressed: () {
                    showBottomSheet(
                      context: context,
                      builder: (_) {
                        return CustomShowBottomSheetWidget(
                          color: ColorManager.primary,
                          textToDisplay: 'Save',
                          onPressed: () {
                            ref
                                .read(localNewStateProvider.notifier)
                                .saveNews(news: newsList.elementAt(index));
                            Navigator.pop(_);
                          },
                        );
                      },
                    );
                  },
                ),
              );
            },
            childCount: newsList.length,
          ),
        );
      },
      error: (error, stackTrace) => const SliverFillRemaining(
        child: ErrorAnimationView(),
      ),
      loading: () => const SliverFillRemaining(
        child: NewsCardSkeletonLoader(
          itemCount: 1,
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final News news;
  final VoidCallback onPressed;

  const NewsCard({
    required this.news,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: AppSize.s4,
      child: Container(
        height: size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppRadius.r8,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(
                  AppPadding.p8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DoubleRowString(
                      str: news.author ?? NewsStringConst.author,
                      dateString: news.publishedAt?.getDateTime() ??
                          NewsStringConst.today,
                    ),
                    const SizedBox(
                      height: AppSize.s8,
                    ),
                    Expanded(
                      child: Text(
                        news.title ?? NewsStringConst.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        IntrinsicHeight(
                          child: Text(
                            news.source?[0] ?? NewsStringConst.source,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: onPressed,
                          icon: const Icon(
                            Icons.more_horiz,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.4,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppRadius.r8,
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        news.urlToImage ?? NewsStringConst.defaultImageUrl,
                    // imageBuilder: (context, imageProvider) {
                    //  // assets/images/news_image.jpg
                    // },
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,

                    errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.r32),
                      child: Padding(
                        padding: const EdgeInsets.all(AppRadius.r8),
                        child: Image.asset(
                          NewsStringConst.localImageSource,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
