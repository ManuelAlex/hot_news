import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/presentation/state_mgt/notiers/chip_state_notifer.dart';

final chipStateProvider = StateNotifierProvider<ChipStateNotier, int>(
  (_) => ChipStateNotier(),
);
