import 'package:financial_manager/view/resources/theme/main_color.dart';
import 'package:flutter/material.dart';

class FAppbar extends StatefulWidget implements PreferredSizeWidget {
  const FAppbar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
  });
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;

  @override
  State<FAppbar> createState() => _FAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class _FAppbarState extends State<FAppbar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            ValueListenableBuilder(
              valueListenable: MainColor.color,
              builder: (context, value, child) => AppBar(
                centerTitle: true,
                backgroundColor: widget.backgroundColor ?? Color(value),
                leading: widget.leading,
                actions: widget.actions,
                title: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 22,
                    color: widget.backgroundColor != null
                        ? Theme.of(
                                context,
                              ).primaryTextTheme.bodyMedium?.color ??
                              Color(0xFF1C1C22)
                        : Color(0xFF1C1C22),
                  ),
                ),
                automaticallyImplyLeading: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
