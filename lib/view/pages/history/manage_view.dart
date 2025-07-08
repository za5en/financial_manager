import 'package:financial_manager/data/models/account/account_model.dart';
import 'package:financial_manager/data/models/category/category_model.dart';
import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:financial_manager/i18n/app_localizations.dart';
import 'package:financial_manager/view/link/account_info.dart';
import 'package:financial_manager/view/link/account_transactions.dart';
import 'package:financial_manager/view/link/categories.dart';
import 'package:financial_manager/view/widgets/f_alert_dialog.dart';
import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:financial_manager/view/widgets/f_red_button.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ManageView extends StatefulWidget {
  const ManageView({
    super.key,
    required this.isIncome,
    required this.isEditMode,
    this.transactionId,
  });
  final bool isIncome;
  final bool isEditMode;
  final int? transactionId;

  @override
  State<ManageView> createState() => _ManageViewState();
}

class _ManageViewState extends State<ManageView> {
  final TextEditingController sumController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  TransactionResponseModel? transactionInfo;
  List<AccountModel> accounts = [];
  List<CategoryModel> articles = [];

  DateTime transactionDate = DateTime.now();
  TimeOfDay transactionTime = TimeOfDay.now();
  String amount = '25 270';
  String currency = '₽';
  bool isChanged = false;

  String selectedAccount = 'Без названия';

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
      locale: const Locale('ru', 'RU'),
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
            locale: const Locale('ru', 'RU'),
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

  void getAccounts() async {
    final accountInfo = AccountInfo();

    final response = await accountInfo.getAccount();

    setState(() {
      accounts = response;
      if (!widget.isEditMode) {
        selectedAccount = accounts[0].name == ''
            ? AppLocalizations.of(context)?.accountNoName ?? 'Без названия'
            : accounts[0].name;
      }
    });
  }

  void getCategories() async {
    final categories = Categories();

    final response = await categories.getCategories();

    setState(() {
      articles = response;
      selectedArticle = articles.first.name;
    });
  }

  void getTransactionInfo() async {
    final accountTransactions = AccountTransactions();

    final response = await accountTransactions.getTransaction(
      widget.transactionId,
    );

    setState(() {
      transactionInfo = response;
      selectedAccount = transactionInfo?.account.name == ''
          ? AppLocalizations.of(context)?.accountNoName ?? 'Без названия'
          : transactionInfo?.account.name ?? 'Account';
      if (!accounts
          .map((item) => item.name)
          .contains(transactionInfo?.account.name)) {
        accounts.add(
          AccountModel(
            id: transactionInfo?.account.id ?? 1,
            userId: 1,
            name:
                transactionInfo?.account.name ??
                AppLocalizations.of(context)?.accountNoName ??
                'Без названия',
            balance: transactionInfo?.account.balance ?? '1000',
            currency: currency,
            createdAt: DateTime.now().toString(),
            updatedAt: DateTime.now().toString(),
          ),
        );
      }
      selectedArticle = transactionInfo?.category.name;
      sumController.text = transactionInfo?.amount ?? '25270';
      currency = transactionInfo?.account.currency ?? '₽';
      transactionDate = DateTime.parse(
        transactionInfo?.transactionDate ?? '2025-05-07 12:35',
      );
      transactionTime = TimeOfDay.fromDateTime(transactionDate);
      descController.text = transactionInfo?.comment ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getAccounts();
    getCategories();
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

    List<String> settings = [
      AppLocalizations.of(context)?.accountName ?? 'Счет',
      AppLocalizations.of(context)?.articleName ?? 'Статья',
      AppLocalizations.of(context)?.historySum ?? 'Сумма',
      AppLocalizations.of(context)?.date ?? 'Дата',
      AppLocalizations.of(context)?.time ?? 'Время',
      AppLocalizations.of(context)?.comment ?? 'Комментарий',
    ];

    List<Widget> rightSides = [
      DropdownButton<String>(
        items: accounts.map<DropdownMenuItem<String>>((AccountModel val) {
          return DropdownMenuItem<String>(
            value: val.name == ''
                ? AppLocalizations.of(context)?.accountNoName ?? 'Без названия'
                : val.name,
            child: Text(
              val.name == ''
                  ? AppLocalizations.of(context)?.accountNoName ??
                        'Без названия'
                  : val.name,
            ),
          );
        }).toList(),
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
      DropdownButton<String>(
        items: articles.map<DropdownMenuItem<String>>((CategoryModel val) {
          return DropdownMenuItem<String>(
            value: val.name,
            child: Text(val.name),
          );
        }).toList(),
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
      SizedBox(
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
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0.0),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            suffix: Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                alignment: Alignment.centerRight,
                child: Text(currency),
              ),
            ),
            hintText: AppLocalizations.of(context)?.historySum ?? 'Сумма',
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
      ),
      InkWell(
        onTap: () {
          _selectDate();
        },
        child: Text(DateFormat('dd.MM.yyyy').format(transactionDate)),
      ),
      InkWell(
        onTap: () {
          _selectTime();
        },
        child: Text(
          '${transactionTime.hour.toString()}:${transactionTime.minute < 10 ? '0${transactionTime.minute}' : transactionTime.minute.toString()}',
        ),
      ),
      SizedBox(),
    ];

    return Dialog.fullscreen(
      child: Scaffold(
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
                            AppLocalizations.of(context)?.cancel ?? 'Отмена',
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
                  if (sumController.text.isEmpty || selectedArticle == null) {
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
                    Navigator.pop(context);
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
                  SizedBox(
                    height: h * 0.47,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: settings.length,
                      itemBuilder: (builder, index) {
                        return FListLine(
                          height: h * 0.077,
                          leftPadding: w * 0.02,
                          rightPadding: index < 2 ? w * 0.02 : w * 0.04,
                          editName: index == settings.length - 1,
                          controller: index == settings.length - 1
                              ? descController
                              : null,
                          hint:
                              index == settings.length - 1 && !widget.isEditMode
                              ? AppLocalizations.of(context)?.comment ??
                                    'Комментарий'
                              : null,
                          onNameChanged: (value) {
                            setState(() {
                              isChanged = true;
                            });
                          },
                          autofocus: index == settings.length - 1
                              ? false
                              : null,
                          width: index == settings.length - 1 ? w * 0.9 : null,
                          name: settings[index],
                          rightSide: rightSides[index],
                          backgroundColor: Color.fromRGBO(254, 247, 255, 1),
                          isEmojiInContainer: true,
                        );
                      },
                    ),
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
                                  onPressed: () => Navigator.pop(newContext),
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
    );
  }
}
