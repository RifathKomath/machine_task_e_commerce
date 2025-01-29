import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API Server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection Timeout";
        break;
      case DioExceptionType.connectionError:
        message = "No internet connection";
        break;
      case DioExceptionType.badCertificate:
        message = "Incorrect certificate";
        break;
      case DioExceptionType.badResponse:
        if (dioError.response != null) {
          // Handle bad response
          message = _handleError(dioError.response!.statusCode!, dioError.response!.data);
        } else {
          message = "Received an invalid response.";
        }
        break;
      case DioExceptionType.unknown:
        message = "Unknown error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message = "";

  static String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return "Bad Request";

      case 404:
        return error["message"] ?? "Something went wrong";
      case 500:
        return "Internal server error";
      case 208:
        return "Duplicate session detected";
      default:
        return error["message"] ?? "Something went wrong";
    }
  }

  @override
  String toString() => message;
}
