import 'package:flutter/material.dart';

class FListLine extends StatelessWidget {
  const FListLine({
    super.key,
    required this.height,
    required this.leftPadding,
    required this.rightPadding,
    required this.name,
    this.description,
    required this.rightSide,
    this.emoji,
    required this.backgroundColor,
  });
  final double height;
  final double leftPadding;
  final double rightPadding;
  final String name;
  final String? description;
  final Widget rightSide;
  final String? emoji;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(202, 196, 208, 1)),
        ),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: w * 0.038),
                child: Visibility(
                  visible: emoji != null,
                  child: Container(
                    height: h * 0.026,
                    width: w * 0.058,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromRGBO(212, 250, 230, 1),
                    ),
                    child: Text(emoji ?? ''),
                  ),
                ),
              ),
              description != null
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name),
                      SizedBox(
                        width: w * 0.4,
                        child: Text(
                          description ?? '',
                          style: TextStyle(
                            color: Color.fromRGBO(73, 69, 79, 1),
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  )
                  : Text(name),
            ],
          ),
          rightSide,
        ],
      ),
    );
  }
}
