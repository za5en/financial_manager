import 'package:flutter/material.dart';

class FError extends StatelessWidget {
  const FError({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(
            color: Color.fromRGBO(228, 105, 98, 1),
            fontSize: 24.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
