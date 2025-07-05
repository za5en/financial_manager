import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const List<String> settings = [
    'Тёмная тема',
    'Основной цвет',
    'Звуки',
    'Хаптики',
    'Код пароль',
    'Синхронизация',
    'Язык',
    'О программе',
  ];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: FAppbar(title: 'Настройки'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: settings.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (builder, index) {
                return InkWell(
                  onTap: () {},
                  child: FListLine(
                    height: h * 0.06,
                    leftPadding: w * 0.02,
                    rightPadding: w * 0.02,
                    name: settings[index],
                    rightSide:
                        index == 0
                            ? ThemeSwitch()
                            : Icon(
                              Icons.arrow_right,
                              color: Color.fromRGBO(73, 69, 79, 1),
                            ),
                    backgroundColor: Color.fromRGBO(254, 247, 255, 1),
                    isEmojiInContainer: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isDark,
      activeColor: Color.fromRGBO(42, 232, 129, 1),
      onChanged: (bool value) {
        setState(() {
          isDark = !isDark;
        });
      },
    );
  }
}
