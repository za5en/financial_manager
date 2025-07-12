import 'package:financial_manager/data/models/category/category_model.dart';
import 'package:financial_manager/data/models/account/account_brief_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_response_model.freezed.dart';
part 'transaction_response_model.g.dart';

@freezed
abstract class TransactionResponseModel with _$TransactionResponseModel {
  const factory TransactionResponseModel({
    int? id,
    AccountBriefModel? account,
    CategoryModel? category,
    String? amount,
    String? transactionDate,
    String? comment,
    String? createdAt,
    String? updatedAt,
  }) = _TransactionResponseModel;

  factory TransactionResponseModel.fromJson(Map<String, Object?> json) =>
      _$TransactionResponseModelFromJson(json);
}
