part of 'manage_transaction_cubit.dart';

@freezed
abstract class ManageTransactionState with _$ManageTransactionState {
  const factory ManageTransactionState.loading() = EditLoading;
  const factory ManageTransactionState.content(
    ManageTransactionViewModel content,
  ) = EditContent;
  const factory ManageTransactionState.error(Exception error) = EditError;
}
