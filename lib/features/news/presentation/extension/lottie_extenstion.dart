import 'package:hot_news/features/news/presentation/animation/models/lottie_model.dart';

extension GetLottiePath on LotieAnimationModel {
  String getLottiePath() => 'assets/animation/$name.json';
}
