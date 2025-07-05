import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';

class FListLine extends StatefulWidget {
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
    this.bottomBorderColor,
    this.emojiBackground,
    this.emojiTextStyle,
    this.icon,
    this.nameColor,
    required this.isEmojiInContainer,
    this.svgIcon,
    this.editName,
    this.onNameChanged,
    this.controller,
    this.hint,
    this.autofocus,
    this.width,
  });
  final double height;
  final double leftPadding;
  final double rightPadding;
  final String name;
  final Color? nameColor;
  final String? description;
  final Widget rightSide;
  final Icon? icon;
  final FSvg? svgIcon;
  final String? emoji;
  final Color? emojiBackground;
  final bool isEmojiInContainer;
  final TextStyle? emojiTextStyle;
  final Color backgroundColor;
  final Color? bottomBorderColor;
  final bool? editName;
  final void Function(String)? onNameChanged;
  final TextEditingController? controller;
  final String? hint;
  final bool? autofocus;
  final double? width;

  @override
  State<FListLine> createState() => _FListLineState();
}

class _FListLineState extends State<FListLine> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: widget.height,
      padding: EdgeInsets.only(
        left: widget.leftPadding,
        right: widget.rightPadding,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: widget.bottomBorderColor ?? Color.fromRGBO(202, 196, 208, 1),
          ),
        ),
        color: widget.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: w * 0.038),
                child: Row(
                  children: [
                    Visibility(
                      visible: widget.emoji != null,
                      child:
                          widget.isEmojiInContainer
                              ? Container(
                                height: h * 0.026,
                                width: w * 0.058,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      widget.emojiBackground ??
                                      Color.fromRGBO(212, 250, 230, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.emoji ?? '',
                                    style: widget.emojiTextStyle,
                                  ),
                                ),
                              )
                              : Center(child: widget.svgIcon),
                    ),
                    Visibility(
                      visible: widget.icon != null,
                      child: Center(child: widget.icon),
                    ),
                  ],
                ),
              ),
              widget.description != null
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(color: widget.nameColor),
                      ),
                      SizedBox(
                        width: w * 0.4,
                        child: Text(
                          widget.description ?? '',
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
                  : widget.editName == true
                  ? SizedBox(
                    width: widget.width ?? w * 0.45,
                    child: TextFormField(
                      controller: widget.controller,
                      autofocus: widget.autofocus ?? false,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      onChanged: (value) => widget.onNameChanged!(value),
                      maxLines: 1,
                      style: TextStyle(fontSize: 14),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: widget.hint ?? widget.name,
                        hintStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                  : Text(
                    widget.name,
                    style: TextStyle(color: widget.nameColor),
                  ),
            ],
          ),
          widget.rightSide,
        ],
      ),
    );
  }
}
