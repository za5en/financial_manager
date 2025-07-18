import 'package:financial_manager/view/resources/theme/main_color.dart';
import 'package:flutter/material.dart';

class FLoading extends StatelessWidget {
  const FLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: MainColor.color,
          builder: (context, value, child) =>
              CircularProgressIndicator(color: Color(value)),
        ),
      ),
    );
  }
}
