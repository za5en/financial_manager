class TransactionEntity {
  final int id;
  final int accountId;
  final int categoryId;
  final String amount;
  final String transactionDate;
  final String createdAt;
  final String updatedAt;
  final String? comment;

  TransactionEntity({
    required this.id,
    required this.accountId,
    required this.categoryId,
    required this.amount,
    required this.transactionDate,
    required this.createdAt,
    required this.updatedAt,
    this.comment,
  });
}
