import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/i18n/app_localizations.dart';
import 'package:financial_manager/view/link/account_transactions.dart';
import 'package:financial_manager/view/pages/history/history_view.dart';
import 'package:financial_manager/view/pages/history/manage_view.dart';
import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_floating_action_button.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';

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

    setState(() {
      transactions = response;
    });
  }

  void countSum(transactions) {
    double localSum = 0;
    for (var transaction in transactions) {
      localSum += double.parse(transaction.amount);
    }

    setState(() {
      sum = localSum;
    });
  }

  @override
  void initState() {
    getTransactions();
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryView(
                      isIncome: widget.isIncome,
                      defaultSort:
                          '${AppLocalizations.of(context)?.sortByDate ?? 'По дате'} (▼)',
                    ),
                  ),
                );
              },
              child: FSvg(assetName: 'assets/images/history.svg'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          FListLine(
            height: h * 0.06,
            leftPadding: w * 0.04,
            rightPadding: w * 0.04,
            name: AppLocalizations.of(context)?.total ?? 'Всего',
            rightSide: transactions.isNotEmpty
                ? Text('$sum ${transactions[0].account.currency}')
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
                    showDialog<void>(
                      context: context,
                      useRootNavigator: false,
                      barrierColor: Color(0x00ffffff),
                      builder: (BuildContext context) {
                        return ManageView(
                          isIncome: widget.isIncome,
                          isEditMode: true,
                          transactionId: transactions[index].id,
                        );
                      },
                    );
                  },
                  child: FListLine(
                    height: h * 0.077,
                    leftPadding: w * 0.04,
                    rightPadding: w * 0.03,
                    name: transactions[index].category.name,
                    description: transactions[index].comment,
                    isEmojiInContainer: true,
                    emoji: widget.isIncome
                        ? transactions[index].category.emoji
                        : null,
                    rightSide: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: w * 0.035),
                          child: Text(
                            '${transactions[index].amount} ${transactions[index].account.currency}',
                          ),
                        ),
                        FSvg(assetName: 'assets/images/more.svg'),
                      ],
                    ),
                    backgroundColor: Color.fromRGBO(254, 247, 255, 1),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FFloatingActionButton(
        onPressed: () {
          showDialog<void>(
            context: context,
            useRootNavigator: false,
            barrierColor: Color(0x00ffffff),
            builder: (BuildContext context) {
              return ManageView(isIncome: widget.isIncome, isEditMode: false);
            },
          );
        },
      ),
    );
  }
}
