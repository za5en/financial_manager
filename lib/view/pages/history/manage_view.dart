import 'package:financial_manager/data/models/account/account_model.dart';
import 'package:financial_manager/data/models/category/category_model.dart';
import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/i18n/app_localizations.dart';
import 'package:financial_manager/view/states/transactions/account_and_categories_cubit.dart';
import 'package:financial_manager/view/states/transactions/manage_transaction_cubit.dart';
import 'package:financial_manager/view/widgets/f_alert_dialog.dart';
import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_error.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:financial_manager/view/widgets/f_loading.dart';
import 'package:financial_manager/view/widgets/f_red_button.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ManageDialog extends StatelessWidget {
  const ManageDialog({
    super.key,
    required this.isIncome,
    required this.isEditMode,
    this.transaction,
  });
  final bool isIncome;
  final bool isEditMode;
  final TransactionResponseModel? transaction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountAndCategoriesCubit(),
      child: ManageView(
        key: key,
        isIncome: isIncome,
        isEditMode: isEditMode,
        transaction: transaction,
      ),
    );
  }
}

class ManageView extends StatefulWidget {
  const ManageView({
    super.key,
    required this.isIncome,
    required this.isEditMode,
    this.transaction,
  });
  final bool isIncome;
  final bool isEditMode;
  final TransactionResponseModel? transaction;

  @override
  State<ManageView> createState() => _ManageViewState();
}

class _ManageViewState extends State<ManageView> {
  final TextEditingController sumController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  // TransactionResponseModel? transactionInfo;
  List<AccountModel> accounts = [];
  List<CategoryModel> articles = [];

  DateTime transactionDate = DateTime.now();
  TimeOfDay transactionTime = TimeOfDay.now();
  String amount = '25 270';
  String currency = '₽';
  bool isChanged = false;

  String? selectedAccount;

  void changeAccount(String? account) {
    setState(() {
      selectedAccount = account ?? 'Сбербанк';
      isChanged = true;
    });
  }

  String? selectedArticle;

