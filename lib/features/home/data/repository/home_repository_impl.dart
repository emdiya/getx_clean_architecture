import '../../../../core/resource/data_state.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_sources/remote/remote_data_source.dart';
import '../model/params/product_params.dart';

class HomeRepositoyImpl implements IHomeRepository {
  final IHomeRemoteDataSource _newsRemoteDataSource;
  HomeRepositoyImpl(this._newsRemoteDataSource);

  @override
  Future<DataState<List<ProductEntity>>> getProduct(
      {required ProductParams params}) async {
    try {
      var result =
          await _newsRemoteDataSource.getProducts(isRefresh: params.refresh);

      return DataSuccess(result);
    } catch (error) {
      return DataFailed(error);
    }
  }

  @override
  Future<DataState<ProductEntity>> getProductDetail(
      {required ProductParams params}) async {
    try {
      final result =
          await _newsRemoteDataSource.getProductDetail(params: params);
      return DataSuccess(result);
    } catch (error) {
      return DataFailed(error);
    }
  }
}
