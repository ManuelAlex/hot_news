import 'package:flutter/material.dart';
import 'package:hot_news/features/news/presentation/animation/models/lottie_model.dart';
import 'package:hot_news/features/news/presentation/extension/lottie_extenstion.dart';
import 'package:lottie/lottie.dart';

class LotieAnimationView extends StatelessWidget {
  final LotieAnimationModel lotieAnimationModel;
  final bool repeat;
  final bool reverse;
  const LotieAnimationView({
    super.key,
    required this.lotieAnimationModel,
    this.repeat = true,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) => Lottie.asset(
        lotieAnimationModel.getLottiePath(),
        repeat: repeat,
        reverse: reverse,
      );
}
