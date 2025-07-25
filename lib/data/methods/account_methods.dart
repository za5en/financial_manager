import 'package:dio/dio.dart';
import 'package:financial_manager/data/models/account/account_create_request_model.dart';
import 'package:financial_manager/data/models/account/account_history_response_model.dart';
import 'package:financial_manager/data/models/account/account_model.dart';
import 'package:financial_manager/data/models/account/account_response_model.dart';
import 'package:financial_manager/data/models/account/account_update_request_model.dart';
import 'package:retrofit/retrofit.dart';

part 'account_methods.g.dart';

@RestApi()
abstract class AccountMethods {
  factory AccountMethods(Dio dio) => _AccountMethods(dio);

  @GET('/accounts')
  Future<List<AccountModel>> getAccount();

  @POST('/accounts')
  Future<AccountModel> createAccount(@Body() AccountCreateRequestModel account);

  @GET('/accounts/{id}')
  Future<AccountResponseModel> getAccountById(@Path('id') int id);

  @PUT('/accounts/{id}')
  Future<AccountModel> updateAccount(
    @Path('id') int id,
    @Body() AccountUpdateRequestModel account,
  );

  @DELETE('/accounts/{id}')
  Future<void> deleteAccount(@Path('id') int id);

  @GET('/accounts/{id}/history')
  Future<AccountHistoryResponseModel> getAccountHistory(@Path('id') int id);
}
