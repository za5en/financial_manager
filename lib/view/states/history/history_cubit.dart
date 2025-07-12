import 'package:financial_manager/domain/link/transactions_link.dart';
import 'package:financial_manager/view/states/history/history_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_state.dart';
part 'history_cubit.freezed.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final bool isIncome;
  final TransactionLink transactionLink = TransactionLink();

  HistoryCubit({required this.isIncome}) : super(HistoryState.loading());

  void getHistory(DateTime startDate, DateTime endDate) async {
    emit(HistoryState.loading());
    try {
      final response = await transactionLink.getTransactionsByPeriod(
        1,
        startDate,
        endDate,
      );

      final result = await compute(
        HistoryViewModel.fromTransactionDetails,
        response,
      );

      emit(HistoryState.content(result, 0));
    } on Exception catch (e) {
      emit(HistoryState.error(e));
    }
  }
}
