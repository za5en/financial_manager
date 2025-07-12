import 'package:financial_manager/domain/link/transactions_link.dart';
import 'package:financial_manager/view/states/finances/finances_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'finances_state.dart';
part 'finances_cubit.freezed.dart';

class FinancesCubit extends Cubit<FinancesState> {
  final bool isIncome;
  final TransactionLink transactionLink = TransactionLink();

  FinancesCubit({required this.isIncome}) : super(FinancesState.loading());

  void getHistory() async {
    emit(FinancesState.loading());
    try {
      final response = await transactionLink.getTransactionsByPeriod(
        1,
        DateTime.now().copyWith(hour: 0, minute: 0),
        DateTime.now().copyWith(hour: 23, minute: 59),
      );

      final result = await compute(
        FinancesViewModel.fromTransactionDetails,
        response,
      );

      emit(FinancesState.content(result));
    } on Exception catch (e) {
      emit(FinancesState.error(e));
    }
  }
}
