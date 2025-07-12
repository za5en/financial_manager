import 'dart:developer';

import 'package:financial_manager/data/models/category/category_model.dart';
import 'package:financial_manager/data/repos/category_repo_data.dart';

class CategoryLink {
  CategoryLink();

  final categoryRepoData = CategoryRepoData();

  Future<List<CategoryModel>> getCategories() async {
    try {
      final request = await categoryRepoData.getCategories();
      return request;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
