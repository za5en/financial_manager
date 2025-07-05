import 'dart:developer';

import 'package:financial_manager/data/integration/api_client.dart';
import 'package:financial_manager/data/methods/transaction_methods.dart';
import 'package:financial_manager/data/models/account/account_brief_model.dart';
import 'package:financial_manager/data/models/category/category_model.dart';
import 'package:financial_manager/data/models/transaction/transaction_model.dart';
import 'package:financial_manager/data/models/transaction/transaction_request_model.dart';
import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/domain/repos/transaction_repo_domain.dart';
import 'package:intl/intl.dart';
import '../database/drift_database.dart' as sql;

class TransactionRepoData implements TransactionRepoDomain {
  TransactionRepoData();
  static final transactionMethods = TransactionMethods(ApiClient.dio);
  static final sql.AppDatabase _sqlDatabase = sql.AppDatabase();

  // Future<void> initialize() async {
  //   _sqlDatabase =
  // }

  static final Map<String, String> currencies = {
    'RUB': '₽',
    'USD': '\$',
    'EUR': '€',
  };

  // список транзакций
  static final List<TransactionModel> transactions = [
    TransactionModel(
      id: 1,
      accountId: 1,
      categoryId: 1,
      amount: "500.00",
      transactionDate: "2025-06-13T13:31:47.262Z",
      comment: "Зарплата за месяц",
      createdAt: "2025-06-13T13:31:47.262Z",
      updatedAt: "2025-06-13T13:31:47.262Z",
    ),
  ];

  // список аккаунтов
  static final List<AccountBriefModel> accountBriefModel = [
    AccountBriefModel(
      id: 1,
      name: "Основной счет",
      balance: "1000.00",
      currency: "RUB",
    ),
  ];

  // список категорий
  static final List<CategoryModel> categoryModel = [
    CategoryModel(id: 1, name: "Зарплата", emoji: "💰", isIncome: true),
  ];

