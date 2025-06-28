// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionRequestModel _$TransactionRequestModelFromJson(
  Map<String, dynamic> json,
) => _TransactionRequestModel(
  accountId: (json['accountId'] as num).toInt(),
  categoryId: (json['categoryId'] as num).toInt(),
  amount: json['amount'] as String,
  transactionDate: json['transactionDate'] as String,
  comment: json['comment'] as String?,
);

Map<String, dynamic> _$TransactionRequestModelToJson(
  _TransactionRequestModel instance,
) => <String, dynamic>{
  'accountId': instance.accountId,
  'categoryId': instance.categoryId,
  'amount': instance.amount,
  'transactionDate': instance.transactionDate,
  'comment': instance.comment,
};
