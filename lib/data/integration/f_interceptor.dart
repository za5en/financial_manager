import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = dotenv.env['TOKEN'];
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
