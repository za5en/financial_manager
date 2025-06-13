import 'package:financial_manager/data/models/account/account_state_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_history_model.freezed.dart';
part 'account_history_model.g.dart';

@freezed
abstract class AccountHistoryModel with _$AccountHistoryModel {
  const factory AccountHistoryModel({
    required int id,
    required int accountId,
    required String changeType,
    AccountStateModel? previousState,
    required AccountStateModel newState,
    required String changeTimestamp,
    required String createdAt,
  }) = _AccountHistoryModel;

  factory AccountHistoryModel.fromJson(Map<String, Object?> json) =>
      _$AccountHistoryModelFromJson(json);
}
