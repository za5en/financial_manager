import 'package:financial_manager/data/local/user_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_provider.dart';

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
  useMaterial3: true,
  fontFamily: 'Roboto',
  primaryColor: Color.fromRGBO(42, 232, 129, 1),
  scaffoldBackgroundColor: Color.fromRGBO(254, 247, 255, 1),
  // text
  primaryTextTheme: TextTheme(bodyMedium: TextStyle(color: Color(0xFF1C1C22))),
  // navbar
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Color.fromRGBO(243, 237, 247, 1),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(fontWeight: FontWeight.w600, fontSize: 12);
      }
      return const TextStyle(fontWeight: FontWeight.w500, fontSize: 12);
    }),
  ),
  // date picker
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
  // time picker
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

final _dark = ThemeData(
  useMaterial3: true,
  fontFamily: 'Roboto',
  primaryColor: Color.fromRGBO(42, 232, 129, 1),
  scaffoldBackgroundColor: Color(0xFF141414),
  // text
  primaryTextTheme: TextTheme(bodyMedium: TextStyle(color: Color(0xFFFEF7FF))),
  // navbar
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 46, 46, 46),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: Color(0xFFFEF7FF),
        );
      }
      return const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: Color(0xFFFEF7FF),
      );
    }),
  ),
  // date picker
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
  // time picker
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
