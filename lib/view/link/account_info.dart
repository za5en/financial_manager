import 'package:financial_manager/data/models/account/account_model.dart';
import 'package:financial_manager/domain/link/account_link.dart';

class AccountInfo {
  AccountInfo();

  final accountLink = AccountLink();

  Future<List<AccountModel>> getAccount() async {
    final request = await accountLink.getAccount();

    return request;
  }
}
