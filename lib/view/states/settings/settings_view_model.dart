class SettingsViewModel {
  final bool canAuthenticate;
  SettingsViewModel._({required this.canAuthenticate});

  factory SettingsViewModel.buildWith(canAuthenticate) =>
      SettingsViewModel._(canAuthenticate: canAuthenticate);
}
