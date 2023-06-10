import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/domain/entities/news_entity.dart';
import 'package:hot_news/features/news/presentation/state_mgt/provider/local_news_notifier_provider.dart';

final savedNewsSearchProvider =
    StreamProvider.family.autoDispose<Iterable<News>, String>(
  (ref, String searchTearm) {
    final controller = StreamController<Iterable<News>>();
    final iterableOfNews = ref.watch(localNewStateProvider).news;
    if (iterableOfNews == null) {
      controller.add([]);
    } else {
      final sub = iterableOfNews.where(
        (news) =>
            news.title!.toLowerCase().contains(searchTearm) ||
            news.description!.toLowerCase().contains(searchTearm) ||
            news.content!.toLowerCase().contains(searchTearm),
      );
      controller.sink.add(
        sub,
      );
    }
    ref.onDispose(() {
      controller.close();
    });
    return controller.stream;
  },
);
