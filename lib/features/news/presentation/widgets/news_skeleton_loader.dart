import 'package:flutter/material.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class NewsCardSkeletonLoader extends StatelessWidget {
  final int itemCount;
  const NewsCardSkeletonLoader({
    super.key,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return SkeletonLoader(
      builder: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r16),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      height: 40,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      height: 40,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      height: 40,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r16),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      items: itemCount,
      period: const Duration(seconds: 2),
      highlightColor: Colors.grey,
      direction: SkeletonDirection.ltr,
    );
  }
}
