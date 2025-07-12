part of 'account_and_categories_cubit.dart';

@freezed
abstract class AccountAndCategoriesState with _$AccountAndCategoriesState {
  const factory AccountAndCategoriesState.loading() = Loading;
  const factory AccountAndCategoriesState.content({
    AccountAndCategoriesViewModel? content,
    ManageTransactionLocal? transactionContent,
  }) = Content;
  const factory AccountAndCategoriesState.error(Exception error) = CustomError;
}
