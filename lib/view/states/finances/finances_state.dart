part of 'finances_cubit.dart';

@freezed
abstract class FinancesState with _$FinancesState {
  const factory FinancesState.loading() = Loading;
  const factory FinancesState.content(FinancesViewModel content) = Content;
  const factory FinancesState.error(Exception error) = CustomError;
}
