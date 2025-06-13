import 'package:financial_manager/data/models/account/account_history_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_history_response_model.freezed.dart';
part 'account_history_response_model.g.dart';

@freezed
abstract class AccountHistoryResponseModel with _$AccountHistoryResponseModel {
  const factory AccountHistoryResponseModel({
    required int accountId,
    required String accountName,
    required String currency,
    required String currentBalance,
    required List<AccountHistoryModel> history,
  }) = _AccountHistoryResponseModel;

  factory AccountHistoryResponseModel.fromJson(Map<String, Object?> json) =>
      _$AccountHistoryResponseModelFromJson(json);
}
