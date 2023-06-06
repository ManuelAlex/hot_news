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
import 'package:hot_news/features/news/presentation/views/hot_card_skeleton_loader.dart';
import 'package:hot_news/features/news/presentation/widgets/custom_button.dart';
import 'package:hot_news/features/news/presentation/widgets/double_row_string.dart';

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
    return newsByCatProvider.when(
      data: (newsIterable) {
        final news = newsIterable.news;
        if (news == null) {
          return const NotFoundAnimationView();
        }
        return Column(
          children: [
            _buildImageView(
              news,
              size.height * 0.25,
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
                    dateString: news.elementAt(0).publishedAt?.getDateTime(),
                  ),
                  const SizedBox(
                    height: AppMagine.m8,
                  ),
                  Text(
                    news.elementAt(0).title ?? NewsStringConst.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: AppMagine.m8,
                  ),
                  Row(
                    children: [
                      CustomButtom(
                        onTap: () {
                          //TODO:
                        },
                        child: _iconWithTitleButton(
                          context,
                          Icon(
                            Icons.share,
                            color: ColorManager.lightBlueInd,
                          ),
                          NewsStringConst.share,
                        ),
                      ),
                      const Spacer(),
                      CustomButtom(
                        onTap: () {
                          //TODO:
                        },
                        child: _iconWithTitleButton(
                          context,
                          Icon(
                            Icons.save,
                            color: ColorManager.lightBlueInd,
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
        );
      },
      error: ((error, stackTrace) => const ErrorAnimationView()),
      loading: () =>
          //  const Center(
          //       child: CircularProgressIndicator(),
          //     ));
          const HotCardSkeletonLoader(),
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
          children: [
            IconButton(
                onPressed: () {
                  // TODO:
                },
                icon: icon),
            Text(
              string,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: ColorManager.lightBlueInd),
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
                        getCategory(category) ?? NewsStringConst.defaultCat,
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




  



//  Row(
//                             children: [
//                               IconButton(
//                                   onPressed: () {
//                                     // TODO:
//                                   },
//                                   icon: const Icon(Icons.share)),
//                               Text(
//                                 'Share',
//                                 style: Theme.of(context).textTheme.bodyMedium,
//                               ),
//                             ],
//                           ),