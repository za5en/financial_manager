import 'package:financial_manager/data/local/local_auth_service.dart';
import 'package:financial_manager/data/local/secure_storage.dart';
import 'package:financial_manager/data/local/user_shared_preferences.dart';
import 'package:financial_manager/i18n/app_localizations.dart';
import 'package:financial_manager/view/resources/password/password_set.dart';
import 'package:financial_manager/view/widgets/f_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final TextEditingController _controller = TextEditingController();

  final SecureStorage secureStorage = SecureStorage(FlutterSecureStorage());

  String code = '';

  void getCode() async {
    var tmp = await secureStorage.readCode() ?? '';
    if (mounted) {
      setState(() {
        code = tmp;
      });
    }
  }

  @override
  void initState() {
    getCode();
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)?.codeToEnter ??
                  'Введите код для входа\nв приложение',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color:
                    Theme.of(context).primaryTextTheme.bodyMedium?.color ??
                    Color(0xFF1C1C22),
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: h * 0.025, bottom: h * 0.01),
              child: Pinput(
                controller: _controller,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                onCompleted: (pin) async {
                  if (_controller.text == code) {
                    FocusScope.of(context).unfocus();
                    context.replace("/expense");
                  } else {
                    _controller.clear();
                    showSnackbar(
                      AppLocalizations.of(context)?.wrongCodeTryAgain ??
                          "Введён неверный код, попробуйте ещё раз",
                      Color.fromRGBO(228, 105, 98, 1),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: h * 0.001),
              child: TextButton(
                onPressed: () async {
                  var isReset = await resetCodeDialog();
                  if (isReset) {
                    if (context.mounted) {
                      FocusScope.of(context).unfocus();
                      UserSharedPreferences.settings.prefs.password = false;
                      PasswordSet.password.value = false;
                      context.replace("/expense");
                    }
                  }
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
            Visibility(
              visible: UserSharedPreferences.settings.prefs.biometrics == true,
              child: TextButton(
                onPressed: () async {
                  var isAuthenticated = await LocalAuthService.authenticate();
                  if (isAuthenticated) {
                    if (context.mounted) {
                      FocusScope.of(context).unfocus();
                      context.replace("/expense");
                    }
                  } else {
                    if (context.mounted) {
                      errorDialog();
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((state) {
                    return Colors.transparent;
                  }),
                ),
                child: Text(
                  AppLocalizations.of(context)?.biometrics ??
                      'Вход по биометрии',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(42, 232, 129, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void errorDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext newContext) {
        return FAlertDialog(
          title: Text(
            AppLocalizations.of(context)?.biometricsError ??
                'Ошибка использования биометрии',
          ),
          content: Text(
            AppLocalizations.of(context)?.biometricsErrorDesc ??
                'Убедитесь, что в настройках устройства установлен отпечаток пальца или распознавание лица',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(newContext).pop();
              },
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> resetCodeDialog() async {
    bool reset = false;
    await showDialog<void>(
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
                reset = true;
                Navigator.pop(context);
              },
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return reset;
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
}
