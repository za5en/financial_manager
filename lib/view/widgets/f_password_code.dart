import 'package:financial_manager/data/local/secure_storage.dart';
import 'package:financial_manager/data/local/user_shared_preferences.dart';
import 'package:financial_manager/i18n/app_localizations.dart';
import 'package:financial_manager/view/resources/password/password_set.dart';
import 'package:financial_manager/view/widgets/f_alert_dialog.dart';
import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pinput/pinput.dart';

class FPasswordCode extends StatefulWidget {
  const FPasswordCode({super.key, required this.step});
  final int step;

  @override
  State<FPasswordCode> createState() => _FPasswordCodeState();
}

class _FPasswordCodeState extends State<FPasswordCode> {
  final TextEditingController _controller = TextEditingController();

  final SecureStorage secureStorage = SecureStorage(FlutterSecureStorage());

  int stepId = 0;
  String code = '';
  String oldCode = '';
  bool isChanged = false;

  void getOldCode() async {
    var tmp = await secureStorage.readCode() ?? '';
    if (mounted) {
      setState(() {
        oldCode = tmp;
      });
    }
  }

  @override
  void initState() {
    stepId = widget.step;
    getOldCode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    List<String> steps = [
      AppLocalizations.of(context)?.createCode ?? 'Создать код для входа',
      AppLocalizations.of(context)?.confirmCode ?? 'Подтвердите код',
      AppLocalizations.of(context)?.oldCode ?? 'Введите старый код',
      AppLocalizations.of(context)?.newCode ?? 'Введите новый код',
    ];
    List<String> confirmButton = [
      AppLocalizations.of(context)?.next ?? 'Далее',
      AppLocalizations.of(context)?.setupCode ?? 'Установить код',
      AppLocalizations.of(context)?.next ?? 'Далее',
      AppLocalizations.of(context)?.next ?? 'Далее',
    ];

    final defaultPinTheme = PinTheme(
      width: w * 0.113,
      height: h * 0.07,
      textStyle: TextStyle(
        fontSize: 25,
        color:
            Theme.of(context).primaryTextTheme.bodyMedium?.color ??
            Color(0xFF1C1C22),
        fontWeight: FontWeight.w900,
      ),
      margin: EdgeInsets.symmetric(horizontal: w * 0.01),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(235, 237, 237, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(42, 232, 129, 1)),
      borderRadius: BorderRadius.circular(20),
    );

    return Scaffold(
      appBar: FAppbar(
        title: AppLocalizations.of(context)?.passwordCode ?? 'Код пароль',
        leading: InkWell(
          onTap: () {
            if (isChanged) {
              showDialog<void>(
                context: context,
                builder: (BuildContext newContext) {
                  return FAlertDialog(
                    title: Text(
                      '${AppLocalizations.of(context)?.cancelChanges ?? 'Отменить изменения'}?',
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
                        child: const Text('OK'),
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
            child: Visibility(
              visible:
                  _controller.text.length == 4 &&
                  isNumeric(_controller.text) &&
                  (stepId == 0 ||
                      (stepId == 1 && _controller.text == code) ||
                      (stepId == 2 && _controller.text == oldCode) ||
                      stepId == 3),
              child: InkWell(
                onTap: () async {
                  if (_controller.text.length < 4 ||
                      (_controller.text.length == 4 &&
                          !isNumeric(_controller.text))) {
                    showSnackbar(
                      AppLocalizations.of(context)?.fourDigitCodeWarn ??
                          "Необходимо ввести 4-х значный числовой код",
                      Color.fromRGBO(228, 105, 98, 1),
                    );
                    _controller.clear();
                  } else {
                    setState(() {
                      isChanged = true;
                    });
                    switch (stepId) {
                      case 0:
                        setState(() {
                          stepId = 1;
                          code = _controller.text;
                          _controller.clear();
                        });
                      case 1:
                        if (_controller.text == code) {
                          secureStorage.writeCode(_controller.text);
                          if (context.mounted) {
                            UserSharedPreferences.settings.prefs.password =
                                true;
                            PasswordSet.password.value = true;
                            showSnackbar(
                              AppLocalizations.of(context)?.codeSaved ??
                                  "Код успешно сохранён",
                              Color.fromRGBO(42, 232, 129, 1),
                            );
                            Navigator.pop(context);
                          }
                        }
                      case 2:
                        if (_controller.text == oldCode) {
                          setState(() {
                            stepId = 3;
                            _controller.clear();
                          });
                        }
                      case 3:
                        setState(() {
                          stepId = 1;
                          code = _controller.text;
                          _controller.clear();
                        });
                    }
                  }
                },
                child: Icon(
                  Icons.check_outlined,
                  color: Color.fromRGBO(73, 69, 79, 1),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              steps[stepId],
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color:
                    Theme.of(context).primaryTextTheme.bodyMedium?.color ??
                    Color(0xFF1C1C22),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: h * 0.025, bottom: h * 0.01),
              child: Pinput(
                controller: _controller,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                onCompleted: (pin) async {
                  setState(() {
                    isChanged = true;
                  });
                  if (!isNumeric(_controller.text)) {
                    showSnackbar(
                      AppLocalizations.of(context)?.fourDigitCodeWarn ??
                          "Необходимо ввести 4-х значный числовой код",
                      Color.fromRGBO(228, 105, 98, 1),
                    );
                    _controller.clear();
                  } else {
                    switch (stepId) {
                      case 0:
                        FocusScope.of(context).unfocus();
                      case 1:
                        if (_controller.text == code) {
                          FocusScope.of(context).unfocus();
                        } else {
                          showSnackbar(
                            AppLocalizations.of(context)?.differentCodes ??
                                "Введённые коды не совпадают",
                            Color.fromRGBO(228, 105, 98, 1),
                          );
                        }
                      case 2:
                        if (_controller.text == oldCode) {
                          if (context.mounted) {
                            FocusScope.of(context).unfocus();
                          }
                        } else {
                          if (context.mounted) {
                            showSnackbar(
                              AppLocalizations.of(context)?.wrongCode ??
                                  "Введён неверный код",
                              Color.fromRGBO(228, 105, 98, 1),
                            );
                          }
                        }
                      case 3:
                        FocusScope.of(context).unfocus();
                    }
                  }
                },
              ),
            ),
            TextButton(
              onPressed:
                  _controller.text.length < 4 ||
                      ((stepId == 1 && _controller.text != code) ||
                          (stepId == 2 && _controller.text != oldCode)) ||
                      !isNumeric(_controller.text)
                  ? null
                  : () async {
                      switch (stepId) {
                        case 0:
                          setState(() {
                            stepId = 1;
                            code = _controller.text;
                            _controller.clear();
                          });
                        case 1:
                          if (_controller.text == code) {
                            secureStorage.writeCode(_controller.text);
                            if (context.mounted) {
                              UserSharedPreferences.settings.prefs.password =
                                  true;
                              PasswordSet.password.value = true;
                              showSnackbar(
                                AppLocalizations.of(context)?.codeSaved ??
                                    "Код успешно сохранён",
                                Color.fromRGBO(42, 232, 129, 1),
                              );
                              Navigator.pop(context);
                            }
                          }
                        case 2:
                          if (_controller.text ==
                              await secureStorage.readCode()) {
                            setState(() {
                              stepId = 3;
                              _controller.clear();
                            });
                          }
                        case 3:
                          setState(() {
                            stepId = 1;
                            code = _controller.text;
                            _controller.clear();
                          });
                      }
                    },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((state) {
                  if (state.contains(WidgetState.disabled)) {
                    return Colors.transparent;
                  }
                  return Theme.of(context).navigationBarTheme.backgroundColor;
                }),
              ),
              child: Text(
                confirmButton[stepId],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color:
                      _controller.text.length < 4 ||
                          ((stepId == 1 && _controller.text != code) ||
                              (stepId == 2 && _controller.text != oldCode)) ||
                          !isNumeric(_controller.text)
                      ? Color.fromRGBO(206, 206, 206, 1)
                      : Color.fromRGBO(42, 232, 129, 1),
                ),
              ),
            ),
            Visibility(
              visible: stepId == 2,
              child: Padding(
                padding: EdgeInsets.only(top: h * 0.001),
                child: TextButton(
                  onPressed: () {
                    resetCodeDialog();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((state) {
                      return Colors.transparent;
                    }),
                  ),
                  child: Text(
                    '${AppLocalizations.of(context)?.forgotCode ?? 'Забыли код'}?',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(42, 232, 129, 1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackbar(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void resetCodeDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return FAlertDialog(
          title: Text(
            '${AppLocalizations.of(context)?.warning ?? 'Внимание'}!',
          ),
          content: Text(
            AppLocalizations.of(context)?.resetCodeConfirm ??
                'Вы действительно хотите сбросить код пароль?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
              ),
              child: Text(AppLocalizations.of(context)?.cancel ?? 'Отмена'),
            ),
            TextButton(
              onPressed: () {
                secureStorage.deleteCode();
                UserSharedPreferences.settings.prefs.password = false;
                PasswordSet.password.value = false;
                Navigator.pop(context);
                setState(() {
                  stepId = 0;
                });
              },
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
              ),
              child: const Text('ОК'),
            ),
          ],
        );
      },
    );
  }

  bool isNumeric(String s) {
    return int.tryParse(s) != null;
  }
}
