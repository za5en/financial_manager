import 'package:flutter/material.dart';

class FMColorTheme {
  final ThemeData _light;
  ThemeData get light => _light;
  final ThemeData _dark;
  ThemeData get dark => _dark;

  FMColorTheme(this._light, this._dark);
}

class ColorThemes {
  static FMColorTheme get main => FMColorTheme(_light, _dark);
}

final _light = ThemeData(
  fontFamily: 'Roboto',
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(fontWeight: FontWeight.w600, fontSize: 12);
      }
      return const TextStyle(fontWeight: FontWeight.w500, fontSize: 12);
    }),
  ),
);

final _dark = ThemeData(fontFamily: 'Roboto');
