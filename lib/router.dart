import 'package:financial_manager/view/pages/expenses_view.dart';
import 'package:financial_manager/view/pages/incomes_view.dart';
import 'package:financial_manager/view/pages/account_view.dart';
import 'package:financial_manager/view/pages/items_view.dart';
import 'package:financial_manager/view/pages/settings_view.dart';
import 'package:flutter/material.dart';

class FMRouter {
  const FMRouter();

  Route onGenerateRoute(settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ExpensesView(),
        );
      case '/income':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const IncomesView(),
        );
      case '/account':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AccountView(),
        );
      case '/items':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ItemsView(),
        );
      case '/settings':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SettingsView(),
        );
      default:
        throw ErrorDescription('Unknown route name: ${settings.name}');
    }
  }
}
