import 'dart:async';
import 'dart:math';

import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/i18n/app_localizations.dart';
import 'package:financial_manager/view/link/account_transactions.dart';
import 'package:financial_manager/view/states/account/account_cubit.dart';
import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_error.dart';
import 'package:financial_manager/view/widgets/f_floating_action_button.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:financial_manager/view/widgets/f_loading.dart';
import 'package:financial_manager/view/widgets/f_red_button.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shake/shake.dart';
import 'package:spoiler_widget/spoiler_widget.dart';
import 'package:fl_chart/fl_chart.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  String currentCurrency = '₽';
  bool isEditing = false;
  String tempName = '';
  bool showBalance = false;
  bool isDown = false;
  DateTime? startDate;
  DateTime? endDate;
  List<TransactionResponseModel> transactions = [];
  List<double> days = [];

  final TextEditingController controller = TextEditingController();

  late ShakeDetector detector;

  List<AccelerometerEvent> _accelerometerValues = [];
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  void getTransactions() async {
    final accountTransactions = AccountTransactions();

    final response = await accountTransactions.getTransactionsByPeriod(
      134,
      startDate,
      endDate,
    );

    for (var transaction in response) {
      int index =
          daysBetween(
            startDate ?? DateTime.now().subtract(Duration(days: 30)),
            DateTime.parse(transaction.transactionDate ?? ''),
          ) -
          1;
      if (index >= 0 && index <= 30) {
        if (transaction.category?.isIncome ?? true) {
          days[index] += double.parse(transaction.amount ?? '1');
        } else {
          days[index] -= double.parse(transaction.amount ?? '1');
        }
      }
    }

    if (mounted) {
      setState(() {
        transactions = response;
      });
    }
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 30; i++) {
      days.add(0);
    }
    detector = ShakeDetector.waitForStart(
      onPhoneShake: (ShakeEvent event) {
        setState(() {
          showBalance = !showBalance;
        });
      },
    );
    detector.startListening();

    _accelerometerSubscription = accelerometerEvents.listen((event) {
      setState(() {
        _accelerometerValues = [event];
        if (_accelerometerValues[0].y < -5) {
          if (!isDown) {
            showBalance = !showBalance;
          }
          isDown = true;
        }
        if (_accelerometerValues[0].y >= -5) {
          isDown = false;
        }
      });
    });

    var startDay = DateTime.now().copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
    startDate ??= startDay.subtract(Duration(days: 30));
    endDate ??= startDay.add(Duration(days: 1)).subtract(Duration(seconds: 1));

    getTransactions();

    context.read<AccountCubit>().getAccount();
  }

  @override
  void dispose() {
    super.dispose();
    _accelerometerSubscription.cancel();
    detector.stopListening();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    final currencies = [
      [
        AppLocalizations.of(context)?.ruble ?? 'Российский рубль ₽',
        Icons.currency_ruble_outlined,
        '₽',
        'RUB',
      ],
      [
        AppLocalizations.of(context)?.dollar ?? 'Американский доллар \$',
        Icons.attach_money_outlined,
        '\$',
        'USD',
      ],
      [
        AppLocalizations.of(context)?.euro ?? 'Евро',
        Icons.euro_outlined,
        '€',
        'EUR',
      ],
      [AppLocalizations.of(context)?.cancel ?? 'Отмена', Icons.cancel_outlined],
    ];

    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) => switch (state) {
        Loading() => FLoading(),
        CustomError() => FError(message: 'Error'),
        Content() => Scaffold(
          appBar: FAppbar(
            title: AppLocalizations.of(context)?.account ?? 'Мой счет',
            leading: isEditing
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isEditing = !isEditing;
                        controller.text = '';
                      });
                    },
                    child: Icon(
                      Icons.close_outlined,
                      color: Color.fromRGBO(73, 69, 79, 1),
                    ),
                  )
                : null,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (isEditing && tempName != '') {
                        context.read<AccountCubit>().updateName(
                          tempName,
                          state.content.items.first,
                        );
                        tempName = '';
                        controller.text = '';
                      }
                      isEditing = !isEditing;
                    });
                  },
                  child: isEditing
                      ? Icon(
                          Icons.check_outlined,
                          color: Color.fromRGBO(73, 69, 79, 1),
                        )
                      : FSvg(assetName: 'assets/images/edit.svg'),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              FListLine(
                height: h * 0.06,
                leftPadding: w * 0.04,
                rightPadding: 0,
                name: state.content.items.first.name,
                nameColor: Color(0xFF1C1C22),
                onNameChanged: (text) {
                  setState(() => tempName = text);
                },
                controller: controller,
                autofocus: true,
                isEmojiInContainer: true,
                icon: isEditing
                    ? Icon(
                        Icons.person_outline,
                        color: Color.fromRGBO(73, 69, 79, 1),
                      )
                    : null,
                editName: isEditing ? true : false,
                emoji: !isEditing ? '💰' : null,
                emojiBackground: !isEditing ? Colors.white : null,
                rightSide: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: w * 0.035),
                      child: showBalance
                          ? Text(
                              '${state.content.items.first.balance.toStringAsFixed(2)} ${state.content.items.first.currency}',
                              style: TextStyle(
                                color: isEditing
                                    ? Theme.of(context)
                                              .primaryTextTheme
                                              .bodyMedium
                                              ?.color ??
                                          Color(0xFF1C1C22)
                                    : Color(0xFF1C1C22),
                              ),
                            )
                          : SpoilerText(
                              text:
                                  '${state.content.items.first.balance.toStringAsFixed(2)} ${state.content.items.first.currency}',
                              config: TextSpoilerConfig(
                                isEnabled: !showBalance,
                                enableFadeAnimation: true,
                                particleColor: Color.fromRGBO(
                                  218,
                                  218,
                                  218,
                                  0.498,
                                ),
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  color: isEditing
                                      ? Theme.of(context)
                                                .primaryTextTheme
                                                .bodyMedium
                                                ?.color ??
                                            Color(0xFF1C1C22)
                                      : Color(0xFF1C1C22),
                                ),
                              ),
                            ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: h * 0.06,
                        padding: EdgeInsets.only(
                          right: isEditing ? w * 0.02 : w * 0.04,
                          left: isEditing ? w * 0.02 : 0,
                        ),
                        color: isEditing
                            ? Color.fromRGBO(228, 105, 98, 1)
                            : Color.fromRGBO(212, 250, 230, 1),
                        child: FSvg(
                          assetName: isEditing
                              ? 'assets/images/delete.svg'
                              : 'assets/images/more.svg',
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: isEditing
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Color.fromRGBO(212, 250, 230, 1),
              ),
              Visibility(
                visible: !isEditing,
                child: FListLine(
                  height: h * 0.06,
                  leftPadding: 0,
                  rightPadding: w * 0.04,
                  name: AppLocalizations.of(context)?.currency ?? 'Валюта',
                  nameColor: Color(0xFF1C1C22),
                  isEmojiInContainer: true,
                  bottomBorderColor: Colors.transparent,
                  rightSide: InkWell(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: w * 0.035),
                          child: Text(currentCurrency),
                        ),
                        FSvg(assetName: 'assets/images/more.svg'),
                      ],
                    ),
                    onTap: () {
                      showModalBottomSheet<void>(
                        backgroundColor: Theme.of(
                          context,
                        ).scaffoldBackgroundColor,
                        context: context,
                        showDragHandle: true,
                        useRootNavigator: true,
                        builder: (BuildContext modalContext) {
                          return SizedBox(
                            height: currencies.length * h * 0.08,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: currencies.length,
                                      itemBuilder: (builder, index) {
                                        return InkWell(
                                          onTap: () {
                                            if (currencies[index][0] ==
                                                (AppLocalizations.of(
                                                      modalContext,
                                                    )?.cancel ??
                                                    'Отмена')) {
                                              Navigator.pop(modalContext);
                                            } else {
                                              setState(() {
                                                currentCurrency =
                                                    currencies[index][2]
                                                        as String;
                                              });
                                              context
                                                  .read<AccountCubit>()
                                                  .setCurrency(
                                                    currencies[index][3]
                                                        as String,
                                                    state.content.items.first,
                                                  );
                                              Navigator.pop(modalContext);
                                            }
                                          },
                                          child: FListLine(
                                            height: h * 0.077,
                                            leftPadding: w * 0.04,
                                            rightPadding: w * 0.03,
                                            name:
                                                currencies[index][0] as String,
                                            isEmojiInContainer: false,
                                            nameColor:
                                                currencies[index][0] ==
                                                    (AppLocalizations.of(
                                                          modalContext,
                                                        )?.cancel ??
                                                        'Отмена')
                                                ? Colors.white
                                                : null,
                                            icon: Icon(
                                              currencies[index][1] as IconData,
                                              color:
                                                  currencies[index][0] !=
                                                      (AppLocalizations.of(
                                                            modalContext,
                                                          )?.cancel ??
                                                          'Отмена')
                                                  ? Theme.of(context)
                                                            .primaryTextTheme
                                                            .bodyMedium
                                                            ?.color ??
                                                        Color(0xFF1C1C22)
                                                  : Colors.white,
                                            ),
                                            rightSide: SizedBox(),
                                            backgroundColor:
                                                currencies[index][0] !=
                                                    (AppLocalizations.of(
                                                          modalContext,
                                                        )?.cancel ??
                                                        'Отмена')
                                                ? Theme.of(
                                                    context,
                                                  ).scaffoldBackgroundColor
                                                : Color.fromRGBO(
                                                    228,
                                                    105,
                                                    98,
                                                    1,
                                                  ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  backgroundColor: Color.fromRGBO(212, 250, 230, 1),
                ),
              ),
              Visibility(
                visible: !isEditing,
                child: Padding(
                  padding: EdgeInsets.only(top: h * 0.04),
                  child: SizedBox(
                    height: h * 0.3,
                    width: w * 0.95,
                    child: BarChart(
                      BarChartData(
                        barTouchData: barTouchData,
                        titlesData: titlesData,
                        borderData: borderData,
                        barGroups: barGroups,
                        gridData: const FlGridData(show: false),
                        alignment: BarChartAlignment.spaceAround,
                        maxY: days.reduce(max),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isEditing,
                child: FRedButton(
                  onPressed: () {},
                  width: w * 0.92,
                  height: h * 0.044,
                  topPadding: h * 0.036,
                  name:
                      AppLocalizations.of(context)?.deleteAccount ??
                      'Удалить счет',
                ),
              ),
            ],
          ),
          floatingActionButton: FFloatingActionButton(onPressed: () {}),
        ),
        _ => FLoading(),
      },
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: true,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (group) => Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem:
          (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY == 1
                  ? '0 $currentCurrency'
                  : '${rod.toY.toStringAsFixed(2)} $currentCurrency',
              TextStyle(
                color:
                    Theme.of(context).primaryTextTheme.bodyMedium?.color ??
                    Color(0xFF1C1C22),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            );
          },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color:
          Theme.of(context).primaryTextTheme.bodyMedium?.color ??
          Color(0xFF1C1C22),
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = DateFormat(
          'dd.MM',
        ).format(startDate ?? DateTime.now().subtract(Duration(days: 30)));
        break;
      case 14:
        text = DateFormat('dd.MM').format(
          startDate?.add(Duration(days: 15)) ??
              DateTime.now().subtract(Duration(days: 15)),
        );
        break;
      case 28:
        text = DateFormat('dd.MM').format(endDate ?? DateTime.now());
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );

  FlBorderData get borderData => FlBorderData(show: false);

  List<BarChartGroupData> get barGroups {
    return List.generate(days.length, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: days[i] == 0
                ? 1
                : days[i] < 0
                ? days[i] * -1
                : days[i],
            color: days[i] < 0
                ? Color.fromRGBO(255, 95, 0, 1)
                : Color.fromRGBO(42, 232, 129, 1),
          ),
        ],
      );
    });
  }
}
