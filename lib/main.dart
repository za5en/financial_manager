import 'dart:async';

import 'package:financial_manager/data/local/user_shared_preferences.dart';
import 'package:financial_manager/di/scope_container.dart';
import 'package:financial_manager/router/router_main.dart';
import 'package:financial_manager/view/resources/locale/locale_provider.dart';
import 'package:financial_manager/view/widgets/f_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'i18n/app_localizations.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

import 'view/resources/theme/color_themes.dart';

StreamController<int> themeColor = StreamController();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.systemLocale = await findSystemLocale();
  await initializeDateFormatting();
  await dotenv.load(fileName: "main.env");
  await UserSharedPreferences.init();
  runApp(const FMAppInit());
}

class FMAppInit extends StatefulWidget {
  const FMAppInit({super.key});

  @override
  State<FMAppInit> createState() => _FMAppInitState();
}

class _FMAppInitState extends State<FMAppInit> {
  final _appScopeHolder = AppScopeHolder();

  @override
  void initState() {
    super.initState();
    _appScopeHolder.create();
  }

  @override
  void dispose() {
    _appScopeHolder.drop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopeProvider(holder: _appScopeHolder, child: FMApp());
  }
}

class FMApp extends StatelessWidget {
  const FMApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ColorThemes.main;
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
      builder: (context, scope) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => scope.themeHolder.get),
          BlocProvider(create: (_) => scope.localeHolder.get),
        ],
        child: Builder(
          builder: (context) {
            BlocProvider.of<ThemeProvider>(context).toggleTheme();
            BlocProvider.of<LocaleProvider>(context).toggleLocale();
            final themeMode = context.watch<ThemeProvider>().state;
            final locale = context.watch<LocaleProvider>().state;
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            return MaterialApp.router(
              routerConfig: RouterMain.router,
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: theme.light,
              darkTheme: theme.dark,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [const Locale('en'), const Locale('ru')],
              locale: locale.locale,
              builder: (context, child) =>
                  FOverlay(child: child ?? Container()),
            );
          },
        ),
      ),
    );
  }
}
