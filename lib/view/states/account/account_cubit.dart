import 'package:financial_manager/data/models/account/account_update_request_model.dart';
import 'package:financial_manager/domain/link/account_link.dart';
import 'package:financial_manager/view/states/account/account_local.dart';
import 'package:financial_manager/view/states/account/account_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_state.dart';
part 'account_cubit.freezed.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountLink accountLink = AccountLink();
  AccountCubit() : super(AccountState.loading());

  void getAccount() async {
    emit(AccountState.loading());
    try {
      final response = await accountLink.getAccount();
      final viewModel = await compute(
        AccountViewModel.fromAccountsList,
        response,
      );

      emit(AccountState.content(viewModel));
    } on Exception catch (e) {
      emit(AccountState.error(e));
    }
  }

  void updateName(String newName, AccountLocal account) async {
    emit(AccountState.loading());
    try {
      final response = await accountLink.updateAccount(
        account.id,
        AccountUpdateRequestModel(
          name: newName,
          balance: account.balance.toString(),
          currency: account.currency,
        ),
      );
      final viewModel = await compute(
        AccountViewModel.fromAccountModel,
        response,
      );

      emit(AccountState.content(viewModel));
    } on Exception catch (e) {
      emit(AccountState.error(e));
    }
    getAccount();
  }

  void setCurrency(String newCurrency, AccountLocal account) async {
    emit(AccountState.loading());
    try {
      final response = await accountLink.updateAccount(
        account.id,
        AccountUpdateRequestModel(
          name: account.name,
          balance: account.balance.toString(),
          currency: newCurrency,
        ),
      );
      final viewModel = await compute(
        AccountViewModel.fromAccountModel,
        response,
      );

      emit(AccountState.content(viewModel));
    } on Exception catch (e) {
      emit(AccountState.error(e));
    }
    getAccount();
  }

  void deleteAccount() async {
    emit(AccountState.loading());
  }
}
