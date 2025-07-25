import 'package:financial_manager/data/local/user_shared_preferences.dart';
import 'package:flutter/material.dart';

enum FToggleState { enabled, disabled }

class FToggle extends StatelessWidget {
  const FToggle({
    super.key,
    required this.name,
    this.state = FToggleState.enabled,
  });
  final String name;
  final FToggleState state;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: name == 'theme'
          ? UserSharedPreferences.settings.prefs.theme ?? false
          : UserSharedPreferences.settings.prefs.haptic ?? false,
      activeColor: Color.fromRGBO(212, 250, 230, 1),
      onChanged: switch (state) {
        FToggleState.enabled => (bool val) {
          if (name == 'theme') {
            UserSharedPreferences.settings.prefs.theme = val;
          } else {
            UserSharedPreferences.settings.prefs.haptic = val;
          }
        },
        FToggleState.disabled => null,
      },
    );
  }
}
