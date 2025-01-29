

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  final Logger logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('Request: ${options.method} ${options.uri}');
    logger.i('Headers: ${options.headers}');
    logger.i('Request Data: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('Response: ${response.statusCode} ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e('Error: ${err.message}');
    if (err.response != null) {
      logger.e('Error Status Code: ${err.response?.statusCode}');
      logger.e('Error Response Data: ${err.response?.data}');
    }
    super.onError(err, handler);
  }
}
