import 'package:flutter/material.dart';

class FAppbar extends StatefulWidget implements PreferredSizeWidget {
  const FAppbar({super.key, required this.title, this.actions, this.leading});
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

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
            AppBar(
              centerTitle: true,
              backgroundColor: Color.fromRGBO(42, 232, 129, 1),
              leading: widget.leading,
              actions: widget.actions,
              title: Text(widget.title, style: TextStyle(fontSize: 22)),
              automaticallyImplyLeading: false,
            ),
          ],
        ),
      ],
    );
  }
}
