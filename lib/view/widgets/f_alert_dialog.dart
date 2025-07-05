import 'package:flutter/material.dart';

class FAlertDialog extends StatelessWidget {
  const FAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
  });
  final Widget title;
  final Widget content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: actions,
      backgroundColor: Color.fromRGBO(212, 250, 230, 1),
    );
  }
}
