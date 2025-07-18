class TotalAmountLocal {
  final int totalAmount;
  final String currency;

  TotalAmountLocal._({required this.totalAmount, required this.currency});

  factory TotalAmountLocal.buildWith(int totalAmount, String? currency) =>
      TotalAmountLocal._(totalAmount: totalAmount, currency: currency ?? '');
}

class TransactionCategoryLocal {
  final int id;
  final String emoji;
  final String category;
  final String? comment;
  final double proportion;
  final double amount;
  final String currency;
  final List<TransactionLocal> expenseItems;

  TransactionCategoryLocal._({
    required this.id,
    required this.emoji,
    required this.category,
    this.comment,
    required this.proportion,
    required this.amount,
    required this.currency,
    required this.expenseItems,
  });

  factory TransactionCategoryLocal.buildWith(
    int id,
    String emoji,
    String category,
    String? comment,
    double proportion,
    double amount,
    String currency,
    List<TransactionLocal> expenseItems,
  ) => TransactionCategoryLocal._(
    id: id,
    emoji: emoji,
    category: category,
    comment: comment,
    proportion: proportion,
    amount: amount,
    currency: currency,
    expenseItems: expenseItems,
  );
}

class TransactionLocal {
  final int id;
  final String emoji;
  final String category;
  final String? comment;
  final double amount;
  final String currency;
  final DateTime transactionDate;

  TransactionLocal._({
    required this.id,
    required this.emoji,
    required this.category,
    required this.comment,
    required this.amount,
    required this.currency,
    required this.transactionDate,
  });

  factory TransactionLocal.buildWith(
    int id,
    String emoji,
    String category,
    String? comment,
    double amount,
    String currency,
    DateTime transactionDate,
  ) => TransactionLocal._(
    id: id,
    emoji: emoji,
    category: category,
    comment: comment,
    amount: amount,
    currency: currency,
    transactionDate: transactionDate,
  );
}
