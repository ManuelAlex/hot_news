import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/data/models/settings_state.dart';

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier()
      : super(
          SettingsState(
            catState: false,
            conState: false,
          ),
        );

  void setCat() {
    state.catState = !state.catState;
    state = SettingsState(
      catState: state.catState,
      conState: state.conState,
    );
  }

  void setCon() {
    state.conState = !state.conState;
    state = SettingsState(
      catState: state.catState,
      conState: state.conState,
    );
  }
}
