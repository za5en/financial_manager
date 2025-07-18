import 'package:financial_manager/view/resources/theme/main_color.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';

class FFloatingActionButton extends StatelessWidget {
  const FFloatingActionButton({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MainColor.color,
      builder: (context, value, child) => FloatingActionButton(
        backgroundColor: Color(value),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        onPressed: onPressed,
        child: FSvg(assetName: 'assets/images/plus.svg'),
      ),
    );
  }
}
