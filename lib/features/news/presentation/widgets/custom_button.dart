import 'package:flutter/material.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';

class CustomButtom extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const CustomButtom({
    required this.child,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.lightBlue,
        borderRadius: BorderRadius.circular(AppRadius.r16),
      ),
      child: child,
    );
  }
}
