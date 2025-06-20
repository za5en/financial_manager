import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:flutter/material.dart';

class ItemsView extends StatelessWidget {
  const ItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppbar(title: 'Мои статьи'),
      body: Center(child: Text('Financial Manager')),
    );
  }
}
