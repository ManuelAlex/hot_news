import 'package:flutter/material.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class CircleAvataLoadingSkeleton extends StatelessWidget {
  const CircleAvataLoadingSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      items: 1,
      period: const Duration(seconds: 2),
      highlightColor: Colors.grey,
      direction: SkeletonDirection.ltr,
      builder: Padding(
        padding: const EdgeInsets.all(AppMagine.m8),
        child: Container(
          height: 50,
        ),
      ),
    );
  }
}
