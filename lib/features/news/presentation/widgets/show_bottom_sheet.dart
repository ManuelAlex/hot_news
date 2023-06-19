import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';

class CustomBottomSheet {
  static void show(
    BuildContext context, {
    required VoidCallback onPressed,
    required String textToDisplay,
    required Color color,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return CustomShowBottomSheetWidget(
          onPressed: onPressed,
          textToDisplay: textToDisplay,
          color: color,
        );
      },
    );
  }
}

class CustomShowBottomSheetWidget extends ConsumerWidget {
  final String textToDisplay;
  final VoidCallback onPressed;
  final Color color;
  final VoidCallback? onPressd2;
  final bool isDouble;
  const CustomShowBottomSheetWidget({
    super.key,
    required this.onPressed,
    required this.textToDisplay,
    required this.color,
    this.onPressd2,
    this.isDouble = true,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Center(
          child: Column(
            children: [
              _simpleContainer(
                  onPressed2: onPressd2,
                  text2: 'Share',
                  text: textToDisplay,
                  onPressed: onPressed,
                  style2: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: AppSize.s16,
                      color: ColorManager.primary,
                      fontWeight: FontWeight.bold),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: AppSize.s16,
                        color: color,
                      ),
                  isDouble: isDouble),
              const SizedBox(
                height: AppMagine.m16,
              ),
              _simpleContainer(
                isDouble: false,
                text: 'Cancle',
                onPressed: () {
                  Navigator.pop(context);
                },
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: AppSize.s16,
                    color: ColorManager.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: AppMagine.m32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _simpleContainer({
    String? text2,
    VoidCallback? onPressed2,
    TextStyle? style2,
    required VoidCallback onPressed,
    required String text,
    required TextStyle style,
    required bool isDouble,
  }) {
    return Container(
      width: double.infinity,
      height: AppSize.s50,
      decoration: BoxDecoration(
        color: ColorManager.darkGrey.withOpacity(0.7),
        borderRadius: BorderRadius.circular(AppRadius.r10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: style,
            ),
          ),
          if (isDouble) const SizedBox(width: AppSize.s50),
          if (isDouble)
            TextButton(
              onPressed: onPressed2,
              child: Text(
                text2!,
                style: style2,
              ),
            ),
        ],
      ),
    );
  }
}
