import 'dart:async';

import 'package:financial_manager/router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'view/resources/color_themes.dart';

StreamController<int> themeColor = StreamController();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.systemLocale = await findSystemLocale();
  await initializeDateFormatting();
  runApp(const FMApp());
}

class FMApp extends StatefulWidget {
  const FMApp({super.key});

  @override
  State<FMApp> createState() => _FMAppState();
}

class _FMAppState extends State<FMApp> {
  final _router = const FMRouter();
  final initialRoute = '/';
  final theme = ColorThemes.main;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: themeColor.stream,
      builder: (context, snapshot) {
        return MaterialApp(
          onGenerateRoute: _router.onGenerateRoute,
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          theme: theme.light,
        );
      },
    );
  }
}
