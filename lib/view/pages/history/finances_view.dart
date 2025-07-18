import 'package:financial_manager/data/local/user_shared_preferences.dart';
import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/i18n/app_localizations.dart';
import 'package:financial_manager/view/link/account_transactions.dart';
import 'package:financial_manager/view/pages/history/manage_view.dart';
import 'package:financial_manager/view/states/finances/finances_cubit.dart';
import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_error.dart';
import 'package:financial_manager/view/widgets/f_floating_action_button.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:financial_manager/view/widgets/f_loading.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FinancesView extends StatefulWidget {
  const FinancesView({
    super.key,
    required this.isIncome,
    this.incomes,
    this.expenses,
  });
  final bool isIncome;
  final List? incomes;
  final List? expenses;

  @override
  State<FinancesView> createState() => _FinancesViewState();
}

class _FinancesViewState extends State<FinancesView> {
  List<TransactionResponseModel> transactions = [];
  double sum = 0;

  void getTransactions() async {
    final accountTransactions = AccountTransactions();

    final response = await accountTransactions.getTransactionsByPeriod(
      1,
      DateTime.now().copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      ),
      DateTime.now().copyWith(
        hour: 23,
        minute: 59,
        second: 59,
        millisecond: 0,
        microsecond: 0,
      ),
      isIncome: widget.isIncome,
    );

    countSum(response);

    if (mounted) {
      setState(() {
        transactions = response;
      });
    }
  }

  void countSum(transactions) {
    double localSum = 0;
    for (var transaction in transactions) {
      localSum += double.parse(transaction.amount);
    }

    if (mounted) {
      setState(() {
        sum = localSum;
      });
    }
  }

  @override
  void initState() {
    getTransactions();
    context.read<FinancesCubit>().getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: FAppbar(
        title: widget.isIncome
            ? AppLocalizations.of(context)?.incomes ?? 'Доходы сегодня'
            : AppLocalizations.of(context)?.expenses ?? 'Расходы сегодня',
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                context.push("${GoRouterState.of(context).uri}/history");
              },
              child: FSvg(assetName: 'assets/images/history.svg'),
            ),
          ),
        ],
      ),
      body: BlocBuilder<FinancesCubit, FinancesState>(
        builder: (context, state) => switch (state) {
          Loading() => FLoading(),
          CustomError() => FError(message: 'Error'),
          Content() => Column(
            children: [
              FListLine(
                height: h * 0.06,
                leftPadding: w * 0.04,
                rightPadding: w * 0.04,
                name: AppLocalizations.of(context)?.total ?? 'Всего',
                nameColor: Color(0xFF1C1C22),
                rightSide: transactions.isNotEmpty
                    ? Text('$sum ${transactions[0].account?.currency}')
                    : Text('$sum ₽'),
                backgroundColor: Color.fromRGBO(212, 250, 230, 1),
                isEmojiInContainer: true,
              ),
              Visibility(
                visible: transactions.isEmpty,
                child: Padding(
                  padding: EdgeInsets.only(top: h * 0.3),
                  child: Center(
                    child: Text(
                      widget.isIncome
                          ? AppLocalizations.of(context)?.noIncomes ??
                                'Доходов за сегодня нет'
                          : AppLocalizations.of(context)?.noExpenses ??
                                'Расходов за сегодня нет',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  itemBuilder: (builder, index) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          useRootNavigator: false,
                          barrierColor: Color(0x00ffffff),
                          builder: (BuildContext context) => ManageDialog(
                            isIncome: widget.isIncome,
                            isEditMode: true,
                            transaction: transactions[index],
                          ),
                        ).then((isConfirmed) {
                          if (isConfirmed == true && context.mounted) {
                            getTransactions();
                            context.read<FinancesCubit>().getHistory();
                          }
                        });
                      },
                      child: FListLine(
                        height: h * 0.077,
                        leftPadding: w * 0.04,
                        rightPadding: w * 0.03,
                        name: transactions[index].category?.name ?? '',
                        description: transactions[index].comment,
                        isEmojiInContainer: true,
                        emoji: widget.isIncome
                            ? transactions[index].category?.emoji
                            : null,
                        rightSide: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: w * 0.035),
                              child: Text(
                                '${transactions[index].amount} ${transactions[index].account?.currency}',
                                style: TextStyle(
                                  color:
                                      Theme.of(
                                        context,
                                      ).primaryTextTheme.bodyMedium?.color ??
                                      Color(0xFF1C1C22),
                                ),
                              ),
                            ),
                            FSvg(assetName: 'assets/images/more.svg'),
                          ],
                        ),
                        backgroundColor: Theme.of(
                          context,
                        ).scaffoldBackgroundColor,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          _ => FLoading(),
        },
      ),
      floatingActionButton: FFloatingActionButton(
        onPressed: () {
          if (UserSharedPreferences.settings.prefs.haptic ?? false) {
            HapticFeedback.lightImpact();
          }
          showDialog(
            context: context,
            useRootNavigator: false,
            barrierColor: Color(0x00ffffff),
            builder: (modalContext) =>
                ManageDialog(isIncome: widget.isIncome, isEditMode: false),
          ).then((isConfirmed) {
            if (isConfirmed == true && context.mounted) {
              getTransactions();
              context.read<FinancesCubit>().getHistory();
            }
          });
        },
      ),
    );
  }
}
