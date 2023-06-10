import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/app_cores/extensions/strings_from_category.dart';
import 'package:hot_news/features/news/data/models/params.dart' as cat
    show Category;
import 'package:hot_news/features/news/presentation/animation/loading_animation_view.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/get_cat_news_details_provider.dart';

class AvatarCard extends ConsumerWidget {
  final cat.Category category;
  const AvatarCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final newsByCatProvider = ref.watch(getNewsByCategoryProvider(category));

    return newsByCatProvider.when(
      data: (newsIterable) {
        final news = newsIterable.news;
        if (news == null) {
          return const NotFoundAnimationView();
        }
        return Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: CircleAvatar(
            radius: AppRadius.r50,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: CachedNetworkImage(
                    imageUrl: news.elementAt(1).urlToImage ??
                        NewsStringConst.defaultImageUrl,
                    placeholder: (context, url) => const LoadingAnimationView(),
                    errorWidget: (context, url, error) =>
                        const ImageAvatarErrorView(),
                    imageBuilder: (context, imageProvider) => Container(
                      width: AppSize.s100,
                      height: AppSize.s100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorManager.darkGrey.withOpacity(
                          0.5), // Add a background color with opacity
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p10),
                  child: Center(
                    child: Text(
                      getCategory(category) ?? NewsStringConst.defaultCat,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: ((error, stackTrace) => const ImageAvatarErrorView()),
      loading: () => Padding(
        padding: const EdgeInsets.all(AppPadding.p4),
        child: SizedBox(
          height: AppSize.s50,
          width: AppSize.s50,
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: CircularProgressIndicator(
              strokeWidth: AppSize.s16,
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageAvatarErrorView extends StatelessWidget {
  const ImageAvatarErrorView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: AppSize.s100,
        width: AppSize.s100,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s100),
              child: Image.asset(
                NewsStringConst.localImageSource,
                height: AppSize.s100,
                width: AppSize.s100,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ));
  }
}


// Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CachedNetworkImage(
//                 imageUrl: news.elementAt(1).urlToImage ??
//                     NewsStringConst.defaultImageUrl,
//                 placeholder: (context, url) => const LoadingAnimationView(),
//                 errorWidget: (context, url, error) =>
//                     const ErrorAnimationView(),
//                 imageBuilder: (context, imageProvider) => Container(
//                   width: AppSize.s100,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: imageProvider,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 category.getCategory(category) ?? NewsStringConst.title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         );