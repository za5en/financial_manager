import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/domain/link/transactions_link.dart';

class AccountTransactions {
  AccountTransactions();

  final transactionLink = TransactionLink();

  Future<List<TransactionResponseModel>> getTransactionsByPeriod(
    accountId,
    startDate,
    endDate,
    isIncome,
  ) async {
    final request = await transactionLink.makeRequest(
      accountId,
      startDate,
      endDate,
    );

    return isIncome
        ? request.where((val) => val.category.isIncome).toList()
        : request.where((val) => !val.category.isIncome).toList();
  }
}
