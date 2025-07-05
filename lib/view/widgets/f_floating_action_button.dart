import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';

class FFloatingActionButton extends StatelessWidget {
  const FFloatingActionButton({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromRGBO(42, 232, 129, 1),
      foregroundColor: Colors.white,
      shape: const CircleBorder(),
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      onPressed: onPressed,
      child: FSvg(assetName: 'assets/images/plus.svg'),
    );
  }
}
