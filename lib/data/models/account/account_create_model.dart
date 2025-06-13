import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_create_model.freezed.dart';
part 'account_create_model.g.dart';

@freezed
abstract class AccountCreateModel with _$AccountCreateModel {
  const factory AccountCreateModel({
    required String name,
    required String balance,
    required String currency,
  }) = _AccountCreateModel;

  factory AccountCreateModel.fromJson(Map<String, Object?> json) =>
      _$AccountCreateModelFromJson(json);
}
