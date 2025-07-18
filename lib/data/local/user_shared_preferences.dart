import 'package:shared_preferences/shared_preferences.dart';

class PrefName {
  const PrefName(this.name);
  final String name;
}

class SettingsPrefsNames {
  const SettingsPrefsNames();

  final theme = const PrefName('theme');
  final tint = const PrefName('tint');
  final haptic = const PrefName('haptic');
  final password = const PrefName('password');
  final biometrics = const PrefName('biometrics');
  final locale = const PrefName('locale');
}

class UserSettingsPreferences {
  const UserSettingsPreferences();
  final prefs = const SettingsPreferences();
}

abstract class UserSharedPreferences {
  static SharedPreferences? _preferences;
  static const settings = UserSettingsPreferences();
  static init() async => _preferences = await SharedPreferences.getInstance();

  static _setString(PrefName prefName, String value) {
    if (_preferences != null) {
      _preferences!.setString(prefName.name, value);
    } else {
      throw Exception('You must call init() before using SharedPreferences');
    }
  }

  static String? _getString(PrefName prefName) {
    if (_preferences != null) {
      var pref = _preferences!.getString(prefName.name);
      return pref;
    } else {
      throw Exception('You must call init() before using SharedPreferences');
    }
  }

  static _setInt(PrefName prefName, int value) {
    if (_preferences != null) {
      _preferences!.setInt(prefName.name, value);
    } else {
      throw Exception('You must call init() before using SharedPreferences');
    }
  }

  static int? _getInt(PrefName prefName) {
    if (_preferences != null) {
      var pref = _preferences!.getInt(prefName.name);
      return pref;
    } else {
      throw Exception('You must call init() before using SharedPreferences');
    }
  }

  static _setBool(PrefName prefName, bool value) {
    if (_preferences != null) {
      _preferences!.setBool(prefName.name, value);
    } else {
      throw Exception('You must call init() before using SharedPreferences');
    }
  }

  static bool? _getBool(PrefName prefName) {
    if (_preferences != null) {
      var pref = _preferences!.getBool(prefName.name);
      return pref;
    } else {
      throw Exception('You must call init() before using SharedPreferences');
    }
  }
}

class SettingsPreferences {
  const SettingsPreferences();
  bool? get theme => UserSharedPreferences._getBool(SettingsPrefsNames().theme);
  set theme(bool? value) => UserSharedPreferences._setBool(
    SettingsPrefsNames().theme,
    value ?? false,
  );

  int? get tint => UserSharedPreferences._getInt(SettingsPrefsNames().tint);
  set tint(int? value) => UserSharedPreferences._setInt(
    SettingsPrefsNames().tint,
    value ?? 0xFF2AE881,
  );

  bool? get haptic =>
      UserSharedPreferences._getBool(SettingsPrefsNames().haptic);
  set haptic(bool? value) => UserSharedPreferences._setBool(
    SettingsPrefsNames().haptic,
    value ?? false,
  );

  bool? get password =>
      UserSharedPreferences._getBool(SettingsPrefsNames().password);
  set password(bool? value) => UserSharedPreferences._setBool(
    SettingsPrefsNames().password,
    value ?? false,
  );

  bool? get biometrics =>
      UserSharedPreferences._getBool(SettingsPrefsNames().biometrics);
  set biometrics(bool? value) => UserSharedPreferences._setBool(
    SettingsPrefsNames().biometrics,
    value ?? false,
  );

  String? get locale =>
      UserSharedPreferences._getString(SettingsPrefsNames().locale);
  set locale(String? value) => UserSharedPreferences._setString(
    SettingsPrefsNames().locale,
    value ?? 'RU',
  );
}