  void changeArticle(String? article) {
    setState(() {
      selectedArticle = article ?? 'Ремонт';
      isChanged = true;
    });
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      locale: Localizations.localeOf(context),
      initialDate: transactionDate,
      firstDate: DateTime(
        DateTime.now().year - 5,
        DateTime.now().month,
        DateTime.now().day,
      ),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        transactionDate = pickedDate;
        isChanged = true;
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: transactionTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Localizations.override(
            context: context,
            locale: Localizations.localeOf(context),
            child: child!,
          ),
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        transactionTime = pickedTime;
        isChanged = true;
      });
    }
  }

  void getTransactionInfo() async {
    setState(() {
      selectedAccount = widget.transaction?.account?.name ?? 'Account';
      if (!accounts
          .map((item) => item.name)
          .contains(widget.transaction?.account?.name)) {
        accounts.add(
          AccountModel(
            id: widget.transaction?.account?.id ?? 1,
            userId: 1,
            name: widget.transaction?.account?.name ?? 'Account',
            balance: widget.transaction?.account?.balance ?? '1000',
            currency: currency,
            createdAt: DateTime.now().toString(),
            updatedAt: DateTime.now().toString(),
          ),
        );
      }
      selectedArticle = widget.transaction?.category?.name ?? '';
      sumController.text = widget.transaction?.amount ?? '25270';
      currency = widget.transaction?.account?.currency ?? '₽';
      transactionDate = DateTime.parse(
        widget.transaction?.transactionDate ?? '2025-05-07 12:35',
      );
      transactionTime = TimeOfDay.fromDateTime(transactionDate);
      descController.text = widget.transaction?.comment ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AccountAndCategoriesCubit>().getInfo(
      widget.isEditMode,
      widget.transaction?.account,
    );
    if (widget.isEditMode) {
      getTransactionInfo();
    } else {
      sumController.text = '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    sumController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Dialog.fullscreen(
      child: BlocBuilder<AccountAndCategoriesCubit, AccountAndCategoriesState>(
        builder: (context, state) => switch (state) {
          Loading() => FLoading(),
          CustomError() => FError(message: 'Error'),
          Content() => Scaffold(
            appBar: FAppbar(
              title: widget.isIncome
                  ? AppLocalizations.of(context)?.myIncomes ?? 'Мои доходы'
                  : AppLocalizations.of(context)?.myExpenses ?? 'Мои расходы',
              leading: InkWell(
                onTap: () {
                  if (isChanged) {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext newContext) {
                        return FAlertDialog(
                          title: Text(
                            '${widget.isEditMode ? AppLocalizations.of(context)?.cancelEdit ?? 'Отменить редактирование' : AppLocalizations.of(context)?.cancelCreate ?? 'Отменить создание'}?',
                          ),
                          content: Text(
                            AppLocalizations.of(context)?.cancelEditDesc ??
                                'Вы действительно хотите отменить изменения?',
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(newContext),
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all<Color>(
                                  Colors.black,
                                ),
                              ),
                              child: Text(
                                AppLocalizations.of(context)?.cancel ??
                                    'Отмена',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(newContext).pop();
                              },
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all<Color>(
                                  Colors.black,
                                ),
                              ),
                              child: const Text('ОК'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Icon(
                  Icons.close_outlined,
                  color: Color.fromRGBO(73, 69, 79, 1),
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () {
                      if (sumController.text.isEmpty ||
                          selectedAccount == null ||
                          selectedArticle == null) {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return FAlertDialog(
                              title: Text(
                                widget.isEditMode
                                    ? AppLocalizations.of(context)?.editError ??
                                          'Ошибка сохранения'
                                    : AppLocalizations.of(
                                            context,
                                          )?.createError ??
                                          'Ошибка создания',
                              ),
                              content: Text(
                                AppLocalizations.of(context)?.createErrorDesc ??
                                    'Необходимо заполнить все обязательные поля (все кроме комментария)',
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        WidgetStateProperty.all<Color>(
                                          Colors.black,
                                        ),
                                  ),
                                  child: const Text('ОК'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        if (widget.isEditMode) {
                          context
                              .read<AccountAndCategoriesCubit>()
                              .updateTransaction(
                                widget.transaction?.id ?? 1,
                                state.content!.account
                                    .firstWhere(
                                      (e) => e.name == (selectedAccount ?? ''),
                                    )
                                    .id,
                                state.content!.categories
                                    .firstWhere(
                                      (e) => e.name == (selectedArticle ?? ''),
                                    )
                                    .id,
                                double.parse(sumController.text),
                                DateTime(
                                  transactionDate.year,
                                  transactionDate.month,
                                  transactionDate.day,
                                  transactionTime.hour,
                                  transactionTime.minute,
                                ),
                                descController.text,
                              );
                        } else {
                          context
                              .read<AccountAndCategoriesCubit>()
                              .createTransaction(
                                state.content!.account
                                    .firstWhere(
                                      (e) => e.name == (selectedAccount ?? ''),
                                    )
                                    .id,
                                state.content!.categories
                                    .firstWhere(
                                      (e) => e.name == (selectedArticle ?? ''),
                                    )
                                    .id,
                                double.parse(sumController.text),
                                DateTime(
                                  transactionDate.year,
                                  transactionDate.month,
                                  transactionDate.day,
                                  transactionTime.hour,
                                  transactionTime.minute,
                                ),
                                descController.text,
                              );
                        }
                        Navigator.pop(context, true);
                      }
                    },
                    child: Icon(
                      Icons.check_outlined,
                      color: Color.fromRGBO(73, 69, 79, 1),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: w, minHeight: h),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // счёт
                      FListLine(
                        height: h * 0.077,
                        leftPadding: w * 0.02,
                        rightPadding: w * 0.02,
                        name:
                            AppLocalizations.of(context)?.accountName ?? 'Счет',
                        rightSide: DropdownButton<String>(
                          items: List.generate(
                            state.content!.account.length,
                            (index) => DropdownMenuItem(
                              value: state.content!.account[index].name,
                              child: Text(state.content!.account[index].name),
                            ),
                          ),
                          value: selectedAccount,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            letterSpacing: 0.2,
                          ),
                          alignment: Alignment.centerRight,
                          onChanged: changeAccount,
                          underline: Container(height: 0),
                          borderRadius: BorderRadius.circular(15),
                          icon: Padding(
                            padding: EdgeInsets.only(left: w * 0.035),
                            child: FSvg(assetName: 'assets/images/more.svg'),
                          ),
                        ),
                        backgroundColor: Color.fromRGBO(254, 247, 255, 1),
                        isEmojiInContainer: true,
                      ),
                      // статья
                      FListLine(
                        height: h * 0.077,
                        leftPadding: w * 0.02,
                        rightPadding: w * 0.02,
                        name:
                            AppLocalizations.of(context)?.articleName ??
                            'Статья',
                        rightSide: DropdownButton<String>(
                          items: List.generate(
                            state.content!.categories.length,
                            (index) => DropdownMenuItem(
                              value: state.content!.categories[index].name,
                              child: Text(
                                state.content!.categories[index].name,
                              ),
                            ),
                          ),
                          value: selectedArticle,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            letterSpacing: 0.2,
                          ),
                          alignment: Alignment.centerRight,
                          onChanged: changeArticle,
                          underline: Container(height: 0),
                          borderRadius: BorderRadius.circular(15),
                          icon: Padding(
                            padding: EdgeInsets.only(left: w * 0.035),
                            child: FSvg(assetName: 'assets/images/more.svg'),
                          ),
                        ),
                        backgroundColor: Color.fromRGBO(254, 247, 255, 1),
                        isEmojiInContainer: true,
                      ),
                      // сумма
                      FListLine(
                        height: h * 0.077,
                        leftPadding: w * 0.02,
                        rightPadding: w * 0.04,
                        name:
                            AppLocalizations.of(context)?.historySum ?? 'Сумма',
                        rightSide: SizedBox(
                          width: w * 0.3,
                          child: TextField(
                            controller: sumController,
                            onChanged: (value) {
                              setState(() {
                                isChanged = true;
                              });
                            },
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 14),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}'),
                              ),
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              suffix: Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  alignment: Alignment.centerRight,
                                  child: Text(currency),
                                ),
                              ),
                              hintText:
                                  AppLocalizations.of(context)?.historySum ??
                                  'Сумма',
                            ),
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                          ),
                        ),
                        backgroundColor: Color.fromRGBO(254, 247, 255, 1),
                        isEmojiInContainer: true,
                      ),
                      // дата
                      FListLine(
                        height: h * 0.077,
                        leftPadding: w * 0.02,
                        rightPadding: w * 0.04,
                        name: AppLocalizations.of(context)?.date ?? 'Дата',
                        rightSide: InkWell(
                          onTap: () {
                            _selectDate();
                          },
                          child: Text(
                            DateFormat('dd.MM.yyyy').format(transactionDate),
                          ),
                        ),
                        backgroundColor: Color.fromRGBO(254, 247, 255, 1),
                        isEmojiInContainer: true,
                      ),
                      // время
                      FListLine(
                        height: h * 0.077,
                        leftPadding: w * 0.02,
                        rightPadding: w * 0.04,
                        name: AppLocalizations.of(context)?.time ?? 'Время',
                        rightSide: InkWell(
                          onTap: () {
                            _selectTime();
                          },
                          child: Text(
                            '${transactionTime.hour.toString()}:${transactionTime.minute < 10 ? '0${transactionTime.minute}' : transactionTime.minute.toString()}',
                          ),
                        ),
                        backgroundColor: Color.fromRGBO(254, 247, 255, 1),
                        isEmojiInContainer: true,
                      ),
                      // комментарий
                      FListLine(
                        height: h * 0.077,
                        width: w * 0.9,
                        leftPadding: w * 0.02,
                        rightPadding: w * 0.04,
                        editName: true,
                        controller: descController,
                        hint: !widget.isEditMode
                            ? AppLocalizations.of(context)?.comment ??
                                  'Комментарий'
                            : null,
                        onNameChanged: (value) {
                          setState(() {
                            isChanged = true;
                          });
                        },
                        autofocus: false,
                        name:
                            AppLocalizations.of(context)?.comment ??
                            'Комментарий',
                        rightSide: SizedBox(),
                        backgroundColor: Color.fromRGBO(254, 247, 255, 1),
                        isEmojiInContainer: true,
                      ),
                      Visibility(
                        visible: widget.isEditMode,
                        child: FRedButton(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext newContext) {
                                return FAlertDialog(
                                  title: Text(
                                    '${widget.isIncome ? AppLocalizations.of(context)?.deleteIncome ?? 'Удалить доход' : AppLocalizations.of(context)?.deleteExpense ?? 'Удалить расход'}?',
                                  ),
                                  content: Text(
                                    '${widget.isIncome ? AppLocalizations.of(context)?.deleteIncomeDesc ?? 'Вы действительно хотите удалить доход' : AppLocalizations.of(context)?.deleteExpenseDesc ?? 'Вы действительно хотите удалить расход'}?',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(newContext),
                                      style: ButtonStyle(
                                        foregroundColor:
                                            WidgetStateProperty.all<Color>(
                                              Colors.black,
                                            ),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)?.cancel ??
                                            'Отмена',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(newContext).pop();
                                      },
                                      style: ButtonStyle(
                                        foregroundColor:
                                            WidgetStateProperty.all<Color>(
                                              Colors.black,
                                            ),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)?.delete ??
                                            'Удалить',
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          width: w * 0.92,
                          height: h * 0.044,
                          topPadding: h * 0.036,
                          name: widget.isIncome
                              ? AppLocalizations.of(context)?.deleteIncome ??
                                    'Удалить доход'
                              : AppLocalizations.of(context)?.deleteExpense ??
                                    'Удалить расход',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _ => FLoading(),
        },
      ),
    );
  }
}

class ConfirmButtonWrapper extends StatelessWidget {
  const ConfirmButtonWrapper({
    super.key,
    required this.isTextEmpty,
    required this.isSelectedArticleEmpty,
    required this.isSelectedAccountEmpty,
    required this.isEditMode,
    this.id,
    required this.accountId,
    required this.categoryId,
    required this.amount,
    required this.transactionDate,
    this.comment,
  });
  final bool isTextEmpty;
  final bool isSelectedArticleEmpty;
  final bool isSelectedAccountEmpty;
  final bool isEditMode;
  final int? id;
  final int accountId;
  final int categoryId;
  final double amount;
  final DateTime transactionDate;
  final String? comment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageTransactionCubit(),
      child: ConfirmButton(
        key: key,
        isTextEmpty: isTextEmpty,
        isSelectedArticleEmpty: isSelectedArticleEmpty,
        isSelectedAccountEmpty: isSelectedAccountEmpty,
        isEditMode: isEditMode,
        id: id,
        accountId: accountId,
        categoryId: categoryId,
        amount: amount,
        transactionDate: transactionDate,
        comment: comment,
      ),
    );
  }
}

class ConfirmButton extends StatefulWidget {
  const ConfirmButton({
    super.key,
    required this.isTextEmpty,
    required this.isSelectedArticleEmpty,
    required this.isSelectedAccountEmpty,
    required this.isEditMode,
    this.id,
    required this.accountId,
    required this.categoryId,
    required this.amount,
    required this.transactionDate,
    this.comment,
  });
  final bool isTextEmpty;
  final bool isSelectedArticleEmpty;
  final bool isSelectedAccountEmpty;
  final bool isEditMode;
  final int? id;
  final int accountId;
  final int categoryId;
  final double amount;
  final DateTime transactionDate;
  final String? comment;

  @override
  State<ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageTransactionCubit, ManageTransactionState>(
      builder: (context, state) => switch (state) {
        Loading() => FLoading(),
        CustomError() => FError(message: 'Error'),
        Content() => Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: InkWell(
            onTap: () {
              if (widget.isTextEmpty ||
                  widget.isSelectedAccountEmpty ||
                  widget.isSelectedArticleEmpty) {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return FAlertDialog(
                      title: Text(
                        widget.isEditMode
                            ? AppLocalizations.of(context)?.editError ??
                                  'Ошибка сохранения'
                            : AppLocalizations.of(context)?.createError ??
                                  'Ошибка создания',
                      ),
                      content: Text(
                        AppLocalizations.of(context)?.createErrorDesc ??
                            'Необходимо заполнить все обязательные поля (все кроме комментария)',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.all<Color>(
                              Colors.black,
                            ),
                          ),
                          child: const Text('ОК'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                if (widget.isEditMode) {
                  context.read<ManageTransactionCubit>().updateTransaction(
                    widget.id ?? 1,
                    widget.accountId,
                    widget.categoryId,
                    widget.amount,
                    widget.transactionDate,
                    widget.comment,
                  );
                } else {
                  context.read<ManageTransactionCubit>().createTransaction(
                    widget.accountId,
                    widget.categoryId,
                    widget.amount,
                    widget.transactionDate,
                    widget.comment,
                  );
                }
                Navigator.pop(context);
              }
            },
            child: Icon(
              Icons.check_outlined,
              color: Color.fromRGBO(73, 69, 79, 1),
            ),
          ),
        ),
        _ => FLoading(),
      },
    );
  }
}
