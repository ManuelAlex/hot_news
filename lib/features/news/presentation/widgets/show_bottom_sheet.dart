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
  const CustomShowBottomSheetWidget({
    super.key,
    required this.onPressed,
    required this.textToDisplay,
    required this.color,
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
                  text: textToDisplay,
                  onPressed: onPressed,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: AppSize.s16,
                        color: color,
                      )),
              const SizedBox(
                height: AppMagine.m16,
              ),
              _simpleContainer(
                  text: 'Cancle',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: AppSize.s16,
                      color: ColorManager.primary,
                      fontWeight: FontWeight.bold)),
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
    required VoidCallback onPressed,
    required String text,
    required TextStyle style,
  }) {
    return Container(
      width: double.infinity,
      height: AppSize.s50,
      decoration: BoxDecoration(
        color: ColorManager.darkGrey.withOpacity(0.7),
        borderRadius: BorderRadius.circular(AppRadius.r10),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}
