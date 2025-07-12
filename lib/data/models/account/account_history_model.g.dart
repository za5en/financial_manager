// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountHistoryModel _$AccountHistoryModelFromJson(Map<String, dynamic> json) =>
    _AccountHistoryModel(
      id: (json['id'] as num).toInt(),
      accountId: (json['accountId'] as num).toInt(),
      changeType: $enumDecode(_$ChangeTypeEnumMap, json['changeType']),
      previousState: json['previousState'] == null
          ? null
          : AccountStateModel.fromJson(
              json['previousState'] as Map<String, dynamic>,
            ),
      newState: AccountStateModel.fromJson(
        json['newState'] as Map<String, dynamic>,
      ),
      changeTimestamp: json['changeTimestamp'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$AccountHistoryModelToJson(
  _AccountHistoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'accountId': instance.accountId,
  'changeType': _$ChangeTypeEnumMap[instance.changeType]!,
  'previousState': instance.previousState,
  'newState': instance.newState,
  'changeTimestamp': instance.changeTimestamp,
  'createdAt': instance.createdAt,
};

const _$ChangeTypeEnumMap = {
  ChangeType.creation: 'creation',
  ChangeType.modification: 'modification',
};
