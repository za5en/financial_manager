class SettingsLocal {
  final bool canAuthenticate;

  SettingsLocal._({required this.canAuthenticate});

  factory SettingsLocal.buildWith(bool canAuthenticate) =>
      SettingsLocal._(canAuthenticate: canAuthenticate);
}
