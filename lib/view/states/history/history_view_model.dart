import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/view/states/history/history_local.dart';

class HistoryViewModel {
  final List<TransactionLocal> items;
  final TotalAmountLocal total;

  HistoryViewModel._({required this.items, required this.total});

  factory HistoryViewModel.buildWith(
    List<TransactionLocal> items,
    TotalAmountLocal total,
  ) => HistoryViewModel._(items: items, total: total);

  factory HistoryViewModel.fromTransactionDetails(
    List<TransactionResponseModel> transactionDetails,
  ) {
    int amount = 0;
    String? sign;
    final expences = transactionDetails.map((e) {
      amount += double.parse(e.amount ?? '1').round();
      sign ??= e.account?.currency;
      return TransactionLocal.buildWith(
        e.id ?? 1,
        e.category?.emoji ?? '',
        e.category?.id ?? 1,
        e.account?.id ?? 1,
        e.account?.name ?? '',
        e.category?.name ?? '',
        DateTime.parse(e.transactionDate ?? ''),
        e.comment,
        double.parse(e.amount ?? '1'),
        e.account?.currency ?? '₽',
      );
    }).toList();

    final total = TotalAmountLocal.buildWith(amount, sign);

    return HistoryViewModel.buildWith(expences, total);
  }

  factory HistoryViewModel.sort(args) {
    final totalAmount = args['total'] as TotalAmountLocal;
    final sortItems = args['items'] as List<TransactionLocal>;
    final type = args['type'] as int;
    switch (type) {
      case 0:
        sortItems.sort(
          (a, b) => b.transactionDate.compareTo(a.transactionDate),
        );
      case 1:
        sortItems.sort(
          (a, b) => a.transactionDate.compareTo(b.transactionDate),
        );
      case 2:
        sortItems.sort((a, b) => b.amount.compareTo(a.amount));
      case 3:
        sortItems.sort((a, b) => a.amount.compareTo(b.amount));
      default:
        break;
    }

    return HistoryViewModel.buildWith(sortItems, totalAmount);
  }
}
