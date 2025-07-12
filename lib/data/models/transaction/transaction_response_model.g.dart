// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionResponseModel _$TransactionResponseModelFromJson(
  Map<String, dynamic> json,
) => _TransactionResponseModel(
  id: (json['id'] as num?)?.toInt(),
  account: json['account'] == null
      ? null
      : AccountBriefModel.fromJson(json['account'] as Map<String, dynamic>),
  category: json['category'] == null
      ? null
      : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
  amount: json['amount'] as String?,
  transactionDate: json['transactionDate'] as String?,
  comment: json['comment'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$TransactionResponseModelToJson(
  _TransactionResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'account': instance.account,
  'category': instance.category,
  'amount': instance.amount,
  'transactionDate': instance.transactionDate,
  'comment': instance.comment,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
