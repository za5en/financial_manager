part of 'settings_cubit.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState.loading() = Loading;
  const factory SettingsState.content(SettingsViewModel content) = Content;
  const factory SettingsState.error(Exception error) = CustomError;
}
