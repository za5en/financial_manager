import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_request_model.freezed.dart';
part 'transaction_request_model.g.dart';

@freezed
abstract class TransactionRequestModel with _$TransactionRequestModel {
  const factory TransactionRequestModel({
    required int accountId,
    required int categoryId,
    required String amount,
    required String transactionDate,
    String? comment,
  }) = _TransactionRequestModel;

  factory TransactionRequestModel.fromJson(Map<String, Object?> json) =>
      _$TransactionRequestModelFromJson(json);
}
