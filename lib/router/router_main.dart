import 'package:financial_manager/i18n/app_localizations.dart';
import 'package:financial_manager/view/pages/account/account_view.dart';
import 'package:financial_manager/view/pages/history/analysis_view.dart';
import 'package:financial_manager/view/pages/history/finances_view.dart';
import 'package:financial_manager/view/pages/history/history_view.dart';
import 'package:financial_manager/view/pages/categories/categories_view.dart';
import 'package:financial_manager/view/pages/settings/settings_view.dart';
import 'package:financial_manager/view/states/account/account_cubit.dart';
import 'package:financial_manager/view/states/analysis/analysis_cubit.dart';
import 'package:financial_manager/view/states/category/category_cubit.dart';
import 'package:financial_manager/view/states/finances/finances_cubit.dart';
import 'package:financial_manager/view/states/history/history_cubit.dart';
import 'package:financial_manager/view/states/settings/settings_cubit.dart';
import 'package:financial_manager/view/widgets/f_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouterMain {
  static final router = GoRouter(
    routes: [
      GoRoute(path: "/", redirect: (context, state) => "/expense"),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            FNavbar(body: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/expense",
                builder: financesBuilder(false),
                routes: [
                  GoRoute(
                    path: "/history",
                    builder: historyBuilder(false),
                    routes: historyRoutes(false),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/income",
                builder: financesBuilder(true),
                routes: [
                  GoRoute(
                    path: "/history",
                    builder: historyBuilder(true),
                    routes: historyRoutes(true),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/account",
                builder: (context, state) => BlocProvider(
                  create: (context) => AccountCubit(),
                  child: AccountView(),
                ),
                routes: [
                  // GoRoute(
                  //   path: "/edit/:id",
                  //   builder: (context, state) {
                  //     final account = state.extra as AccountModel?;
                  //     return BlocProvider(
                  //       create: (context) => EditAccountCubit(sl()),
                  //       child: EditAccountPage(
                  //         id: state.pathParameters["id"],
                  //         account: account,
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/categories",
                builder: (context, state) => BlocProvider(
                  create: (context) => CategoryCubit(),
                  child: CategoriesView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/settings",
                builder: (context, state) => BlocProvider(
                  create: (context) => SettingsCubit(),
                  child: SettingsView(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget Function(BuildContext, GoRouterState) financesBuilder(bool isIncome) {
  Widget wrapper(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => FinancesCubit(isIncome: isIncome),
      child: FinancesView(isIncome: isIncome),
    );
  }

  return wrapper;
}

Widget Function(BuildContext, GoRouterState) historyBuilder(bool isIncome) {
  Widget wrapper(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => HistoryCubit(isIncome: isIncome),
      child: HistoryView(
        isIncome: isIncome,
        defaultSort:
            '${AppLocalizations.of(context)?.sortByDate ?? 'По дате'} (▼)',
      ),
    );
  }

  return wrapper;
}

List<GoRoute> historyRoutes(bool isIncome) {
  return [
    GoRoute(
      path: "/analysis",
      builder: (context, state) => BlocProvider(
        create: (context) => AnalysisCubit(isIncome: isIncome),
        child: AnalysisView(isIncome: isIncome),
      ),
    ),
  ];
}
