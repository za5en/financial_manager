import 'package:financial_manager/domain/entities/account/account_brief_entity.dart';
import 'package:financial_manager/domain/entities/category/category_entity.dart';

class TransactionResponseEntity {
  final int id;
  final AccountBriefEntity account;
  final CategoryEntity category;
  final String amount;
  final String transactionDate;
  final String createdAt;
  final String updatedAt;
  final String? comment;

  TransactionResponseEntity({
    required this.id,
    required this.account,
    required this.category,
    required this.amount,
    required this.transactionDate,
    required this.createdAt,
    required this.updatedAt,
    this.comment,
  });
}
