import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/domain/link/transactions_link.dart';
import 'package:financial_manager/view/states/analysis/analysis_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'analysis_state.dart';
part 'analysis_cubit.freezed.dart';

class AnalysisCubit extends Cubit<AnalysisState> {
  final bool isIncome;
  late final TransactionLink transactionLink;
  AnalysisViewModel? _previousViewModel;

  AnalysisCubit({required this.isIncome}) : super(AnalysisState.loading());

  void getHistory(DateTime startDate, DateTime endDate) async {
    if (state is Content) {
      _previousViewModel = (state as Content).content;
    }
    emit(AnalysisState.loading());
    try {
      transactionLink = TransactionLink();
      final response = await transactionLink.getTransactionsByPeriod(
        1,
        startDate,
        endDate,
      );

      List<TransactionResponseModel> resList = isIncome
          ? response.where((val) => val.category?.isIncome ?? true).toList()
          : response
                .where((val) => !(val.category?.isIncome ?? false))
                .toList();

      final result = await compute(
        AnalysisViewModel.fromTransactionDetails,
        resList,
      );

      emit(AnalysisState.content(result, _previousViewModel));
    } on Exception catch (e) {
      emit(AnalysisState.error(e));
    }
  }
}
