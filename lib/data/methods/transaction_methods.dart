import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:financial_manager/data/models/transaction/transaction_request_model.dart';
import 'package:financial_manager/data/models/transaction/transaction_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'transaction_methods.g.dart';

@RestApi()
abstract class TransactionMethods {
  factory TransactionMethods(Dio dio) => _TransactionMethods(dio);

  @GET('/transactions/account/{accountId}/period')
  Future<List<TransactionResponseModel>> getTransactionsByPeriod(
    @Path('accountId') int accountId,
    @Query('startDate') String? startDate,
    @Query('endDate') String? endDate,
  );

  @GET('/transactions/{id}')
  Future<TransactionResponseModel> getTransaction(@Path('id') int id);

  @POST('/transactions')
  Future<TransactionResponseModel> createTransaction(
    @Body() TransactionRequestModel transactionRequest,
  );

  @PUT('/transactions/{id}')
  Future<TransactionResponseModel> updateTransaction(
    @Path('id') int id,
    @Body() TransactionRequestModel transactionRequest,
  );

  @DELETE('/transactions/{id}')
  Future<HttpResponse> deleteTransaction(@Path('id') int id);
}
