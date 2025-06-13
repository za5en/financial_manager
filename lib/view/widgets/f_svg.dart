import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FSvg extends StatelessWidget {
  final String assetName;
  final double? height;
  final double? width;
  final ColorFilter? colorFilter;
  final Color? color;

  const FSvg({
    super.key,
    required this.assetName,
    this.height,
    this.width,
    this.colorFilter,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      color: color,
      colorFilter: colorFilter,
      height: height,
      width: width,
    );
  }
}
