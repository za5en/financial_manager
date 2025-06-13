import 'dart:developer';

import 'package:financial_manager/data/models/account/account_create_request_model.dart';
import 'package:financial_manager/data/models/account/account_history_model.dart';
import 'package:financial_manager/data/models/account/account_history_response_model.dart';
import 'package:financial_manager/data/models/account/account_model.dart';
import 'package:financial_manager/data/models/account/account_response_model.dart';
import 'package:financial_manager/data/models/account/account_state_model.dart';
import 'package:financial_manager/data/models/account/account_update_request_model.dart';
import 'package:financial_manager/data/models/stats/stat_item_model.dart';
import 'package:financial_manager/domain/repos/bank_account_repo_domain.dart';

class BankAccountRepoData implements BankAccountRepoDomain {
  final int userId = 1;
  // список счетов
  final List<AccountModel> accounts = [
    AccountModel(
      id: 1,
      userId: 1,
      name: "Основной счет",
      balance: "1000.00",
      currency: "RUB",
      createdAt: "2025-06-13T12:37:53.364Z",
      updatedAt: "2025-06-13T12:37:53.364Z",
    ),
  ];

  // список статей дохода
  final List<StatItemModel> incomeStats = [
    StatItemModel(
      categoryId: 1,
      categoryName: "Зарплата",
      emoji: "💰",
      amount: "5000.00",
    ),
  ];

  // список статей расхода
  final List<StatItemModel> expenseStats = [
    StatItemModel(
      categoryId: 1,
      categoryName: "Зарплата",
      emoji: "💰",
      amount: "5000.00",
    ),
  ];

  // список истории счёта
  final List<AccountHistoryModel> history = [
    AccountHistoryModel(
      id: 1,
      accountId: 1,
      changeType: "MODIFICATION",
      previousState: AccountStateModel(
        id: 1,
        name: "Основной счет",
        balance: "1000.00",
        currency: "USD",
      ),
      newState: AccountStateModel(
        id: 1,
        name: "Основной счет",
        balance: "1000.00",
        currency: "USD",
      ),
      changeTimestamp: "2025-06-13T13:05:37.703Z",
      createdAt: "2025-06-13T13:05:37.703Z",
    ),
  ];

  // создать новый счет
  @override
  Future<AccountModel> createAccount(
    AccountCreateRequestModel accountCreateModel,
  ) async {
    try {
      await Future.delayed(Duration(milliseconds: 200));
      final newAccountData = AccountModel(
        id: accounts.length + 1,
        userId: userId,
        name: accountCreateModel.name,
        balance: accountCreateModel.balance,
        currency: accountCreateModel.currency,
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
      );
      accounts.add(newAccountData);
      return newAccountData;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // получить все счета пользователя
  @override
  Future<List<AccountModel>> getAccount() async {
    try {
      await Future.delayed(Duration(milliseconds: 200));
      return accounts;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // получить счет по ID
  @override
  Future<AccountResponseModel> getAccountById(int id) async {
    try {
      await Future.delayed(Duration(milliseconds: 200));
      if (!accounts.any((el) => el.id == id)) {
        throw Exception();
      }
      final account = accounts.firstWhere((el) => el.id == id);

      final response = AccountResponseModel(
        id: account.id,
        name: account.name,
        balance: account.balance,
        currency: account.currency,
        incomeStats: incomeStats,
        expenseStats: expenseStats,
        createdAt: account.createdAt,
        updatedAt: account.updatedAt,
      );
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // получить историю изменений счета
  @override
  Future<AccountHistoryResponseModel> getAccountHistory(int id) async {
    try {
      await Future.delayed(Duration(milliseconds: 200));
      if (!accounts.any((el) => el.id == id)) {
        throw Exception();
      }
      final account = accounts.firstWhere((el) => el.id == id);
      final accountHistory =
          history.where((el) => el.accountId == account.id).toList();

      final response = AccountHistoryResponseModel(
        accountId: account.id,
        accountName: account.name,
        currency: account.currency,
        currentBalance: account.balance,
        history:
            accountHistory.isNotEmpty
                ? accountHistory
                : [
                  AccountHistoryModel(
                    id: 1,
                    accountId: account.id,
                    changeType: "CREATION",
                    newState: AccountStateModel(
                      id: account.id,
                      name: account.name,
                      balance: account.balance,
                      currency: account.currency,
                    ),
                    changeTimestamp: DateTime.now().toString(),
                    createdAt: account.createdAt,
                  ),
                ],
      );
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // обновить счет
  @override
  Future<AccountModel> updateAccount(
    int id,
    AccountUpdateRequestModel accountUpdateModel,
  ) async {
    try {
      await Future.delayed(Duration(milliseconds: 200));
      final index = accounts.indexWhere((el) => el.id == id);
      if (index == -1) {
        throw Exception();
      }
      final account = accounts[index].copyWith(
        name: accountUpdateModel.name,
        balance: accountUpdateModel.balance,
        currency: accountUpdateModel.currency,
      );
      accounts[index] = account;
      return account;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
