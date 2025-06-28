import 'dart:async';

import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_floating_action_button.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:financial_manager/view/widgets/f_svg.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shake/shake.dart';
import 'package:spoiler_widget/spoiler_widget.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final _currencies = [
    ['Российский рубль ₽', Icons.currency_ruble_outlined, '₽'],
    ['Американский доллар \$', Icons.attach_money_outlined, '\$'],
    ['Евро', Icons.euro_outlined, '€'],
    ['Отмена', Icons.cancel_outlined],
  ];
  String currentCurrency = '₽';
  bool isEditing = false;
  String accountName = 'Баланс';
  String tempName = '';
  bool showBalance = false;
  bool isDown = false;

  final TextEditingController controller = TextEditingController();

  late ShakeDetector detector;

  List<AccelerometerEvent> _accelerometerValues = [];
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.waitForStart(
      onPhoneShake: (ShakeEvent event) {
        setState(() {
          showBalance = !showBalance;
        });
      },
    );
    detector.startListening();

    _accelerometerSubscription = accelerometerEvents.listen((event) {
      setState(() {
        _accelerometerValues = [event];
        if (_accelerometerValues[0].y < -5) {
          if (!isDown) {
            showBalance = !showBalance;
          }
          isDown = true;
        }
        if (_accelerometerValues[0].y >= -5) {
          isDown = false;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _accelerometerSubscription.cancel();
    detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: FAppbar(
        title: 'Мой счет',
        leading:
            isEditing
                ? InkWell(
                  onTap: () {
                    setState(() {
                      isEditing = !isEditing;
                      controller.text = '';
                    });
                  },
                  child: Icon(
                    Icons.close_outlined,
                    color: Color.fromRGBO(73, 69, 79, 1),
                  ),
                )
                : null,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (isEditing && tempName != '') {
                    accountName = tempName;
                    tempName = '';
                    controller.text = '';
                  }
                  isEditing = !isEditing;
                });
              },
              child:
                  isEditing
                      ? Icon(
                        Icons.check_outlined,
                        color: Color.fromRGBO(73, 69, 79, 1),
                      )
                      : FSvg(assetName: 'assets/images/edit.svg'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          FListLine(
            height: h * 0.06,
            leftPadding: w * 0.04,
            rightPadding: 0,
            name: accountName,
            onNameChanged: (text) {
              setState(() => tempName = text);
            },
            controller: controller,
            isEmojiInContainer: true,
            icon:
                isEditing
                    ? Icon(
                      Icons.person_outline,
                      color: Color.fromRGBO(73, 69, 79, 1),
                    )
                    : null,
            editName: isEditing ? true : false,
            emoji: !isEditing ? '💰' : null,
            emojiBackground: !isEditing ? Colors.white : null,
            rightSide: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: w * 0.035),
                  child:
                      showBalance
                          ? Text('-670 000 ₽')
                          : SpoilerText(
                            text: '-670 000 ₽',
                            config: TextSpoilerConfig(
                              isEnabled: !showBalance,
                              enableFadeAnimation: true,
                              particleColor: Color.fromRGBO(
                                218,
                                218,
                                218,
                                0.498,
                              ),
                              textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: h * 0.06,
                    padding: EdgeInsets.only(
                      right: isEditing ? w * 0.02 : w * 0.04,
                      left: isEditing ? w * 0.02 : 0,
                    ),
                    color:
                        isEditing
                            ? Color.fromRGBO(228, 105, 98, 1)
                            : Color.fromRGBO(212, 250, 230, 1),
                    child: FSvg(
                      assetName:
                          isEditing
                              ? 'assets/images/delete.svg'
                              : 'assets/images/more.svg',
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor:
                isEditing ? Colors.white : Color.fromRGBO(212, 250, 230, 1),
          ),
          Visibility(
            visible: !isEditing,
            child: FListLine(
              height: h * 0.06,
              leftPadding: 0,
              rightPadding: w * 0.04,
              name: 'Валюта',
              isEmojiInContainer: true,
              bottomBorderColor: Colors.transparent,
              rightSide: InkWell(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: w * 0.035),
                      child: Text(currentCurrency),
                    ),
                    FSvg(assetName: 'assets/images/more.svg'),
                  ],
                ),
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    showDragHandle: true,
                    useRootNavigator: true,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: _currencies.length * h * 0.08,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _currencies.length,
                                  itemBuilder: (builder, index) {
                                    return InkWell(
                                      onTap: () {
                                        if (_currencies[index][0] == 'Отмена') {
                                          Navigator.pop(context);
                                        } else {
                                          setState(() {
                                            currentCurrency =
                                                _currencies[index][2] as String;
                                          });
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: FListLine(
                                        height: h * 0.077,
                                        leftPadding: w * 0.04,
                                        rightPadding: w * 0.03,
                                        name: _currencies[index][0] as String,
                                        isEmojiInContainer: false,
                                        nameColor:
                                            _currencies[index][0] == 'Отмена'
                                                ? Colors.white
                                                : null,
                                        icon: Icon(
                                          _currencies[index][1] as IconData,
                                          color:
                                              _currencies[index][0] != 'Отмена'
                                                  ? Colors.black
                                                  : Colors.white,
                                        ),
                                        rightSide: SizedBox(),
                                        backgroundColor:
                                            _currencies[index][0] != 'Отмена'
                                                ? Color.fromRGBO(
                                                  247,
                                                  242,
                                                  250,
                                                  1,
                                                )
                                                : Color.fromRGBO(
                                                  228,
                                                  105,
                                                  98,
                                                  1,
                                                ),
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
                },
              ),
              backgroundColor: Color.fromRGBO(212, 250, 230, 1),
            ),
          ),
          Visibility(
            visible: isEditing,
            child: Padding(
              padding: EdgeInsets.only(top: h * 0.036),
              child: SizedBox(
                width: w * 0.92,
                height: h * 0.044,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all<double>(0),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Color.fromRGBO(228, 105, 98, 1),
                    ),
                    foregroundColor: WidgetStateProperty.all<Color>(
                      Colors.white,
                    ),
                  ),
                  onPressed: () {
                    // setState(() {
                    //   isEditing = !isEditing;
                    // });
                  },
                  child: Text('Удалить счет'),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FFloatingActionButton(),
    );
  }
}
