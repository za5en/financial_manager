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
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Color.fromRGBO(212, 250, 230, 1),
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color.fromRGBO(42, 232, 129, 1);
      }
      return Colors.transparent;
    }),
    todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color.fromRGBO(42, 232, 129, 1);
      }
      return Colors.transparent;
    }),
    todayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color.fromRGBO(42, 232, 129, 1);
    }),
    todayBorder: BorderSide(color: Color.fromRGBO(42, 232, 129, 1)),
    cancelButtonStyle: ButtonStyle().copyWith(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
    ),
    confirmButtonStyle: ButtonStyle().copyWith(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
    ),
  ),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: Color.fromRGBO(212, 250, 230, 1),
    cancelButtonStyle: ButtonStyle().copyWith(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
    ),
    confirmButtonStyle: ButtonStyle().copyWith(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color.fromRGBO(42, 232, 129, 1),
    selectionColor: Color.fromRGBO(212, 250, 230, 1),
    selectionHandleColor: Color.fromRGBO(42, 232, 129, 1),
  ),
);

final _dark = ThemeData(fontFamily: 'Roboto');
