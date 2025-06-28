import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:financial_manager/view/widgets/f_search_line.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';

class ItemsView extends StatefulWidget {
  const ItemsView({super.key});

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  final _articles = [
    ['Аренда квартиры', '🏡'],
    ['Одежда', '👗'],
    ['На собачку', '🐶'],
    ['Ремонт квартиры'],
    ['Продукты', '🍭'],
    ['Спортзал', '🏋️'],
    ['Медицина', '💊'],
  ];
  String query = '';
  Fuzzy fuseList = Fuzzy([]);

  String letters(String name) {
    List<String> words = name.split(' ');
    String result = words[0][0];
    if (words.length > 1) {
      result += words[1][0].toUpperCase();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    var fuseArray = [];
    for (var article in _articles) {
      fuseArray.add(article[0]);
    }
    List searchList =
        Fuzzy(fuseArray).search(query).map((e) => e.item).toList();

    return Scaffold(
      appBar: FAppbar(title: 'Мои статьи'),
      body: Column(
        children: [
          FSearchLine(
            onSearchChanged: (text) {
              setState(() => query = text);
            },
            onSearchReset: () {
              setState(() => query = '');
            },
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: searchList.length,
              itemBuilder: (builder, index) {
                return FListLine(
                  height: h * 0.077,
                  leftPadding: w * 0.04,
                  rightPadding: w * 0.03,
                  name: searchList[index],
                  isEmojiInContainer: true,
                  emoji:
                      _articles
                                  .where((item) => item[0] == searchList[index])
                                  .first
                                  .length >
                              1
                          ? _articles
                              .where((item) => item[0] == searchList[index])
                              .first[1]
                          : letters(
                            _articles
                                .where((item) => item[0] == searchList[index])
                                .first[0],
                          ),
                  rightSide: SizedBox(),
                  backgroundColor: Color.fromRGBO(254, 247, 255, 1),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
