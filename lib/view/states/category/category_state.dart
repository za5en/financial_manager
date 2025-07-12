part of 'category_cubit.dart';

@freezed
abstract class CategoryState with _$CategoryState {
  const factory CategoryState.loading() = Loading;
  const factory CategoryState.content(CategoryViewModel content) = Content;
  const factory CategoryState.error(Exception error) = CustomError;
}
