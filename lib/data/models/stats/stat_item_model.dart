import 'package:freezed_annotation/freezed_annotation.dart';

part 'stat_item_model.freezed.dart';
part 'stat_item_model.g.dart';

@freezed
abstract class StatItemModel with _$StatItemModel {
  const factory StatItemModel({
    required String categoryId,
    required String categoryName,
    required String emoji,
    required String amount,
  }) = _StatItemModel;

  factory StatItemModel.fromJson(Map<String, Object?> json) =>
      _$StatItemModelFromJson(json);
}
