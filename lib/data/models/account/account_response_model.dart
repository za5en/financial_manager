import 'package:financial_manager/data/models/stats/stat_item_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_response_model.freezed.dart';
part 'account_response_model.g.dart';

@freezed
abstract class AccountResponseModel with _$AccountResponseModel {
  const factory AccountResponseModel({
    required int id,
    required String name,
    required String balance,
    required String currency,
    required StatItemModel incomeStats,
    required StatItemModel expenseStats,
    required String createdAt,
    required String updatedAt,
  }) = _AccountResponseModel;

  factory AccountResponseModel.fromJson(Map<String, Object?> json) =>
      _$AccountResponseModelFromJson(json);
}
