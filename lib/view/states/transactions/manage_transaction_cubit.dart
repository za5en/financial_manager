import 'dart:developer';

import 'package:financial_manager/data/models/transaction/transaction_request_model.dart';
import 'package:financial_manager/domain/link/transactions_link.dart';
import 'package:financial_manager/view/states/transactions/manage_transaction_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manage_transaction_state.dart';
part 'manage_transaction_cubit.freezed.dart';

class ManageTransactionCubit extends Cubit<ManageTransactionState> {
  final TransactionLink transactionLink = TransactionLink();

  ManageTransactionCubit() : super(ManageTransactionState.loading());

  void createTransaction(
    int accountId,
    int categoryId,
    double amount,
    DateTime transactionDate,
    String? comment,
  ) async {
    try {
      await transactionLink.createTransaction(
        TransactionRequestModel(
          accountId: accountId,
          categoryId: categoryId,
          amount: amount.toString(),
          transactionDate: transactionDate.toString(),
          comment: comment,
        ),
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void updateTransaction(
    int id,
    int accountId,
    int categoryId,
    double amount,
    DateTime transactionDate,
    String? comment,
  ) async {
    try {
      await transactionLink.updateTransaction(
        id,
        TransactionRequestModel(
          accountId: accountId,
          categoryId: categoryId,
          amount: amount.toString(),
          transactionDate: transactionDate.toString(),
          comment: comment,
        ),
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void deleteTransaction(int id) async {
    try {
      await transactionLink.deleteTransaction(id);
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
