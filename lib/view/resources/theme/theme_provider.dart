part of 'color_themes.dart';

class ThemeProvider extends Cubit<ThemeMode> {
  ThemeProvider() : super(ThemeMode.light);

  void toggleTheme() {
    if (UserSharedPreferences.settings.prefs.theme != true) {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.system);
    }
  }
}
