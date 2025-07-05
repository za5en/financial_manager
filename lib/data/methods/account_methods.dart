import 'package:dio/dio.dart';
import 'package:financial_manager/data/models/account/account_model.dart';
import 'package:retrofit/retrofit.dart';

part 'account_methods.g.dart';

@RestApi()
abstract class AccountMethods {
  factory AccountMethods(Dio dio) => _AccountMethods(dio);

  @GET('/accounts')
  Future<List<AccountModel>> getAccount();
}
