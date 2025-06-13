import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_state_model.freezed.dart';
part 'account_state_model.g.dart';

@freezed
abstract class AccountStateModel with _$AccountStateModel {
  const factory AccountStateModel({
    required int id,
    required String name,
    required String balance,
    required String currency,
  }) = _AccountStateModel;

  factory AccountStateModel.fromJson(Map<String, Object?> json) =>
      _$AccountStateModelFromJson(json);
}
