import 'package:financial_manager/domain/entities/account/account_state_entity.dart';

class AccountHistoryEntity {
  final int id;
  final int accountId;
  final String changeType;
  final AccountStateEntity? previousState;
  final AccountStateEntity newState;
  final String changeTimestamp;
  final String createdAt;

  AccountHistoryEntity({
    required this.id,
    required this.accountId,
    required this.changeType,
    this.previousState,
    required this.newState,
    required this.changeTimestamp,
    required this.createdAt,
  });
}
