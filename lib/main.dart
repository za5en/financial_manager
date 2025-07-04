import 'dart:async';

import 'package:financial_manager/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'i18n/app_localizations.dart';

import 'view/resources/color_themes.dart';

StreamController<int> themeColor = StreamController();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.systemLocale = await findSystemLocale();
  await initializeDateFormatting();
  await dotenv.load(fileName: "main.env");
  runApp(const FMApp());
}

class FMApp extends StatefulWidget {
  const FMApp({super.key});

  @override
  State<FMApp> createState() => _FMAppState();
}

class _FMAppState extends State<FMApp> {
  final initialRoute = '/';
  final theme = ColorThemes.main;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: themeColor.stream,
      builder: (context, snapshot) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return MaterialApp(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(builder: (context) => HomePage());
          },
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          theme: theme.light,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [const Locale('en'), const Locale('ru')],
        );
      },
    );
  }
}
