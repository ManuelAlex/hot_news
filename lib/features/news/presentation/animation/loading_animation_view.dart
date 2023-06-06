import 'package:hot_news/features/news/presentation/animation/animation_view.dart';
import 'package:hot_news/features/news/presentation/animation/models/lottie_model.dart';

class LoadingAnimationView extends LotieAnimationView {
  const LoadingAnimationView({
    super.key,
  }) : super(
          lotieAnimationModel: LotieAnimationModel.loading,
        );
}

class NotFoundAnimationView extends LotieAnimationView {
  const NotFoundAnimationView({
    super.key,
  }) : super(
          lotieAnimationModel: LotieAnimationModel.notFound,
        );
}

class ErrorAnimationView extends LotieAnimationView {
  const ErrorAnimationView({
    super.key,
  }) : super(
          lotieAnimationModel: LotieAnimationModel.error,
        );
}
