import 'package:flutter/material.dart';

class FRedButton extends StatelessWidget {
  const FRedButton({
    super.key,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.topPadding,
    required this.name,
  });
  final Function() onPressed;
  final double width;
  final double height;
  final double topPadding;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: WidgetStateProperty.all<double>(0),
            backgroundColor: WidgetStateProperty.all<Color>(
              Color.fromRGBO(228, 105, 98, 1),
            ),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          ),
          onPressed: onPressed,
          child: Text(name),
        ),
      ),
    );
  }
}
