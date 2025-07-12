part of 'account_cubit.dart';

@freezed
abstract class AccountState with _$AccountState {
  const factory AccountState.loading() = Loading;
  const factory AccountState.content(AccountViewModel content) = Content;
  const factory AccountState.error(Exception error) = CustomError;
}
