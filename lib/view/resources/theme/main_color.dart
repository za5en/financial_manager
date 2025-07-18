import 'package:financial_manager/data/local/user_shared_preferences.dart';
import 'package:flutter/material.dart';

class MainColor {
  static ValueNotifier<int> color = ValueNotifier(
    UserSharedPreferences.settings.prefs.tint ?? 0xFF2AE881,
  );
}
