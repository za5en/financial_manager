import 'dart:ui';
import 'package:flutter/material.dart';

class FOverlay extends StatefulWidget {
  const FOverlay({super.key, required this.child});

  final Widget child;

  @override
  State<FOverlay> createState() => _FOverlayState();
}

class _FOverlayState extends State<FOverlay> with WidgetsBindingObserver {
  bool shouldBlur = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      shouldBlur =
          state == AppLifecycleState.inactive ||
          state == AppLifecycleState.paused;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (shouldBlur) {
      return Stack(
        children: [
          widget.child,
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade200.withValues(alpha: 0.5),
            ),
          ),
        ],
      );
    }

    return widget.child;
  }
}
