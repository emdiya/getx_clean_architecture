
import '../../../../core/resource/base_use_case.dart';
import '../../../../core/resource/data_state.dart';
import '../../data/model/params/product_params.dart';
import '../entities/product_entity.dart';
import '../repository/home_repository.dart';

class GetProductUseCase
    implements BaseUseCase<DataState<List<ProductEntity>>, ProductParams> {
  final IHomeRepository _usersRepository;
  GetProductUseCase(this._usersRepository);

  @override
  Future<DataState<List<ProductEntity>>> call({ProductParams? params}) async {
    return _usersRepository.getProduct(params: params!);
  }
}
