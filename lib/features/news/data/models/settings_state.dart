class SettingsState {
  bool catState;
  bool conState;

  SettingsState({
    required this.catState,
    required this.conState,
  });

  @override
  bool operator ==(covariant SettingsState other) =>
      catState == other.catState && conState == other.conState;

  @override
  int get hashCode => Object.hashAll([
        catState,
        conState,
      ]);
}
