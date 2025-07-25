import 'package:alchemist/alchemist.dart';
import 'package:financial_manager/data/local/user_shared_preferences.dart';
import 'package:financial_manager/view/widgets/f_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await UserSharedPreferences.init();
  });
  goldenTest(
    '$FToggle',
    fileName: 'toggle',
    builder: () => GoldenTestGroup(
      columns: 1,
      children: [
        GoldenTestScenario(
          name: 'enabled',
          child: FToggle(name: 'theme'),
        ),
        GoldenTestScenario(
          name: 'disabled',
          child: FToggle(name: 'theme', state: FToggleState.disabled),
        ),
      ],
    ),
  );
}
