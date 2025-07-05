import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/domain/link/transactions_link.dart';

class AccountTransactions {
  AccountTransactions();

  final transactionLink = TransactionLink();

  Future<List<TransactionResponseModel>> getTransactionsByPeriod(
    accountId,
    startDate,
    endDate, {
    isIncome,
  }) async {
    final request = await transactionLink.getTransactionsByPeriod(
      accountId,
      startDate,
      endDate,
    );

    return isIncome != null
        ? isIncome
            ? request.where((val) => val.category.isIncome).toList()
            : request.where((val) => !val.category.isIncome).toList()
        : request;
  }

  Future<TransactionResponseModel> getTransaction(id) async {
    final request = await transactionLink.getTransaction(id);

    return request;
  }
}
