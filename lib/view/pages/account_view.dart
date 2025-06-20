import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppbar(
        title: 'Мой счет',
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(child: FSvg(assetName: 'assets/images/edit.svg')),
          ),
        ],
      ),
      body: Center(child: Text('Financial Manager')),
    );
  }
}
