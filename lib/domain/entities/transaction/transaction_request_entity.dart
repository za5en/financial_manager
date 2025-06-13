class TransactionRequestEntity {
  final int accountId;
  final int categoryId;
  final String amount;
  final String transactionDate;
  final String? comment;

  TransactionRequestEntity({
    required this.accountId,
    required this.categoryId,
    required this.amount,
    required this.transactionDate,
    this.comment,
  });
}
