import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_update_model.freezed.dart';
part 'account_update_model.g.dart';

@freezed
abstract class AccountUpdateModel with _$AccountUpdateModel {
  const factory AccountUpdateModel({
    required String name,
    required String balance,
    required String currency,
  }) = _AccountUpdateModel;

  factory AccountUpdateModel.fromJson(Map<String, Object?> json) =>
      _$AccountUpdateModelFromJson(json);
}
