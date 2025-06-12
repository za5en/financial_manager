import 'package:financial_manager/view/widgets/f_navbar.dart';
import 'package:flutter/material.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Financial Manager')),
      bottomNavigationBar: FNavbar(),
    );
  }
}
