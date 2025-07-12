import 'package:financial_manager/i18n/app_localizations.dart';
import 'package:financial_manager/view/states/category/category_cubit.dart';
import 'package:financial_manager/view/widgets/f_appbar.dart';
import 'package:financial_manager/view/widgets/f_error.dart';
import 'package:financial_manager/view/widgets/f_list_line.dart';
import 'package:financial_manager/view/widgets/f_loading.dart';
import 'package:financial_manager/view/widgets/f_search_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: FAppbar(
        title: AppLocalizations.of(context)?.articles ?? 'Мои статьи',
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) => switch (state) {
          Loading() => FLoading(),
          CustomError() => FError(message: 'Error'),
          Content() => Column(
            children: [
              FSearchLine(
                onSearchChanged: (text) {
                  context.read<CategoryCubit>().fuzzySearch(text);
                },
                onSearchReset: () {
                  context.read<CategoryCubit>().fuzzySearch('');
                },
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.content.items.length,
                  itemBuilder: (builder, index) {
                    return FListLine(
                      height: h * 0.077,
                      leftPadding: w * 0.04,
                      rightPadding: w * 0.03,
                      name: state.content.items[index].name,
                      isEmojiInContainer: true,
                      emoji: state.content.items[index].emoji,
                      rightSide: SizedBox(),
                      backgroundColor: Color.fromRGBO(254, 247, 255, 1),
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
}
