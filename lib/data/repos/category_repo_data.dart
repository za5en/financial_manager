import 'dart:developer';

import 'package:financial_manager/data/database/drift_database.dart' as sql;
import 'package:financial_manager/data/models/category/category_model.dart';
import 'package:financial_manager/domain/repos/category_repo_domain.dart';

class CategoryRepoData implements CategoryRepoDomain {
  // список категорий
  final List<CategoryModel> categories = [
    CategoryModel(id: 1, name: "Зарплата", emoji: "💰", isIncome: true),
  ];

  static final sql.AppDatabase _sqlDatabase = sql.AppDatabase();

  // Future<void> initialize() async {
  //   _sqlDatabase = sql.AppDatabase();
  // }

  // получить все категории
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      await Future.delayed(Duration(milliseconds: 200));
      final res = await _sqlDatabase.getCategories();
      List<CategoryModel> cats = [];
      for (var record in res) {
        cats.add(
          CategoryModel(
            id: record.id,
            name: record.name,
            emoji: record.emoji,
            isIncome: record.isIncome,
          ),
        );
      }

      final response = categories;
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // получить категории по типу
  @override
  Future<List<CategoryModel>> getCategoriesByType(bool isIncome) async {
    try {
      await Future.delayed(Duration(milliseconds: 200));
      final res = await _sqlDatabase.getCategoriesByType(isIncome);
      List<CategoryModel> cats = [];
      for (var record in res) {
        cats.add(
          CategoryModel(
            id: record.id,
            name: record.name,
            emoji: record.emoji,
            isIncome: record.isIncome,
          ),
        );
      }

      final List<CategoryModel> categoriesByType =
          categories.where((el) => el.isIncome == isIncome).toList();
      return categoriesByType;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
