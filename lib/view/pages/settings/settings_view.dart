import 'package:financial_manager/data/local/local_auth_service.dart';
import 'package:financial_manager/data/local/secure_storage.dart';
import 'package:financial_manager/data/local/user_shared_preferences.dart';
import 'package:financial_manager/i18n/app_localizations.dart';
import 'package:financial_manager/view/resources/locale/locale_provider.dart';
import 'package:financial_manager/view/resources/password/password_set.dart';
import 'package:financial_manager/view/resources/theme/color_themes.dart';
import 'package:financial_manager/view/resources/theme/main_color.dart';
import 'package:financial_manager/view/states/settings/settings_cubit.dart';
import 'package:financial_manager/view/widgets/f_alert_dialog.dart';
import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_error.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:financial_manager/view/widgets/f_loading.dart';
import 'package:financial_manager/view/widgets/f_password_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  Color pickerColor = Color(
    UserSharedPreferences.settings.prefs.tint ?? 0xFF2AE881,
  );
  Color currentColor = Color(
    UserSharedPreferences.settings.prefs.tint ?? 0xFF2AE881,
  );

  final SecureStorage secureStorage = SecureStorage(FlutterSecureStorage());

  @override
  void initState() {
    super.initState();
    context.read<SettingsCubit>().getBiometricsInfo();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    List<String> settings = [
      AppLocalizations.of(context)?.darkTheme ?? 'Системная тема',
      AppLocalizations.of(context)?.mainColor ?? 'Основной цвет',
      AppLocalizations.of(context)?.sounds ?? 'Звуки',
      AppLocalizations.of(context)?.haptics ?? 'Хаптики',
      AppLocalizations.of(context)?.passwordCode ?? 'Код пароль',
      AppLocalizations.of(context)?.biometrics ?? 'Вход по биометрии',
      AppLocalizations.of(context)?.syncronization ?? 'Синхронизация',
      AppLocalizations.of(context)?.language ?? 'Язык',
      AppLocalizations.of(context)?.about ?? 'О программе',
    ];
    return Scaffold(
      appBar: FAppbar(
        title: AppLocalizations.of(context)?.settings ?? 'Настройки',
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) => switch (state) {
          Loading() => FLoading(),
          CustomError() => FError(message: 'Error'),
          Content() => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: settings.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (builder, index) {
                    return InkWell(
                      onTap: (index != 0 && index != 3 && index != 5)
                          ? () async {
                              if (index == 1) {
                                colorPickDialog();
                              } else if (index == 4) {
                                var code = await secureStorage.readCode();
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FPasswordCode(
                                        step: code == null ? 0 : 2,
                                      ),
                                    ),
                                  );
                                }
                              } else if (index == 7) {
                                localeModalePick(context);
                              }
                            }
                          : null,
                      child: FListLine(
                        height: h * 0.06,
                        leftPadding: w * 0.02,
                        rightPadding: w * 0.02,
                        name: settings[index],
                        rightSide: (index == 0 || index == 3)
                            ? SettingsToggle(
                                name: index == 0 ? 'theme' : 'haptic',
                              )
                            : index == 5
                            ? ValueListenableBuilder(
                                valueListenable: MainColor.color,
                                builder: (cContext, cValue, cChild) =>
                                    ValueListenableBuilder(
                                      valueListenable: PasswordSet.password,
                                      builder: (pContext, pValue, pChild) =>
                                          Switch(
                                            value:
                                                UserSharedPreferences
                                                    .settings
                                                    .prefs
                                                    .biometrics ??
                                                false,
                                            activeColor: Color(cValue),
                                            onChanged:
                                                state.content.canAuthenticate ==
                                                        true &&
                                                    pValue == true
                                                ? (bool val) {
                                                    setState(() {
                                                      UserSharedPreferences
                                                              .settings
                                                              .prefs
                                                              .biometrics =
                                                          val;
                                                    });
                                                  }
                                                : null,
                                          ),
                                    ),
                              )
                            : Icon(
                                Icons.arrow_right,
                                color: Color.fromRGBO(73, 69, 79, 1),
                              ),
                        backgroundColor: Theme.of(
                          context,
                        ).scaffoldBackgroundColor,
                        isEmojiInContainer: true,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          _ => FLoading(),
        },
      ),
    );
  }

  void changeColor(Color color) {
    if (mounted) {
      setState(() => pickerColor = color);
    }
  }

  void colorPickDialog() {
    showDialog(
      context: context,
      builder: (BuildContext newContext) {
        return FAlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(newContext).pop();
                },
                child: Icon(Icons.close),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Сбросить'),
              onPressed: () {
                setState(() {
                  pickerColor = Color(0xFF2AE881);
                  currentColor = Color(0xFF2AE881);
                  MainColor.color.value = 0xFF2AE881;
                  UserSharedPreferences.settings.prefs.tint = 0xFF2AE881;
                });
                Navigator.of(newContext).pop();
              },
            ),
            ElevatedButton(
              child: Text(AppLocalizations.of(context)?.select ?? 'Выбрать'),
              onPressed: () {
                setState(() {
                  currentColor = pickerColor;
                  MainColor.color.value = pickerColor.toARGB32();
                  UserSharedPreferences.settings.prefs.tint = pickerColor
                      .toARGB32();
                });
                Navigator.of(newContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void localeModalePick(context) {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      showDragHandle: true,
      useRootNavigator: true,
      builder: (BuildContext modalContext) {
        List locales = [
          ['Русский', 'ru'],
          ['English', 'en'],
          [AppLocalizations.of(context)?.cancel ?? 'Отмена'],
        ];
        return SizedBox(
          height: locales.length * MediaQuery.of(context).size.height * 0.08,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: locales.length,
                    itemBuilder: (builder, index) {
                      return InkWell(
                        onTap: () {
                          if (locales[index][0] ==
                              (AppLocalizations.of(modalContext)?.cancel ??
                                  'Отмена')) {
                            Navigator.pop(modalContext);
                          } else {
                            setState(() {
                              UserSharedPreferences.settings.prefs.locale =
                                  locales[index][1];
                              BlocProvider.of<LocaleProvider>(
                                context,
                              ).toggleLocale();
                            });
                            Navigator.pop(modalContext);
                          }
                        },
                        child: FListLine(
                          height: MediaQuery.of(context).size.height * 0.077,
                          leftPadding: MediaQuery.of(context).size.width * 0.04,
                          rightPadding:
                              MediaQuery.of(context).size.width * 0.03,
                          name: locales[index][0],
                          isEmojiInContainer: false,
                          nameColor:
                              locales[index][0] ==
                                  (AppLocalizations.of(modalContext)?.cancel ??
                                      'Отмена')
                              ? Colors.white
                              : null,
                          rightSide: SizedBox(),
                          backgroundColor:
                              locales[index][0] !=
                                  (AppLocalizations.of(modalContext)?.cancel ??
                                      'Отмена')
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Color.fromRGBO(228, 105, 98, 1),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SettingsToggle extends StatefulWidget {
  const SettingsToggle({super.key, required this.name});
  final String name;

  @override
  State<SettingsToggle> createState() => _SettingsToggleState();
}

class _SettingsToggleState extends State<SettingsToggle> {
  bool canAuthenticateWithBiometrics = false;

  void checkBiometrics() async {
    canAuthenticateWithBiometrics = await LocalAuthService.canAuthenticate();
  }

  @override
  void initState() {
    checkBiometrics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MainColor.color,
      builder: (context, value, child) => Switch(
        value: widget.name == 'theme'
            ? UserSharedPreferences.settings.prefs.theme ?? false
            : UserSharedPreferences.settings.prefs.haptic ?? false,
        activeColor: Color(value),
        onChanged: (bool val) {
          setState(() {
            if (widget.name == 'theme') {
              UserSharedPreferences.settings.prefs.theme = val;
              BlocProvider.of<ThemeProvider>(context).toggleTheme();
            } else {
              UserSharedPreferences.settings.prefs.haptic = val;
            }
          });
        },
      ),
    );
  }
}
