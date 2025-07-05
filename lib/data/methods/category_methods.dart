import 'package:dio/dio.dart';
import 'package:financial_manager/data/models/category/category_model.dart';
import 'package:retrofit/retrofit.dart';

part 'category_methods.g.dart';

@RestApi()
abstract class CategoryMethods {
  factory CategoryMethods(Dio dio) => _CategoryMethods(dio);

  @GET('/categories')
  Future<List<CategoryModel>> getCategories();
}
