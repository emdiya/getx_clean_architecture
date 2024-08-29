
import '../../../../core/resource/base_use_case.dart';
import '../../../../core/resource/data_state.dart';
import '../../data/model/params/product_params.dart';
import '../entities/product_entity.dart';
import '../repository/home_repository.dart';

class GetProductDetailUseCase
    implements BaseUseCase<DataState<ProductEntity>, ProductParams> {
  final IHomeRepository _usersRepository;
  GetProductDetailUseCase(this._usersRepository);

  @override
  Future<DataState<ProductEntity>> call({ProductParams? params}) {
    return _usersRepository.getProductDetail(params: params!);
  }

  // @override
  // Future<DataState<List<ProductModel>>> call({ProductParams? params}) async {
  //   return _usersRepository.getProductDetail(params: params!);
  // }
}
