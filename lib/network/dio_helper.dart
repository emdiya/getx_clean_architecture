import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../core/resource/base_dio_network_request.dart';
import '../utils/service/path_provider_serivces.dart';
import 'dio_cache_option.dart';

class DioHelper implements BaseDioNetworkRequest {
  static DioHelper? _instance;
  final Dio _dio;
  late BaseOptions? options;
  DioCacheOptions defaultCacheOptions = DioCacheOptions();
  Directory? _directory;
  late HiveCacheStore _cacheStore;
  factory DioHelper([BaseOptions? options]) =>
      _instance ??= DioHelper._(options);

  DioHelper._([BaseOptions? options]) : _dio = Dio(options); // MODIFIED

  void addInterceptor(List<Interceptor> interceptor) {
    log("$interceptor has been added");
    _dio.interceptors.addAll(interceptor);
  }

  @override
  Future<Response<T>> delete<T>(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    return _dio.delete(path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options);
  }

  @override
  Future<Response> download(String urlPath, savePath,
      {ProgressCallback? onReceiveProgress,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      Object? data,
      Options? options}) {
    return _dio.download(urlPath, savePath,
        data: data,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        options: options);
  }

  @override
  Future<Response<T>> fetch<T>(RequestOptions requestOptions) {
    return _dio.fetch(requestOptions);
  }

  @override
  Future<Response<T>> get<T>(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      DioCacheOptions? dioCacheOptions}) async {
    await _setCachedResponse(dioCacheOptions);

    return _dio.get(
      path,
      queryParameters: queryParameters,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> head<T>(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken}) {
    // TODO: implement head
    throw UnimplementedError();
  }

  void onInitHiveCached() async {
    _directory = Get.find<PathProviderService>().directory;
    debugPrint("_directory: $_directory");
    _cacheStore = HiveCacheStore(
      _directory!.path,
      hiveBoxName: "getxcleanarchitectureapp",
    );
  }

  @override
  Future<Response<T>> patch<T>(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    return _dio.patch(path,
        data: data,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        options: options);
  }

  @override
  Future<Response<T>> post<T>(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    return _dio.post(path,
        data: data,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        options: options);
  }

  @override
  Future<Response<T>> put<T>(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    return _dio.put(path,
        data: data,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        options: options);
  }

  @override
  Future<Response<T>> request<T>(String url,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      Options? options,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    // TODO: implement request
    throw UnimplementedError();
  }

  Future<void> _setCachedResponse(DioCacheOptions? dioCacheOptions) async {
    if (dioCacheOptions != null) {
      CachePolicy cachePolicy = dioCacheOptions.isRefresh
          ? CachePolicy.refresh
          : defaultCacheOptions.cachePolicy;
      debugPrint("isRefresh: ${dioCacheOptions.isRefresh}");
      final customCacheOptions = CacheOptions(
        store: _cacheStore,
        policy: cachePolicy,
        priority: CachePriority.high,
        maxStale: defaultCacheOptions.cacheDuration,
        // hitCacheOnErrorExcept: [401, 404],
        keyBuilder: (request) {
          return request.uri.toString();
        },
        allowPostMethod: false,
      );

      _dio.interceptors.add(DioCacheInterceptor(options: customCacheOptions));
      return;
    } else {
      final customCacheOptions = CacheOptions(
        store: _cacheStore,
        policy: defaultCacheOptions.cachePolicy,
        priority: CachePriority.high,
        maxStale: defaultCacheOptions.cacheDuration,
        // hitCacheOnErrorExcept: [401, 404],
        keyBuilder: (request) {
          return request.uri.toString();
        },
        allowPostMethod: false,
      );
      _dio.interceptors.add(DioCacheInterceptor(options: customCacheOptions));
      debugPrint("Hello 1");
    }
  }
}
