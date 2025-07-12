import 'package:financial_manager/domain/link/category_link.dart';
import 'package:financial_manager/view/states/category/category_local.dart';
import 'package:financial_manager/view/states/category/category_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fuzzy/fuzzy.dart';

part 'category_state.dart';
part 'category_cubit.freezed.dart';

class CategoryCubit extends Cubit<CategoryState> {
  late final Fuzzy<CategoryLocal> searchItems;
  final CategoryLink categoryLink = CategoryLink();

  CategoryCubit() : super(CategoryState.loading());

  void getCategories() async {
    emit(CategoryState.loading());
    try {
      final response = await categoryLink.getCategories();
      final viewModel = CategoryViewModel.buildWith(
        response
            .map((e) => CategoryLocal.buildWith(e.id, e.name, e.emoji))
            .toList(),
      );

      searchItems = Fuzzy(
        viewModel.items,
        options: FuzzyOptions(
          keys: [
            WeightedKey<CategoryLocal>(
              name: 'name',
              getter: (item) => item.name,
              weight: 1.0,
            ),
          ],
        ),
      );

      emit(CategoryState.content(viewModel));
    } on Exception catch (e) {
      emit(CategoryState.error(e));
    }
  }

  void fuzzySearch(String query) {
    if (state is Content) {
      final searchItems = this.searchItems.search(query);
      final searchViewModel = CategoryViewModel.buildWith(
        searchItems.map((e) => e.item).toList(),
      );
      emit(CategoryState.content(searchViewModel));
    }
  }
}
