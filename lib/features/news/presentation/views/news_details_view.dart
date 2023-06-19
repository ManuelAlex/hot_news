import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';
import 'package:hot_news/features/news/presentation/animation/loading_animation_view.dart';
import 'package:hot_news/features/news/presentation/constants/string_const.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/local_news_notifier_provider.dart';
import 'package:hot_news/features/news/presentation/widgets/custom_button.dart';
import 'package:hot_news/features/news/presentation/widgets/double_row_string.dart';
import 'package:hot_news/features/news/presentation/extension/date_deducer_ext.dart';
import 'package:hot_news/features/news/presentation/widgets/show_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailView extends ConsumerWidget {
  final News news;

  const NewsDetailView({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(
        context,
        ref,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title ?? NewsStringConst.title,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppSize.s10),
                child: Text(
                  '${NewsStringConst.writtenBy} :  ${news.author ?? NewsStringConst.unKnownAuthor}',
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: AppPadding.p8,
              ),
              _buildImage(size),
              _doubleText(),
              if (news.url != null) _newsLink(context),
              const SizedBox(
                height: AppRadius.r10,
              ),
              Text(
                news.description ?? NewsStringConst.noContent,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: AppRadius.r10,
              ),
              Text(
                news.content ?? NewsStringConst.noContent,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: AppSize.s100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _doubleText() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: DoubleRowString(
        str:
            '${NewsStringConst.source} : ${news.source![1].toString() == "null" ? "UnKnown" : news.source![1].toString()}',
        dateString: news.publishedAt?.getDateTime(),
      ),
    );
  }

  GestureDetector _newsLink(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(news.url!));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: AppPadding.p16),
        child: Text(
          NewsStringConst.clickLink,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Colors.blue,
                fontSize: AppSize.s16,
              ),
        ),
      ),
    );
  }

  ClipRRect _buildImage(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.r8),
      child: CachedNetworkImage(
        height: size.height * 0.25,
        width: double.infinity,
        fit: BoxFit.fill,
        imageUrl: news.urlToImage ?? NewsStringConst.defaultImageUrl,
        progressIndicatorBuilder: (context, url, progress) =>
            const LoadingAnimationView(),
        errorWidget: (context, url, error) => const ErrorAnimationView(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: CustomButton(
        color: ColorManager.lightGrey,
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: ColorManager.black,
        ),
      ),
      actions: [
        CustomButton(
          color: ColorManager.lightGrey,
          onTap: () {
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
                        .saveNews(news: news);
                    Navigator.pop(_);
                  },
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSize.s16),
            child: Icon(
              Icons.save,
              color: ColorManager.darkGrey,
            ),
          ),
        ),
        const SizedBox(
          width: AppMagine.m8,
        ),
        CustomButton(
          color: ColorManager.lightGrey,
          onTap: () {
            showBottomSheet(
              context: context,
              builder: (context) {
                return CustomShowBottomSheetWidget(
                  isDouble: false,
                  color: ColorManager.primary,
                  textToDisplay: NewsStringConst.share,
                  onPressed: () {
                    Share.share('${news.url}',
                        subject: NewsStringConst.checkNews);
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSize.s16),
            child: Icon(
              Icons.share,
              color: ColorManager.darkGrey,
            ),
          ),
        ),
        const SizedBox(
          width: AppMagine.m8,
        ),
      ],
    );
  }
}
