import 'package:financial_manager/view/states/category/category_local.dart';

class CategoryViewModel {
  final List<CategoryLocal> items;

  CategoryViewModel._({required this.items});

  factory CategoryViewModel.buildWith(List<CategoryLocal> items) =>
      CategoryViewModel._(items: items);
}
