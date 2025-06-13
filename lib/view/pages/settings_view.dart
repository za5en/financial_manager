import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_navbar.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppbar(title: 'Настройки'),
      body: Center(child: Text('Financial Manager')),
      bottomNavigationBar: FNavbar(),
    );
  }
}
