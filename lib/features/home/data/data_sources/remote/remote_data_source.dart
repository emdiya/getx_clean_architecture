import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../../network/dio_cache_option.dart';
import '../../../../../network/dio_client.dart';
import '../../../../../network/end_point.dart';
import '../../../domain/entities/product_entity.dart';
import '../../model/params/product_params.dart';

class HomeRemoteDataSourceImpl extends IHomeRemoteDataSource {
  @override
  Future<ProductEntity> getProductDetail(
      {required ProductParams params}) async {
    final Response response = await DioClient.instance.dio.get(
      Endpoints.productDetail(params.id),
      dioCacheOptions: DioCacheOptions(isRefresh: params.refresh),
    );
    return await compute(parseProduct, response);
  }

  // @override
  // Future<ProductEntity> getProductDetail(int id) async {
  //   final Response response = await DioClient.instance.dio.get(
  //       Endpoints.products,
  //       dioCacheOptions: DioCacheOptions(isRefresh: isRefresh));
  //   return await compute(parseProduct, response);
  // }

  @override
  Future<List<ProductEntity>> getProducts({bool isRefresh = false}) async {
    final Response response = await DioClient.instance.dio.get(
        Endpoints.products,
        dioCacheOptions: DioCacheOptions(isRefresh: isRefresh));
    return await compute(parseProducts, response);
  }

  @override
  ProductEntity parseProduct(Response response) {
    return ProductEntity.fromJson(response.data);
  }

  @override
  List<ProductEntity> parseProducts(Response response) {
    return response.data
        .map<ProductEntity>((e) => ProductEntity.fromJson(e))
        .toList();
  }
}

abstract class IHomeRemoteDataSource {
  Future<ProductEntity> getProductDetail({required ProductParams params});
  Future<List<ProductEntity>> getProducts({bool isRefresh = false});
  ProductEntity parseProduct(Response response);
  List<ProductEntity> parseProducts(Response response);
}
