import 'package:financial_manager/data/models/account/account_model.dart';
import 'package:financial_manager/view/states/account/account_local.dart';

class AccountViewModel {
  final List<AccountLocal> items;

  AccountViewModel._({required this.items});

  factory AccountViewModel.buildWith(List<AccountLocal> items) =>
      AccountViewModel._(items: items);

  static final Map<String, String> currencies = {
    'RUB': '₽',
    'USD': '\$',
    'EUR': '€',
  };

  factory AccountViewModel.fromAccountsList(List<AccountModel> accounts) {
    final accountItems = accounts.map((e) {
      return AccountLocal.buildWith(
        e.id,
        e.name,
        double.parse(e.balance),
        currencies[e.currency] ?? '₽',
      );
    }).toList();

    return AccountViewModel._(items: accountItems);
  }

  factory AccountViewModel.fromAccountModel(AccountModel account) {
    final accountItems = [
      AccountLocal.buildWith(
        account.id,
        account.name,
        double.parse(account.balance),
        currencies[account.currency] ?? '₽',
      ),
    ];

    return AccountViewModel._(items: accountItems);
  }
}
