import 'package:financial_manager/data/models/category/category_model.dart';
import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/view/link/account_transactions.dart';
import 'package:financial_manager/view/pages/history/category_view.dart';
import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnalysisView extends StatefulWidget {
  const AnalysisView({super.key, required this.isIncome});
  final bool isIncome;

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  DateTime? startDate;
  DateTime? endDate;
  double sum = 0;
  List<TransactionResponseModel> transactions = [];
  List<CategoryModel> categories = [];
  Map<int, double> categoriesSum = {};
  int touchedIndex = -1;

  List<Color> colors = [
    Color.fromRGBO(252, 227, 0, 1),
    Color.fromRGBO(255, 95, 0, 1),
    Color.fromRGBO(42, 232, 129, 1),
    Color.fromRGBO(228, 105, 98, 1),
  ];

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
        if (isStart) {
          startDate = pickedDate;
        } else {
          endDate = pickedDate;
        }
      });
    }
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
      groupInCategories();
    });
  }

  void groupInCategories() {
    Set<CategoryModel> newCategories = {};
    for (var transaction in transactions) {
      newCategories.add(transaction.category);
      if (categoriesSum[transaction.category.id] == null) {
        categoriesSum[transaction.category.id] = double.parse(
          transaction.amount,
        );
      } else {
        categoriesSum[transaction.category.id] =
            categoriesSum[transaction.category.id]! +
            double.parse(transaction.amount);
      }
    }
    categories = newCategories.toList();
    categories.sort(
      (b, a) => categoriesSum[a.id]!.compareTo(categoriesSum[b.id]!),
    );
  }

  String cutText(String str) {
    return '${str.substring(0, 10)}...';
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
        title: 'Анализ',
        backgroundColor: Color.fromRGBO(254, 247, 255, 1),
        leading: Padding(
          padding: EdgeInsets.all(h * 0.02),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: FSvg(assetName: 'assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: Column(
        children: [
          FListLine(
            height: h * 0.06,
            leftPadding: w * 0.04,
            rightPadding: w * 0.04,
            name: 'Период: начало',
            isEmojiInContainer: true,
            rightSide: InkWell(
              onTap: () {
                _selectDate(true);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: h * 0.004,
                  horizontal: w * 0.03,
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(42, 232, 129, 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  DateFormat('dd.MM.yyyy').format(startDate ?? DateTime.now()),
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            backgroundColor: Color.fromRGBO(254, 247, 255, 1),
          ),
          FListLine(
            height: h * 0.063,
            leftPadding: w * 0.04,
            rightPadding: w * 0.04,
            name: 'Период: конец',
            isEmojiInContainer: true,
            rightSide: InkWell(
              onTap: () {
                _selectDate(false);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: h * 0.004,
                  horizontal: w * 0.03,
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(42, 232, 129, 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  DateFormat('dd.MM.yyyy').format(endDate ?? DateTime.now()),
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            backgroundColor: Color.fromRGBO(254, 247, 255, 1),
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
            backgroundColor: Color.fromRGBO(254, 247, 255, 1),
            isEmojiInContainer: true,
          ),
          SizedBox(
            height: h * 0.3,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex =
                              pieTouchResponse
                                  .touchedSection!
                                  .touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 100,
                    sections: showingSections(),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: h * 0.15,
                    width: w * 0.3,
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      itemBuilder: (builder, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: h * 0.001,
                            bottom: h * 0.001,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                touchedIndex = index;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: colors[index % 4],
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.005),
                                  child: Text(
                                    '${((categoriesSum[categories[index].id] ?? 1) / sum * 100).toStringAsFixed(2)}% ${categories[index].name.length > 12 ? cutText(categories[index].name) : categories[index].name}',
                                    style: TextStyle(fontSize: 11),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (builder, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => CategoryView(
                              categoryName: categories[index].name,
                              startDate: DateFormat(
                                'dd.MM.yyyy',
                              ).format(startDate ?? DateTime.now()),
                              endDate: DateFormat(
                                'dd.MM.yyyy',
                              ).format(endDate ?? DateTime.now()),
                              sum:
                                  categoriesSum[categories[index].id]
                                      .toString(),
                              currency:
                                  transactions.isNotEmpty
                                      ? transactions[0].account.currency
                                      : '₽',
                              transactions:
                                  transactions
                                      .where(
                                        (item) =>
                                            item.category.id ==
                                            categories[index].id,
                                      )
                                      .toList(),
                            ),
                      ),
                    );
                  },
                  child: FListLine(
                    height: h * 0.077,
                    leftPadding: w * 0.04,
                    rightPadding: w * 0.03,
                    name: categories[index].name,
                    description:
                        transactions.isNotEmpty
                            ? transactions
                                .lastWhere(
                                  (item) =>
                                      item.category.id == categories[index].id,
                                )
                                .comment
                            : null,
                    emoji: categories[index].emoji,
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
                                '${((categoriesSum[categories[index].id] ?? 1) / sum * 100).toStringAsFixed(4)}%',
                              ),
                              Text(
                                '${categoriesSum[categories[index].id]} ${transactions[0].account.currency}',
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

  List<PieChartSectionData> showingSections() {
    return List.generate(categories.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 20.0 : 15.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: colors[i % 4],
        value: (categoriesSum[categories[i].id] ?? 1) / sum * 100,
        title: '',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          shadows: shadows,
        ),
        badgeWidget:
            isTouched
                ? Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colors[i % 4],
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Text(
                    '${((categoriesSum[categories[i].id] ?? 1) / sum * 100).toStringAsFixed(2)}%\n${categories[i].name}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
                : null,
      );
    });
  }
}
