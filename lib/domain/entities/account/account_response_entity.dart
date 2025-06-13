import 'package:financial_manager/domain/entities/stats/stat_item_entity.dart';

class AccountResponseEntity {
  final int id;
  final String name;
  final String balance;
  final String currency;
  final StatItemEntity incomeStats;
  final StatItemEntity expenseStats;
  final String createdAt;
  final String updatedAt;

  AccountResponseEntity({
    required this.id,
    required this.name,
    required this.balance,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.incomeStats,
    required this.expenseStats,
  });
}
