import 'dart:developer';

import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/data/repos/transaction_repo_data.dart';

class TransactionLink {
  TransactionLink();

  final transactionRepoData = TransactionRepoData();

  Future<List<TransactionResponseModel>> makeRequest(
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
}
