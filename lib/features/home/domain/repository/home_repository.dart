import '../../../../core/resource/data_state.dart';
import '../../data/model/params/product_params.dart';
import '../entities/product_entity.dart';

abstract class IHomeRepository {
  Future<DataState<List<ProductEntity>>> getProduct(
      {required ProductParams params});
  Future<DataState<ProductEntity>> getProductDetail(
      {required ProductParams params});
}
