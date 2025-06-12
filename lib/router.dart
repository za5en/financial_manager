import 'package:financial_manager/view/pages/expenses.dart';
import 'package:flutter/material.dart';

class FMRouter {
  const FMRouter();

  Route onGenerateRoute(settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Expenses(),
        );
      // case '/income':
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => const Income(),
      //   );
      // case '/account':
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => const Account(),
      //   );
      // case '/items':
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => const Items(),
      //   );
      // case '/settings':
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => const Settings(),
      //   );
      default:
        throw ErrorDescription('Unknown route name: ${settings.name}');
    }
  }
}
