import 'package:flutter/material.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final VoidCallback onTap;
  final double height;
  final double width;

  const CustomButton({
    required this.child,
    required this.onTap,
    this.height = AppSize.s50,
    this.width = AppSize.s50,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? ColorManager.lightBlue;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(AppRadius.r16),
        ),
        child: child,
      ),
    );
  }
}
