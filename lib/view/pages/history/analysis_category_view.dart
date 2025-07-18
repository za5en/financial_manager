import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/i18n/app_localizations.dart';
import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnalysisCategoryView extends StatefulWidget {
  const AnalysisCategoryView({
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
  State<AnalysisCategoryView> createState() => _AnalysisCategoryViewState();
}

class _AnalysisCategoryViewState extends State<AnalysisCategoryView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: FAppbar(
        title: widget.categoryName,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Padding(
          padding: EdgeInsets.all(h * 0.02),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: FSvg(
              assetName: 'assets/images/back_arrow.svg',
              color:
                  Theme.of(context).primaryTextTheme.bodyMedium?.color ??
                  Color(0xFF1C1C22),
            ),
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
            rightSide: Text(
              widget.startDate,
              style: TextStyle(
                color:
                    Theme.of(context).primaryTextTheme.bodyMedium?.color ??
                    Color(0xFF1C1C22),
              ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          FListLine(
            height: h * 0.063,
            leftPadding: w * 0.04,
            rightPadding: w * 0.04,
            name:
                '${AppLocalizations.of(context)?.period ?? 'Период'}: ${AppLocalizations.of(context)?.historyEnd.toLowerCase() ?? 'конец'}',
            isEmojiInContainer: true,
            rightSide: Text(
              widget.endDate,
              style: TextStyle(
                color:
                    Theme.of(context).primaryTextTheme.bodyMedium?.color ??
                    Color(0xFF1C1C22),
              ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          FListLine(
            height: h * 0.06,
            leftPadding: w * 0.04,
            rightPadding: w * 0.04,
            name: AppLocalizations.of(context)?.historySum ?? 'Сумма',
            rightSide: Text(
              '${widget.sum} ${widget.currency}',
              style: TextStyle(
                color:
                    Theme.of(context).primaryTextTheme.bodyMedium?.color ??
                    Color(0xFF1C1C22),
              ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            isEmojiInContainer: true,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.transactions.length,
              itemBuilder: (builder, index) {
                return FListLine(
                  height: h * 0.077,
                  leftPadding: w * 0.04,
                  rightPadding: w * 0.03,
                  name:
                      widget.transactions[index].comment ??
                      (widget.transactions[index].category?.name ?? ''),
                  emoji: widget.transactions[index].category?.emoji,
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
                              '${widget.transactions[index].amount} ${widget.transactions[index].account?.currency}',
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).primaryTextTheme.bodyMedium?.color ??
                                    Color(0xFF1C1C22),
                              ),
                            ),
                            Text(
                              DateFormat('dd.MM.yyyy HH:mm').format(
                                DateTime.parse(
                                  widget.transactions[index].transactionDate ??
                                      '',
                                ),
                              ),
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).primaryTextTheme.bodyMedium?.color ??
                                    Color(0xFF1C1C22),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
