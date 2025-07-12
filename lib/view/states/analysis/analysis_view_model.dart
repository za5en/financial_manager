import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:collection/collection.dart';
import 'package:financial_manager/view/states/analysis/analysis_local.dart';

class AnalysisViewModel {
  final List<TransactionCategoryLocal> items;
  final TotalAmountLocal total;

  AnalysisViewModel._({required this.items, required this.total});

  factory AnalysisViewModel.buildWith(
    List<TransactionCategoryLocal> items,
    TotalAmountLocal total,
  ) => AnalysisViewModel._(items: items, total: total);

  factory AnalysisViewModel.fromTransactionDetails(
    List<TransactionResponseModel> transactionDetails,
  ) {
    final grouped = groupBy(transactionDetails, (e) => e.category?.id);
    int totalAmount = 0;
    String? sign;
    for (List<TransactionResponseModel> details in grouped.values) {
      for (TransactionResponseModel detail in details) {
        totalAmount += double.parse(detail.amount ?? '1').round();
      }
    }
    final categoriesExpencesList = grouped.entries.map((entry) {
      int categoryAmount = 0;
      String? categoryName;
      String? emoji;
      String? moneySign;
      final categoriesExpences = entry.value.map((e) {
        categoryAmount += double.parse(e.amount ?? '1').round();
        moneySign ??= e.account?.currency;
        categoryName ??= e.category?.name;
        emoji ??= e.category?.emoji;
        moneySign ??= e.account?.currency;
        sign ??= e.account?.currency;
        return TrancactionLocal.buildWith(
          e.id ?? 1,
          e.category?.emoji ?? '',
          e.category?.name ?? '',
          e.comment,
          int.parse(e.amount ?? '1'),
          e.account?.currency ?? '₽',
          DateTime.parse(e.transactionDate ?? ''),
        );
      }).toList();

      categoriesExpences.sort(
        (a, b) => b.transactionDate.compareTo(a.transactionDate),
      );

      final categoryItem = TransactionCategoryLocal.buildWith(
        entry.key ?? 1,
        emoji ?? '',
        categoryName ?? '',
        categoriesExpences.first.comment,
        ((categoryAmount / totalAmount) * 100),
        categoryAmount.toDouble(),
        moneySign ?? '',
        categoriesExpences,
      );

      return categoryItem;
    }).toList();

    final total = TotalAmountLocal.buildWith(totalAmount, sign);

    return AnalysisViewModel.buildWith(categoriesExpencesList, total);
  }
}
