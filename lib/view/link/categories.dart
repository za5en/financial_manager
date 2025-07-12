import 'package:financial_manager/data/models/category/category_model.dart';
import 'package:financial_manager/domain/link/category_link.dart';

class Categories {
  Categories();

  final categoryLink = CategoryLink();

  Future<List<CategoryModel>> getCategories() async {
    final request = await categoryLink.getCategories();

    return request;
  }
}
