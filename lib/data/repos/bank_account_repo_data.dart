import 'dart:developer';

import 'package:financial_manager/data/local/database/drift_database.dart'
    as sql;
import 'package:financial_manager/data/enums/change_type.dart';
// import 'package:financial_manager/data/integration/api_client.dart';
import 'package:financial_manager/data/methods/account_methods.dart';
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

  final AccountMethods accountMethods;

  BankAccountRepoData(this.accountMethods);

  // static final accountMethods = AccountMethods(ApiClient.dio);
  static final sql.AppDatabase _sqlDatabase = sql.AppDatabase();

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
    AccountModel(
      id: 2,
      userId: 1,
      name: "Второй счет",
      balance: "100.00",
      currency: "RUB",
      createdAt: "2025-06-15T12:37:53.364Z",
      updatedAt: "2025-06-15T12:37:53.364Z",
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
      categoryName: "Развлечения",
      emoji: "🎉",
      amount: "2500.00",
    ),
    StatItemModel(
      categoryId: 2,
      categoryName: "Рестораны",
      emoji: "🍴",
      amount: "2500.00",
    ),
  ];

  // список истории счёта
  final List<AccountHistoryModel> history = [
    AccountHistoryModel(
      id: 1,
      accountId: 1,
      changeType: ChangeType.modification,
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
      // await Future.delayed(Duration(milliseconds: 200));

      // final newAccount = await _sqlDatabase.createAccount(
      //   userId,
      //   accountCreateModel.name,
      //   accountCreateModel.balance,
      //   accountCreateModel.currency,
      //   DateTime.now().toString(),
      //   DateTime.now().toString(),
      //   ChangeType.creation.toString(),
      // );

      // final newAccountData = AccountModel(
      //   id: newAccount.id,
      //   userId: newAccount.userId,
      //   name: newAccount.name,
      //   balance: newAccount.balance,
      //   currency: newAccount.currency,
      //   createdAt: newAccount.createdAt,
      //   updatedAt: newAccount.updatedAt,
      // );
      // accounts.add(newAccountData);
      List<String> currency = ['RUB', 'USD', 'EUR'];
      if (accountCreateModel.name == 'null' ||
          double.parse(accountCreateModel.balance).isNaN ||
          !currency.contains(accountCreateModel.currency)) {
        throw Exception();
      }
      final newAccountData = await accountMethods.createAccount(
        accountCreateModel,
      );
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
      // await Future.delayed(Duration(milliseconds: 200));
      // final res = await _sqlDatabase.getAccount();
      // List<AccountModel> accs = [];
      // for (var record in res) {
      //   accs.add(
      //     AccountModel(
      //       id: record.id,
      //       userId: record.userId,
      //       name: record.name,
      //       balance: record.balance,
      //       currency: record.currency,
      //       createdAt: record.createdAt,
      //       updatedAt: record.updatedAt,
      //     ),
      //   );
      // }

      final response = await accountMethods.getAccount();

      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // получить счет по ID
  @override
  Future<AccountResponseModel> getAccountById(int id) async {
    try {
      // await Future.delayed(Duration(milliseconds: 200));
      // if (!accounts.any((el) => el.id == id)) {
      //   throw Exception();
      // }
      // final account = accounts.firstWhere((el) => el.id == id);

      // final res = await _sqlDatabase.getAccountById(id);
      // final stats = await _sqlDatabase.getStatItems();
      // List<StatItemModel> getStats = [];
      // for (var stat in stats) {
      //   getStats.add(
      //     StatItemModel(
      //       categoryId: stat.categoryId,
      //       categoryName: stat.categoryName,
      //       emoji: stat.emoji,
      //       amount: stat.amount,
      //     ),
      //   );
      // }
      // final acc = AccountResponseModel(
      //   id: res.id,
      //   name: res.name,
      //   balance: res.balance,
      //   currency: res.currency,
      //   incomeStats: getStats,
      //   expenseStats: getStats,
      //   createdAt: res.createdAt,
      //   updatedAt: res.updatedAt,
      // );

      // final response = AccountResponseModel(
      //   id: account.id,
      //   name: account.name,
      //   balance: account.balance,
      //   currency: account.currency,
      //   incomeStats: incomeStats,
      //   expenseStats: expenseStats,
      //   createdAt: account.createdAt,
      //   updatedAt: account.updatedAt,
      // );
      if (id < 0) {
        throw Exception();
      }
      final response = accountMethods.getAccountById(id);
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
      // await Future.delayed(Duration(milliseconds: 200));
      // if (!accounts.any((el) => el.id == id)) {
      //   throw Exception();
      // }
      // final account = accounts.firstWhere((el) => el.id == id);
      // final accountHistory = history
      //     .where((el) => el.accountId == account.id)
      //     .toList();

      // final res = await _sqlDatabase.getAccountHistory(id);
      // final acc = AccountHistoryResponseModel(
      //   accountId: res.id,
      //   accountName: res.name,
      //   currency: res.currency,
      //   currentBalance: res.balance,
      //   history: history, // пока не особо понимаю как реализовать историю в бд
      // );

      // final response = AccountHistoryResponseModel(
      //   accountId: account.id,
      //   accountName: account.name,
      //   currency: account.currency,
      //   currentBalance: account.balance,
      //   history: accountHistory.isNotEmpty
      //       ? accountHistory
      //       : [
      //           AccountHistoryModel(
      //             id: 1,
      //             accountId: account.id,
      //             changeType: ChangeType.creation,
      //             newState: AccountStateModel(
      //               id: account.id,
      //               name: account.name,
      //               balance: account.balance,
      //               currency: account.currency,
      //             ),
      //             changeTimestamp: DateTime.now().toString(),
      //             createdAt: account.createdAt,
      //           ),
      //         ],
      // );
      if (id < 0) {
        throw Exception();
      }
      final response = accountMethods.getAccountHistory(id);
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
      // await Future.delayed(Duration(milliseconds: 200));
      // final index = accounts.indexWhere((el) => el.id == id);
      // if (index == -1) {
      //   throw Exception();
      // }

      // final accountModel = await _sqlDatabase.updateAccount(
      //   id,
      //   userId,
      //   accountUpdateModel.name,
      //   accountUpdateModel.balance,
      //   accountUpdateModel.currency,
      //   DateTime.now().toString(),
      //   DateTime.now().toString(),
      //   ChangeType.modification.toString(),
      // );
      // final acc = AccountModel(
      //   id: accountModel.id,
      //   userId: accountModel.userId,
      //   name: accountModel.name,
      //   balance: accountModel.balance,
      //   currency: accountModel.currency,
      //   createdAt: accountModel.createdAt,
      //   updatedAt: accountModel.updatedAt,
      // );

      // final account = AccountModel(
      //   id: accountModel.id,
      //   userId: accountModel.userId,
      //   name: accountModel.name,
      //   balance: accountModel.balance,
      //   currency: accountModel.currency,
      //   createdAt: accountModel.createdAt,
      //   updatedAt: accountModel.updatedAt,
      // );

      // accounts[index] = account;
      List<String> currency = ['RUB', 'USD', 'EUR'];
      if (accountUpdateModel.name == 'null' ||
          double.parse(accountUpdateModel.balance).isNaN ||
          !currency.contains(accountUpdateModel.currency)) {
        throw Exception();
      }
      if (id < 0) {
        throw Exception();
      }
      final response = await accountMethods.updateAccount(
        id,
        accountUpdateModel,
      );
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // удалить счет
  @override
  Future<void> deleteAccount(int id) async {
    try {
      if (id < 0) {
        throw Exception();
      }
      await accountMethods.deleteAccount(id);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
