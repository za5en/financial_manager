import 'package:financial_manager/view/states/account/account_local.dart';
import 'package:financial_manager/view/states/category/category_local.dart';

class ManageTransactionLocal {
  final int id;
  final String emoji;
  final AccountLocal account;
  final CategoryLocal category;
  final DateTime transactionDate;
  final String? comment;
  final double amount;
  final String currency;

  ManageTransactionLocal._({
    required this.id,
    required this.emoji,
    required this.account,
    required this.category,
    required this.transactionDate,
    required this.comment,
    required this.amount,
    required this.currency,
  });

  factory ManageTransactionLocal.buildWith(
    int id,
    String emoji,
    int categoryId,
    int accountId,
    String accountName,
    String categoryName,
    DateTime transactionDate,
    String? comment,
    double amount,
    String currency,
  ) => ManageTransactionLocal._(
    id: id,
    emoji: emoji,
    account: AccountLocal.buildWith(accountId, accountName, amount, currency),
    category: CategoryLocal.buildWith(categoryId, categoryName, emoji),
    transactionDate: transactionDate,
    comment: comment,
    amount: amount,
    currency: currency,
  );
}

class TotalAmount {
  final int totalAmount;
  final String currency;

  TotalAmount._({required this.totalAmount, required this.currency});

  factory TotalAmount.buildWith(int totalAmount, String? currency) =>
      TotalAmount._(totalAmount: totalAmount, currency: currency ?? '');
}
