import 'package:financial_manager/view/states/account/account_local.dart';
import 'package:financial_manager/view/states/category/category_local.dart';

class AccountAndCategoriesViewModel {
  final List<AccountLocal> account;
  final List<CategoryLocal> categories;

  AccountAndCategoriesViewModel._({
    required this.account,
    required this.categories,
  });

  factory AccountAndCategoriesViewModel.buildWith(
    List<AccountLocal> account,
    List<CategoryLocal> categories,
  ) =>
      AccountAndCategoriesViewModel._(account: account, categories: categories);
}
