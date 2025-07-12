import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/view/states/finances/finances_local.dart';

class FinancesViewModel {
  final List<TransactionLocal> items;
  final TotalAmountItem total;

  FinancesViewModel._({required this.items, required this.total});

  factory FinancesViewModel.buildWith(
    List<TransactionLocal> items,
    TotalAmountItem total,
  ) => FinancesViewModel._(items: items, total: total);

  factory FinancesViewModel.fromTransactionDetails(
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

    final total = TotalAmountItem.buildWith(amount, sign);

    return FinancesViewModel.buildWith(expences, total);
  }
}
