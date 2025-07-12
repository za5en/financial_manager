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
  final List<TrancactionLocal> expenseItems;

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
    List<TrancactionLocal> expenseItems,
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

class TrancactionLocal {
  final int id;
  final String emoji;
  final String category;
  final String? comment;
  final int amount;
  final String currency;
  final DateTime transactionDate;

  TrancactionLocal._({
    required this.id,
    required this.emoji,
    required this.category,
    required this.comment,
    required this.amount,
    required this.currency,
    required this.transactionDate,
  });

  factory TrancactionLocal.buildWith(
    int id,
    String emoji,
    String category,
    String? comment,
    int amount,
    String currency,
    DateTime transactionDate,
  ) => TrancactionLocal._(
    id: id,
    emoji: emoji,
    category: category,
    comment: comment,
    amount: amount,
    currency: currency,
    transactionDate: transactionDate,
  );
}
