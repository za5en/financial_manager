import 'package:financial_manager/data/local/user_shared_preferences.dart';
import 'package:flutter/material.dart';

class PasswordSet {
  static ValueNotifier<bool> password = ValueNotifier(
    UserSharedPreferences.settings.prefs.password ?? false,
  );
}
