import 'package:financial_manager/data/models/category/category_model.dart';

abstract interface class CategoryRepoDomain {
  Future<List<CategoryModel>> getCategories();
  Future<List<CategoryModel>> getCategoriesByType(bool isIncome);
}
