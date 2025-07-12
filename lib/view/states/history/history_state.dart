part of 'history_cubit.dart';

@freezed
abstract class HistoryState with _$HistoryState {
  const factory HistoryState.loading() = Loading;
  const factory HistoryState.content(HistoryViewModel content, int sortType) =
      Content;
  const factory HistoryState.error(Exception error) = CustomError;
}
