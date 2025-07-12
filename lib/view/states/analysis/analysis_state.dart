part of 'analysis_cubit.dart';

@freezed
abstract class AnalysisState with _$AnalysisState {
  const factory AnalysisState.loading() = Loading;
  const factory AnalysisState.content(
    AnalysisViewModel content,
    AnalysisViewModel? previousContent,
  ) = Content;
  const factory AnalysisState.error(Exception error) = CustomError;
}
