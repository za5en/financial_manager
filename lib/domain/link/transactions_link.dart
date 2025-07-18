import 'dart:developer';

import 'package:financial_manager/data/models/transaction/transaction_model.dart';
import 'package:financial_manager/data/models/transaction/transaction_request_model.dart';
import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/data/repos/transaction_repo_data.dart';

class TransactionLink {
  TransactionLink();

  final transactionRepoData = TransactionRepoData();

  Future<List<TransactionResponseModel>> getTransactionsByPeriod(
    accountId,
    startDate,
    endDate,
  ) async {
    try {
      final request = await transactionRepoData.getTransactionsByPeriod(
        accountId,
        startDate,
        endDate,
      );
      return request;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<TransactionResponseModel> getTransaction(id) async {
    try {
      final request = await transactionRepoData.getTransactionById(id);
      return request;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<TransactionModel> createTransaction(
    TransactionRequestModel transactionRequest,
  ) async {
    try {
      final request = await transactionRepoData.createTransaction(
        transactionRequest,
      );
      return request;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<TransactionResponseModel> updateTransaction(
    int id,
    TransactionRequestModel transactionRequest,
  ) async {
    try {
      final request = await transactionRepoData.updateTransaction(
        id,
        transactionRequest,
      );
      return request;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      await transactionRepoData.deleteTransaction(id);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
