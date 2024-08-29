import 'package:get/get.dart';

// import '../../../../core/resource/base_use_case.dart';
import '../../data/data_sources/remote/remote_data_source.dart';
import '../../data/repository/home_repository_impl.dart';
import '../../domain/repository/home_repository.dart';
import '../../domain/usecases/get_product.dart';
import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IHomeRemoteDataSource>(() => HomeRemoteDataSourceImpl());
    Get.lazyPut<IHomeRepository>(() => HomeRepositoyImpl(Get.find()));
    Get.lazyPut<GetProductUseCase>(() => GetProductUseCase(Get.find()));
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
