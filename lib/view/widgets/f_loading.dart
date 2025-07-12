import 'package:flutter/material.dart';

class FLoading extends StatelessWidget {
  const FLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: Color.fromRGBO(42, 232, 129, 1)),
    );
  }
}
