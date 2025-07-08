import 'package:financial_manager/i18n/app_localizations.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';

class FNavbar extends StatefulWidget {
  const FNavbar({
    super.key,
    required this.currentIndex,
    required this.destinationSelect,
  });
  final int currentIndex;
  final Function(int index) destinationSelect;

  @override
  State<FNavbar> createState() => _FNavbarState();
}

class _FNavbarState extends State<FNavbar> {
  // int _currentPageIndex = 0;
  Map<String, String> icons = {
    'Расходы': 'assets/images/expenses.svg',
    'Доходы': 'assets/images/income.svg',
    'Счет': 'assets/images/account.svg',
    'Статьи': 'assets/images/items.svg',
    'Настройки': 'assets/images/settings.svg',
  };

  List<String> routes = ['/', '/income', '/account', '/items', '/settings'];

  // void _destinationSelect(int index) {
  //   if (currentPageIndex != index) {
  //     if (ModalRoute.of(context)?.settings.name != '/') {
  //       if (routes[index] == '/') {
  //         Navigator.popUntil(context, ModalRoute.withName('/'));
  //       }
  //       Navigator.pushReplacementNamed(context, routes[index]);
  //     } else {
  //       Navigator.pushNamed(context, routes[index]);
  //     }
  //   }
  //   setState(() {
  //     currentPageIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Color.fromRGBO(243, 237, 247, 1),
      onDestinationSelected: widget.destinationSelect,
      indicatorColor: Color.fromRGBO(212, 250, 230, 1),
      selectedIndex: widget.currentIndex,
      destinations: <Widget>[
        NavigationDestination(
          icon: FSvg(assetName: icons.values.elementAt(0)),
          selectedIcon: FSvg(
            assetName: icons.values.elementAt(0),
            color: Color.fromRGBO(42, 232, 129, 1),
          ),
          label:
              AppLocalizations.of(context)?.expensesTab ??
              icons.keys.elementAt(0),
        ),
        NavigationDestination(
          icon: FSvg(assetName: icons.values.elementAt(1)),
          selectedIcon: FSvg(
            assetName: icons.values.elementAt(1),
            color: Color.fromRGBO(42, 232, 129, 1),
          ),
          label:
              AppLocalizations.of(context)?.incomesTab ??
              icons.keys.elementAt(1),
        ),
        NavigationDestination(
          icon: FSvg(assetName: icons.values.elementAt(2)),
          selectedIcon: FSvg(
            assetName: icons.values.elementAt(2),
            color: Color.fromRGBO(42, 232, 129, 1),
          ),
          label:
              AppLocalizations.of(context)?.accountTab ??
              icons.keys.elementAt(2),
        ),
        NavigationDestination(
          icon: FSvg(assetName: icons.values.elementAt(3)),
          selectedIcon: FSvg(
            assetName: icons.values.elementAt(3),
            color: Color.fromRGBO(42, 232, 129, 1),
          ),
          label:
              AppLocalizations.of(context)?.articlesTab ??
              icons.keys.elementAt(3),
        ),
        NavigationDestination(
          icon: FSvg(assetName: icons.values.elementAt(4)),
          selectedIcon: FSvg(
            assetName: icons.values.elementAt(4),
            color: Color.fromRGBO(42, 232, 129, 1),
          ),
          label:
              AppLocalizations.of(context)?.settings ?? icons.keys.elementAt(4),
        ),
      ],
    );
  }
}
