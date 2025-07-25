import 'dart:developer';

import 'package:financial_manager/data/integration/api_client.dart';
import 'package:financial_manager/data/methods/account_methods.dart';
import 'package:financial_manager/data/models/account/account_model.dart';
import 'package:financial_manager/data/models/account/account_update_request_model.dart';
import 'package:financial_manager/data/repos/bank_account_repo_data.dart';

class AccountLink {
  AccountLink();

  final accountRepoData = BankAccountRepoData(AccountMethods(ApiClient.dio));

  Future<List<AccountModel>> getAccount() async {
    try {
      final request = await accountRepoData.getAccount();
      return request;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<AccountModel> updateAccount(
    int id,
    AccountUpdateRequestModel accountUpdateModel,
  ) async {
    try {
      final request = await accountRepoData.updateAccount(
        id,
        accountUpdateModel,
      );
      return request;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      // await accountRepoData.deleteAccount();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
