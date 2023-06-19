import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/data/models/settings_state.dart';
import 'package:hot_news/features/news/presentation/state_mgt/notiers/settings_notifier.dart';

final settingsStateProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>(
  (_) => SettingsNotifier(),
);
