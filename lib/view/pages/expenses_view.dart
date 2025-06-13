import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_navbar.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';

class ExpensesView extends StatelessWidget {
  const ExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppbar(
        title: 'Расходы сегодня',
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(child: FSvg(assetName: 'assets/images/history.svg')),
          ),
        ],
      ),
      body: Center(child: Text('Financial Manager')),
      bottomNavigationBar: FNavbar(),
    );
  }
}
