import 'package:financial_manager/view/pages/account/account_view.dart';
import 'package:financial_manager/view/pages/history/finances_view.dart';
import 'package:financial_manager/view/pages/categories/categories_view.dart';
import 'package:financial_manager/view/pages/settings/settings_view.dart';
import 'package:financial_manager/view/states/account/account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            NestedNavigator(
              navigatorKey: _navigatorKeys[0],
              child: const FinancesView(isIncome: false),
            ),
            NestedNavigator(
              navigatorKey: _navigatorKeys[1],
              child: const FinancesView(isIncome: true),
            ),
            NestedNavigator(
              navigatorKey: _navigatorKeys[2],
              child: BlocProvider(
                create: (context) => AccountCubit(),
                child: const AccountView(),
              ),
            ),
            NestedNavigator(
              navigatorKey: _navigatorKeys[3],
              child: const CategoriesView(),
            ),
            NestedNavigator(
              navigatorKey: _navigatorKeys[4],
              child: const SettingsView(),
            ),
          ],
        ),
      ),
    );
  }
}

class NestedNavigator extends StatelessWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  const NestedNavigator({
    super.key,
    required this.child,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) => Navigator(
    key: navigatorKey,
    onGenerateRoute: (settings) {
      return MaterialPageRoute(builder: (context) => child, settings: settings);
    },
  );
}
