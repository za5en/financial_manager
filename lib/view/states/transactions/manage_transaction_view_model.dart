import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/view/states/transactions/manage_transaction_local.dart';

class ManageTransactionViewModel {
  final List<ManageTransactionLocal> items;
  final TotalAmount total;

  ManageTransactionViewModel._({required this.items, required this.total});

  factory ManageTransactionViewModel.buildWith(
    List<ManageTransactionLocal> items,
    TotalAmount total,
  ) => ManageTransactionViewModel._(items: items, total: total);

  factory ManageTransactionViewModel.fromTransactionDetails(
    List<TransactionResponseModel> transactionDetails,
  ) {
    int amount = 0;
    String? sign;
    final expences = transactionDetails.map((e) {
      amount += double.parse(e.amount ?? '1').round();
      sign ??= e.account?.currency;
      return ManageTransactionLocal.buildWith(
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

    final total = TotalAmount.buildWith(amount, sign);

    return ManageTransactionViewModel.buildWith(expences, total);
  }
}
