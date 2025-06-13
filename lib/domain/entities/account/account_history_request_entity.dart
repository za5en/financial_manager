import 'package:financial_manager/domain/entities/account/account_history_entity.dart';

class AccountHistoryResponseEntity {
  final int accountId;
  final String accountName;
  final String currency;
  final String currentBalance;
  final AccountHistoryEntity history;

  AccountHistoryResponseEntity({
    required this.accountId,
    required this.accountName,
    required this.currency,
    required this.currentBalance,
    required this.history,
  });
}
