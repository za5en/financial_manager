import 'package:financial_manager/data/models/transaction/transaction_model.dart';
import 'package:financial_manager/data/models/transaction/transaction_request_model.dart';
import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';

abstract interface class TransactionRepoDomain {
  Future<TransactionModel> createTransaction(
    TransactionRequestModel transactionRequest,
  );
  Future<TransactionResponseModel> getTransactionById(int id);
  Future<TransactionResponseModel> updateTransaction(
    int id,
    TransactionRequestModel transactionRequestModel,
  );
  Future<void> deleteTransaction(int id);
  Future<List<TransactionResponseModel>> getTransactionsByPeriod(
    int accountId,
    DateTime? startDate,
    DateTime? endDate,
  );
}
