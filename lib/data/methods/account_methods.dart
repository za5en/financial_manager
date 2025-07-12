import 'package:dio/dio.dart';
import 'package:financial_manager/data/models/account/account_model.dart';
import 'package:financial_manager/data/models/account/account_update_request_model.dart';
import 'package:retrofit/retrofit.dart';

part 'account_methods.g.dart';

@RestApi()
abstract class AccountMethods {
  factory AccountMethods(Dio dio) => _AccountMethods(dio);

  @GET('/accounts')
  Future<List<AccountModel>> getAccount();

  @PUT('/accounts/{id}')
  Future<AccountModel> updateAccount(
    @Path('id') int id,
    @Body() AccountUpdateRequestModel account,
  );

  @DELETE('/accounts/{id}')
  Future<HttpResponse> deleteAccount(@Path('id') int id);
}
