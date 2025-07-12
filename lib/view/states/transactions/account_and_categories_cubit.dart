import 'dart:developer';

import 'package:financial_manager/data/models/account/account_brief_model.dart';
import 'package:financial_manager/data/models/transaction/transaction_request_model.dart';
import 'package:financial_manager/domain/link/account_link.dart';
import 'package:financial_manager/domain/link/category_link.dart';
import 'package:financial_manager/domain/link/transactions_link.dart';
import 'package:financial_manager/view/states/account/account_local.dart';
import 'package:financial_manager/view/states/category/category_local.dart';
import 'package:financial_manager/view/states/transactions/account_and_categories_view_model.dart';
import 'package:financial_manager/view/states/transactions/manage_transaction_local.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_and_categories_state.dart';
part 'account_and_categories_cubit.freezed.dart';

class AccountAndCategoriesCubit extends Cubit<AccountAndCategoriesState> {
  final AccountLink accountLink = AccountLink();
  final CategoryLink categoryLink = CategoryLink();
  final TransactionLink transactionLink = TransactionLink();
  AccountAndCategoriesCubit() : super(AccountAndCategoriesState.loading());

  void getInfo(bool isEditMode, AccountBriefModel? realAccount) async {
    emit(AccountAndCategoriesState.loading());
    try {
      final account = await accountLink.getAccount();
      final accountLocal = account
          .map(
            (e) => AccountLocal.buildWith(
              e.id,
              e.name,
              double.parse(e.balance),
              e.currency,
            ),
          )
          .toList();

      if (isEditMode && accountLocal.first.name != (realAccount?.name ?? '')) {
        accountLocal.add(
          AccountLocal.buildWith(
            realAccount?.id ?? 1,
            realAccount?.name ?? '',
            double.parse(realAccount?.balance ?? '0'),
            realAccount?.currency ?? '₽',
          ),
        );
      }

      final categories = await categoryLink.getCategories();
      final categoriesLocal = categories
          .map((e) => CategoryLocal.buildWith(e.id, e.name, e.emoji))
          .toList();

      final viewModel = AccountAndCategoriesViewModel.buildWith(
        accountLocal,
        categoriesLocal,
      );

      emit(AccountAndCategoriesState.content(content: viewModel));
    } on Exception catch (e) {
      emit(AccountAndCategoriesState.error(e));
    }
  }

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
          transactionDate: transactionDate.toUtc().toString().replaceAll(
            ' ',
            'T',
          ),
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
          transactionDate: transactionDate.toUtc().toString().replaceAll(
            ' ',
            'T',
          ),
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
