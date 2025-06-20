import 'package:financial_manager/data/models/account/account_create_request_model.dart';
import 'package:financial_manager/data/models/account/account_history_response_model.dart';
import 'package:financial_manager/data/models/account/account_model.dart';
import 'package:financial_manager/data/models/account/account_response_model.dart';
import 'package:financial_manager/data/models/account/account_update_request_model.dart';

abstract interface class BankAccountRepoDomain {
  Future<List<AccountModel>> getAccount();
  Future<AccountModel> createAccount(
    AccountCreateRequestModel accountCreateModel,
  );
  Future<AccountResponseModel> getAccountById(int id);
  Future<AccountModel> updateAccount(
    int id,
    AccountUpdateRequestModel accountUpdateModel,
  );
  Future<AccountHistoryResponseModel> getAccountHistory(int id);
}
