import 'package:flutter/material.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class HotCardSkeletonLoader extends StatelessWidget {
  const HotCardSkeletonLoader({super.key, required int itemCount});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SkeletonLoader(
      builder: Column(
        children: [
          Container(
            width: double.infinity,
            height: size.height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r16),
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 20,
            color: Colors.blue,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 20,
            color: Colors.blue,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 20,
            color: Colors.blue,
          ),
        ],
      ),
      items: 1,
      period: const Duration(seconds: 2),
      highlightColor: Colors.grey,
      direction: SkeletonDirection.ltr,
    );
  }
}
