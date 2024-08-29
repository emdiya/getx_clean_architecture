import 'package:dio/dio.dart';

import '../../network/dio_exceptions.dart';

class CustomObject extends Object {}

class DataFailed<T> extends DataState<T> {
  const DataFailed(Object error) : super(error: error);
}

abstract class DataState<T> {
  final T? data;
  final Object? error;
  const DataState({this.data, this.error});
  @override
  String toString() {
    Object? error = this.error;
    if (error is DioException) {
      return DioExceptions.fromDioError(error).toString();
    }
    return "Exception: $error";
  }
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}