  // создать новую транзакцию
  @override
  Future<TransactionModel> createTransaction(
    TransactionRequestModel transactionRequest,
  ) async {
    try {
      await Future.delayed(Duration(milliseconds: 200));
      if (!accountBriefModel.any(
        (el) => el.id == transactionRequest.accountId,
      )) {
        throw Exception();
      }
      if (!categoryModel.any((el) => el.id == transactionRequest.categoryId)) {
        throw Exception();
      }

      final res = await _sqlDatabase.createTransaction(
        transactionRequest.accountId,
        transactionRequest.categoryId,
        transactionRequest.amount,
        DateTime.now(),
        DateTime.now().toString(),
        DateTime.now().toString(),
      );

      TransactionModel newTransactionData = TransactionModel(
        id: transactions.length + 1,
        accountId: transactionRequest.accountId,
        categoryId: transactionRequest.categoryId,
        amount: transactionRequest.amount,
        transactionDate: transactionRequest.transactionDate,
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
      );
      transactions.add(newTransactionData);
      return newTransactionData;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // удалить транзакцию
  @override
  Future<void> deleteTransaction(int id) async {
    try {
      await Future.delayed(Duration(milliseconds: 200));
      if (!transactions.any((el) => el.id == id)) {
        throw Exception();
      }

      await _sqlDatabase.deleteTransaction(id);

      transactions.removeWhere((el) => el.id == id);
    } catch (e) {
      log(e.toString());
    }
  }

  // получить транзакцию по ID
  @override
  Future<TransactionResponseModel> getTransactionById(int id) async {
    try {
      // await Future.delayed(Duration(milliseconds: 200));
      // if (!transactions.any((el) => el.id == id)) {
      //   throw Exception();
      // }

      // final transaction = transactions.firstWhere((el) => el.id == id);

      // if (!accountBriefModel.any((el) => el.id == transaction.accountId)) {
      //   throw Exception();
      // }
      // if (!categoryModel.any((el) => el.id == transaction.categoryId)) {
      //   throw Exception();
      // }

      // final res = await _sqlDatabase.getTransactionById(id);
      // final acc = await _sqlDatabase.getAccountById(res.accountId);
      // final cat = await _sqlDatabase.getCategoryById(res.categoryId);

      // final getTransaction = TransactionResponseModel(
      //   id: res.id,
      //   account: AccountBriefModel(
      //     id: acc.id,
      //     name: acc.name,
      //     balance: acc.balance,
      //     currency: acc.currency,
      //   ),
      //   category: CategoryModel(
      //     id: cat.id,
      //     name: cat.name,
      //     emoji: cat.emoji,
      //     isIncome: cat.isIncome,
      //   ),
      //   amount: res.amount,
      //   transactionDate: res.transactionDate.toString(),
      //   createdAt: res.createdAt,
      //   updatedAt: res.updatedAt,
      // );

      // TransactionResponseModel response = TransactionResponseModel(
      //   id: transaction.id,
      //   account: accountBriefModel.firstWhere(
      //     (el) => el.id == transaction.accountId,
      //   ),
      //   category: categoryModel.firstWhere(
      //     (el) => el.id == transaction.categoryId,
      //   ),
      //   amount: transaction.amount,
      //   transactionDate: transaction.transactionDate,
      //   createdAt: transaction.createdAt,
      //   updatedAt: transaction.updatedAt,
      // );

      final response = await transactionMethods.getTransaction(id);
      return response.copyWith(
        account: response.account.copyWith(
          currency: currencies[response.account.currency] ?? '₽',
        ),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // получить транзакции по счету за период
  @override
  Future<List<TransactionResponseModel>> getTransactionsByPeriod(
    int accountId,
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    try {
      // if (!accountBriefModel.any((el) => el.id == accountId)) {
      //   throw Exception();
      // }

      final res = await _sqlDatabase.getTransactionsByPeriod(
        accountId: accountId,
        startDate: startDate,
        endDate: endDate,
      );

      List<TransactionResponseModel> getTransactions = [];
      for (var record in res) {
        final acc = await _sqlDatabase.getAccountById(record.accountId);
        final cat = await _sqlDatabase.getCategoryById(record.categoryId);
        getTransactions.add(
          TransactionResponseModel(
            id: record.id,
            account: AccountBriefModel(
              id: acc.id,
              name: acc.name,
              balance: acc.balance,
              currency: acc.currency,
            ),
            category: CategoryModel(
              id: cat.id,
              name: cat.name,
              emoji: cat.emoji,
              isIncome: cat.isIncome,
            ),
            amount: record.amount,
            transactionDate: record.transactionDate.toString(),
            createdAt: record.createdAt,
            updatedAt: record.updatedAt,
          ),
        );
      }

      final startDateFormatted =
          startDate != null ? DateFormat('yyyy-MM-dd').format(startDate) : null;

      final endDateFormatted =
          endDate != null ? DateFormat('yyyy-MM-dd').format(endDate) : null;

      final response = await transactionMethods.getTransactionsByPeriod(
        accountId,
        startDateFormatted,
        endDateFormatted,
      );

      final List<TransactionResponseModel> responseUpgraded = [];
      for (var record in response) {
        responseUpgraded.add(
          record.copyWith(
            account: record.account.copyWith(
              currency: currencies[record.account.currency] ?? '₽',
            ),
          ),
        );
      }

      // final List<TransactionModel> transactionsByPeriod =
      //     transactions
      //         .where(
      //           (el) =>
      //               el.accountId == accountId &&
      //               DateTime.parse(
      //                 el.transactionDate,
      //               ).isAfter(startDate ?? DateTime(DateTime.now().month)) &&
      //               DateTime.parse(
      //                 el.transactionDate,
      //               ).isBefore(endDate ?? DateTime(DateTime.now().month + 1)),
      //         )
      //         .toList();

      // if (transactionsByPeriod.isEmpty) {
      //   throw Exception();
      // }

      // final response =
      //     transactionsByPeriod.map((transaction) {
      //       return TransactionResponseModel(
      //         id: transaction.id,
      //         account: accountBriefModel.firstWhere(
      //           (el) => el.id == transaction.accountId,
      //         ),
      //         category: categoryModel.firstWhere(
      //           (el) => el.id == transaction.categoryId,
      //         ),
      //         amount: transaction.amount,
      //         transactionDate: transaction.transactionDate,
      //         createdAt: transaction.createdAt,
      //         updatedAt: transaction.updatedAt,
      //       );
      //     }).toList();
      return responseUpgraded;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // обновить транзакцию
  @override
  Future<TransactionResponseModel> updateTransaction(
    int id,
    TransactionRequestModel transactionRequest,
  ) async {
    try {
      await Future.delayed(Duration(milliseconds: 200));
      if (!transactions.any((el) => el.id == id)) {
        throw Exception();
      }
      if (!accountBriefModel.any(
        (el) => el.id == transactionRequest.accountId,
      )) {
        throw Exception();
      }
      if (!categoryModel.any((el) => el.id == transactionRequest.categoryId)) {
        throw Exception();
      }

      final res = await _sqlDatabase.updateTransaction(
        id,
        transactionRequest.accountId,
        transactionRequest.categoryId,
        transactionRequest.amount,
        DateTime.now(),
        DateTime.now().toString(),
        DateTime.now().toString(),
      );

      final index = transactions.indexWhere((el) => el.id == id);
      final transaction = transactions[index].copyWith(
        accountId: transactionRequest.accountId,
        categoryId: transactionRequest.categoryId,
        amount: transactionRequest.amount,
        transactionDate: transactionRequest.transactionDate,
        comment: transactionRequest.comment,
      );
      transactions[index] = transaction;

      TransactionResponseModel response = TransactionResponseModel(
        id: transaction.id,
        account: accountBriefModel.firstWhere(
          (el) => el.id == transaction.accountId,
        ),
        category: categoryModel.firstWhere(
          (el) => el.id == transaction.categoryId,
        ),
        amount: transaction.amount,
        transactionDate: transaction.transactionDate,
        createdAt: transaction.createdAt,
        updatedAt: transaction.updatedAt,
      );
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
