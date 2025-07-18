import 'package:financial_manager/data/local/user_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleInfo {
  var locale = Locale(UserSharedPreferences.settings.prefs.locale ?? 'ru');

  String get localeCode => locale.languageCode;

  LocaleInfo(this.locale);
}

class LocaleProvider extends Cubit<LocaleInfo> {
  LocaleProvider() : super(LocaleInfo(Locale('ru')));

  void toggleLocale() {
    emit(
      LocaleInfo(Locale(UserSharedPreferences.settings.prefs.locale ?? 'ru')),
    );
  }
}
