import 'package:financial_manager/view/states/account/account_local.dart';
import 'package:financial_manager/view/states/category/category_local.dart';

class TransactionLocal {
  final int id;
  final String emoji;
  final AccountLocal account;
  final CategoryLocal category;
  final DateTime transactionDate;
  final String? comment;
  final double amount;
  final String currency;

  TransactionLocal._({
    required this.id,
    required this.emoji,
    required this.account,
    required this.category,
    required this.transactionDate,
    required this.comment,
    required this.amount,
    required this.currency,
  });

  factory TransactionLocal.buildWith(
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
  ) => TransactionLocal._(
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

class TotalAmountItem {
  final int totalAmount;
  final String currencySign;

  TotalAmountItem._({required this.totalAmount, required this.currencySign});

  factory TotalAmountItem.buildWith(int totalAmount, String? currencySign) =>
      TotalAmountItem._(
        totalAmount: totalAmount,
        currencySign: currencySign ?? '',
      );
}
