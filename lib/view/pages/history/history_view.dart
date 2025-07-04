import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/view/link/account_transactions.dart';
import 'package:financial_manager/view/pages/history/analysis_view.dart';
import 'package:financial_manager/view/pages/history/manage_view.dart';
import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key, required this.isIncome});
  final bool isIncome;

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

const List<String> sortOptions = [
  'По дате (▼)',
  'По дате (▲)',
  'По сумме (▼)',
  'По сумме (▲)',
];

class _HistoryViewState extends State<HistoryView> {
  DateTime? startDate;
  DateTime? endDate;
  String selectedSort = sortOptions.first;
  List<TransactionResponseModel> transactions = [];
  double sum = 0;

  Future<void> _selectDate(bool isStart) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      locale: const Locale('ru', 'RU'),
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime(
        DateTime.now().year - 5,
        DateTime.now().month,
        DateTime.now().day,
      ),
      lastDate: DateTime(
        DateTime.now().year + 5,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );

    if (pickedDate != null) {
      if (isStart) {
        if (pickedDate.isAfter(endDate ?? DateTime.now())) {
          pickedDate =
              endDate?.copyWith(
                hour: 0,
                minute: 0,
                second: 0,
                millisecond: 0,
                microsecond: 0,
              ) ??
              DateTime.now().copyWith(
                hour: 0,
                minute: 0,
                second: 0,
                millisecond: 0,
                microsecond: 0,
              );
        }
      } else {
        if (pickedDate.isBefore(startDate ?? DateTime.now())) {
          pickedDate =
              endDate?.copyWith(
                hour: 23,
                minute: 59,
                second: 59,
                millisecond: 0,
                microsecond: 0,
              ) ??
              DateTime.now().copyWith(
                hour: 23,
                minute: 59,
                second: 59,
                millisecond: 0,
                microsecond: 0,
              );
        }
      }

      final accountTransactions = AccountTransactions();

      final response = await accountTransactions.getTransactionsByPeriod(
        1,
        isStart ? pickedDate : startDate,
        isStart ? endDate : pickedDate,
        isIncome: widget.isIncome,
      );

      countSum(response);

      setState(() {
        transactions = response;
        updateSort(selectedSort);
        if (isStart) {
          startDate = pickedDate;
        } else {
          endDate = pickedDate;
        }
      });
    }
  }

  void getTransactions() async {
    final accountTransactions = AccountTransactions();

    final response = await accountTransactions.getTransactionsByPeriod(
      1,
      startDate,
      endDate,
      isIncome: widget.isIncome,
    );

    countSum(response);

    setState(() {
      transactions = response;
      updateSort(selectedSort);
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

  void updateSort(String? sortType) {
    if (sortType == sortOptions[0]) {
      transactions.sort(
        (b, a) => DateTime.parse(
          a.transactionDate,
        ).compareTo(DateTime.parse(b.transactionDate)),
      );
    } else if (sortType == sortOptions[0]) {
      transactions.sort(
        (a, b) => DateTime.parse(
          a.transactionDate,
        ).compareTo(DateTime.parse(b.transactionDate)),
      );
    } else if (sortType == sortOptions[2]) {
      transactions.sort(
        (b, a) => double.parse(a.amount).compareTo(double.parse(b.amount)),
      );
    } else {
      transactions.sort(
        (a, b) => double.parse(a.amount).compareTo(double.parse(b.amount)),
      );
    }
    setState(() {
      selectedSort = sortType ?? sortOptions.first;
    });
  }

  @override
  void initState() {
    var startDay = DateTime.now().copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
    startDate ??= DateTime(startDay.year, startDay.month - 1, startDay.day);
    endDate ??= startDay.add(Duration(days: 1)).subtract(Duration(seconds: 1));
    getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: FAppbar(
        title: 'Моя история',
        leading: Padding(
          padding: EdgeInsets.all(h * 0.02),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: FSvg(assetName: 'assets/images/back_arrow.svg'),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => AnalysisView(isIncome: widget.isIncome),
                  ),
                );
              },
              child: FSvg(assetName: 'assets/images/analysis.svg'),
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
            name: 'Начало',
            isEmojiInContainer: true,
            rightSide: InkWell(
              onTap: () {
                _selectDate(true);
              },
              child: Text(
                DateFormat('dd.MM.yyyy').format(startDate ?? DateTime.now()),
              ),
            ),
            backgroundColor: Color.fromRGBO(212, 250, 230, 1),
          ),
          FListLine(
            height: h * 0.06,
            leftPadding: w * 0.04,
            rightPadding: w * 0.04,
            name: 'Конец',
            isEmojiInContainer: true,
            rightSide: InkWell(
              onTap: () {
                _selectDate(false);
              },
              child: Text(
                DateFormat('dd.MM.yyyy').format(endDate ?? DateTime.now()),
              ),
            ),
            backgroundColor: Color.fromRGBO(212, 250, 230, 1),
          ),
          FListLine(
            height: h * 0.06,
            leftPadding: w * 0.04,
            rightPadding: w * 0.04,
            name: 'Сортировка',
            isEmojiInContainer: true,
            rightSide: DropdownButton<String>(
              items:
                  sortOptions.map<DropdownMenuItem<String>>((String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  }).toList(),
              value: selectedSort,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              onChanged: updateSort,
              alignment: Alignment.centerRight,
              underline: Container(height: 0),
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Color.fromRGBO(212, 250, 230, 1),
          ),
          FListLine(
            height: h * 0.06,
            leftPadding: w * 0.04,
            rightPadding: w * 0.04,
            name: 'Сумма',
            rightSide:
                transactions.isNotEmpty
                    ? Text('$sum ${transactions[0].account.currency}')
                    : Text('$sum ₽'),
            backgroundColor: Color.fromRGBO(212, 250, 230, 1),
            isEmojiInContainer: true,
          ),
          Visibility(
            visible: transactions.isEmpty,
            child: Padding(
              padding: EdgeInsets.only(top: h * 0.25),
              child: Text('Транзакции за указанный период не найдены'),
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
                    emoji: transactions[index].category.emoji,
                    isEmojiInContainer: true,
                    rightSide: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: w * 0.035),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${transactions[index].amount} ${transactions[index].account.currency}',
                              ),
                              Text(
                                DateFormat('dd.MM.yyyy HH:mm').format(
                                  DateTime.parse(
                                    transactions[index].transactionDate,
                                  ),
                                ),
                              ),
                            ],
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
    );
  }
}
