import 'package:dio/dio.dart';
import 'package:testproject/network/dio_interceptor.dart';

import 'dio_helper.dart';
import 'dio_logger.dart';
import 'end_point.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  static DioClient get instance => _instance;
  final DioHelper dio = DioHelper(
    BaseOptions(baseUrl: BaseUrl.dev),
  );
  DioClient._internal() {
    dio.onInitHiveCached();
    dio.addInterceptor([DioLogger(requestHeader: true), DioInterceptor()]);
  }
}
