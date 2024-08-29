import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        debugPrint("Bad: ${dioError.response}");
        try {
          message = dioError.response != null
              ? '[${dioError.response?.statusCode}]:${dioError.response?.data['message']}'
              : '[${dioError.response?.statusCode}]:Bad request from API server without json response';
        } catch (e) {
          message =
              '[${dioError.response?.statusCode}]: Bad request from API server without response body';
        }

        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.connectionError:
        debugPrint("connectionError");
        if (dioError.message!.contains("SocketException")) {
          message = 'Please check your internet connection';
          break;
        }
        message = 'Unexpected error occurred';
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  @override
  String toString() => message;

  // String _handleError(int? statusCode, dynamic error) {
  //   switch (statusCode) {
  //     case 400:
  //       return 'Bad request';
  //     case 401:
  //       return 'Unauthorized';
  //     case 403:
  //       return 'Forbidden';
  //     case 404:
  //       return '404 Not Found';
  //     case 500:
  //       return 'Internal server error';
  //     case 502:
  //       return 'Bad gateway';
  //     default:
  //       return 'Oops something went wrong';
  //   }
  // }
}
