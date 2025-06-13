import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_create_request_model.freezed.dart';
part 'account_create_request_model.g.dart';

@freezed
abstract class AccountCreateRequestModel with _$AccountCreateRequestModel {
  const factory AccountCreateRequestModel({
    required String name,
    required String balance,
    required String currency,
  }) = _AccountCreateRequestModel;

  factory AccountCreateRequestModel.fromJson(Map<String, Object?> json) =>
      _$AccountCreateRequestModelFromJson(json);
}
