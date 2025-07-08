import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/i18n/app_localizations.dart';
import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({
    super.key,
    required this.categoryName,
    required this.startDate,
    required this.endDate,
    required this.sum,
    required this.currency,
    required this.transactions,
  });
  final String categoryName;
  final String startDate;
  final String endDate;
  final String sum;
  final String currency;
  final List<TransactionResponseModel> transactions;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: FAppbar(
        title: categoryName,
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
            name:
                '${AppLocalizations.of(context)?.period ?? 'Период'}: ${AppLocalizations.of(context)?.historyStart.toLowerCase() ?? 'конец'}',
            isEmojiInContainer: true,
            rightSide: Text(startDate),
            backgroundColor: Color.fromRGBO(254, 247, 255, 1),
          ),
          FListLine(
            height: h * 0.063,
            leftPadding: w * 0.04,
            rightPadding: w * 0.04,
            name:
                '${AppLocalizations.of(context)?.period ?? 'Период'}: ${AppLocalizations.of(context)?.historyEnd.toLowerCase() ?? 'конец'}',
            isEmojiInContainer: true,
            rightSide: Text(endDate),
            backgroundColor: Color.fromRGBO(254, 247, 255, 1),
          ),
          FListLine(
            height: h * 0.06,
            leftPadding: w * 0.04,
            rightPadding: w * 0.04,
            name: AppLocalizations.of(context)?.historySum ?? 'Сумма',
            rightSide: Text('$sum $currency'),
            backgroundColor: Color.fromRGBO(254, 247, 255, 1),
            isEmojiInContainer: true,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (builder, index) {
                return FListLine(
                  height: h * 0.077,
                  leftPadding: w * 0.04,
                  rightPadding: w * 0.03,
                  name:
                      transactions[index].comment ??
                      transactions[index].category.name,
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
                    ],
                  ),
                  backgroundColor: Color.fromRGBO(254, 247, 255, 1),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
