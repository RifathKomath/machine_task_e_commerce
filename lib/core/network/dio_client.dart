import 'package:dio/dio.dart';
import '../config/constants/constants.dart';
import 'dio_exceptions.dart';
import 'logging_interceptor.dart'; 


class DioClient {
  late final Dio _dio;
  DioClient(): _dio = Dio(
    BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      responseType: ResponseType.json,
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(LoggingInterceptor());

  // GET METHOD
  Future<Response> get(
      String url, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e); // Convert to DioExceptions
    }
  }

  // POST METHOD
  Future<Response> post(
      String url, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      // Handle response codes
      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 201) {
          return response;
        } else {
        // Use the DioExceptions to handle error
        throw DioExceptions.fromDioError(DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e); // Convert to DioExceptions
    }
  }

  // PUT METHOD
  Future<Response> put(
      String url, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e); // Convert to DioExceptions
    }
  }

  // DELETE METHOD
  Future<dynamic> delete(
      String url, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e); // Convert to DioExceptions
    }
  }
}
