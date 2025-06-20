import 'package:dio/dio.dart';
import 'package:financial_manager/data/integration/f_interceptor.dart';

class ApiClient {
  static final BaseOptions _options = BaseOptions();

  static const String baseUrl = 'https://shmr-finance.ru/api/v1/';

  static const Map<String, dynamic> baseHeaders = {
    'Accept': 'application/json, application/problem+json',
    'Content-Type': 'application/json',
  };

  static final Dio dio = Dio(
    _options
      ..baseUrl = baseUrl
      ..headers = baseHeaders,
  )..interceptors.add(FInterceptor());
}
