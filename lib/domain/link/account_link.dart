import 'dart:developer';

import 'package:financial_manager/data/models/account/account_model.dart';
import 'package:financial_manager/data/repos/bank_account_repo_data.dart';

class AccountLink {
  AccountLink();

  final accountRepoData = BankAccountRepoData();

  Future<List<AccountModel>> makeRequest() async {
    try {
      final request = await accountRepoData.getAccount();
      return request;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
