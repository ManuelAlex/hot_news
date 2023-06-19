import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/data/models/params.dart' as cat
    show Category;
import 'package:hot_news/app_cores/extensions/strings_from_category.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hot_news/features/news/presentation/animation/loading_animation_view.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/get_cat_news_details_provider.dart';
import 'package:hot_news/features/news/presentation/extension/date_deducer_ext.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/local_news_notifier_provider.dart';
import 'package:hot_news/features/news/presentation/views/hot_card_skeleton_loader.dart';
import 'package:hot_news/features/news/presentation/views/news_details_view.dart';
import 'package:hot_news/features/news/presentation/widgets/custom_button.dart';
import 'package:hot_news/features/news/presentation/widgets/double_row_string.dart';
import 'package:hot_news/features/news/presentation/widgets/show_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

class HotCards extends ConsumerWidget {
  final cat.Category category;

  const HotCards({
    super.key,
    required this.category,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final size = MediaQuery.of(context).size;
    final newsByCatProvider = ref.watch(getNewsByCategoryProvider(category));
    final localLoadingProvider = Provider((ref) {
      final state = ref.watch(localNewStateProvider);
      return state.isLoading;
    });
    final localStateIsloading = ref.watch(localLoadingProvider);
    return newsByCatProvider.when(
      data: (newsIterable) {
        final news = newsIterable.news;
        if (news == null) {
          return const NotFoundAnimationView();
        }

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailView(
                  news: news.first,
                ),
              ),
            );
          },
          child: Column(
            children: [
              _buildImageView(
                news,
                size.height * 0.23,
                double.infinity,
                context,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p10,
                  left: AppPadding.p10,
                  right: AppPadding.p10,
                ),
                child: Column(
                  children: [
                    DoubleRowString(
                      str: NewsStringConst.trendingNo1,
                      dateString: news.first.publishedAt?.getDateTime(),
                    ),
                    const SizedBox(
                      height: AppMagine.m8,
                    ),
                    Text(
                      news.first.title ?? NewsStringConst.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: AppPadding.p8,
                    ),
                    Row(
                      children: [
                        CustomButton(
                          height: AppSize.s35,
                          width: AppSize.s120,
                          onTap: () {
                            showBottomSheet(
                              context: context,
                              builder: (_) {
                                return CustomShowBottomSheetWidget(
                                  isDouble: false,
                                  color: ColorManager.primary,
                                  textToDisplay: NewsStringConst.share,
                                  onPressed: () {
                                    Share.share('${news.elementAt(0).url}',
                                        subject: NewsStringConst.checkNews);
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            );
                          },
                          child: _iconWithTitleButton(
                            context,
                            Icon(
                              Icons.share,
                              color: ColorManager.lightBlueInd,
                              size: AppSize.s22,
                            ),
                            NewsStringConst.share,
                          ),
                        ),
                        const Spacer(),
                        CustomButton(
                          height: AppSize.s35,
                          width: AppSize.s120,
                          onTap: () async {
                            showBottomSheet(
                              context: context,
                              builder: (_) {
                                return CustomShowBottomSheetWidget(
                                  isDouble: false,
                                  color: ColorManager.primary,
                                  textToDisplay: NewsStringConst.save,
                                  onPressed: () {
                                    ref
                                        .read(localNewStateProvider.notifier)
                                        .saveNews(news: news.elementAt(0));
                                    Navigator.pop(_);
                                  },
                                );
                              },
                            );
                          },
                          child: localStateIsloading
                              ? const CircularProgressIndicator()
                              : _iconWithTitleButton(
                                  context,
                                  Icon(
                                    Icons.save,
                                    color: ColorManager.lightBlueInd,
                                    size: AppSize.s22,
                                  ),
                                  NewsStringConst.save,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppPadding.p8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      error: ((error, stackTrace) => const ErrorAnimationView()),
      loading: () =>
          //  const Center(
          //       child: CircularProgressIndicator(),
          //     ));
          const HotCardSkeletonLoader(
        itemCount: 1,
      ),
    );
  }

  Padding _iconWithTitleButton(
    BuildContext context,
    Icon icon,
    String string,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: AppPadding.p16),
      child: SizedBox(
        height: AppSize.s35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: AppSize.s8,
            ),
            Text(
              string,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorManager.lightBlueInd, fontSize: AppRadius.r12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageView(
      Iterable<News> news, double height, double width, BuildContext context) {
    return Card(
      elevation: AppRadius.r5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.r16),
        child: Stack(
          children: [
            CachedNetworkImage(
              height: height,
              width: width,
              fit: BoxFit.fill,
              imageUrl: news.elementAt(0).urlToImage ??
                  NewsStringConst.defaultImageUrl,
              progressIndicatorBuilder: (context, url, progress) =>
                  const LoadingAnimationView(),
              errorWidget: (context, url, error) => const ErrorAnimationView(),
            ),
            Padding(
              padding: const EdgeInsets.all(AppRadius.r16),
              child: Container(
                height: AppSize.s40,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(AppRadius.r32),
                ),
                child: IntrinsicWidth(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: AppPadding.p8,
                        bottom: AppPadding.p12,
                        left: AppPadding.p10,
                        right: AppPadding.p10,
                      ),
                      child: Text(
                        getCategory(category),
                        style: Theme.of(context).textTheme.headlineSmall,
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
