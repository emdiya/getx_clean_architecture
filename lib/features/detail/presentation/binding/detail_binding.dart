// import 'package:get/get.dart';

// // import '../../../../core/resource/base_use_case.dart';
// import '../../data/data_sources/remote/remote_data_source.dart';
// import '../../data/repository/home_repository_impl.dart';
// import '../../domain/adapters/home_repo_adapter.dart';
// import '../../domain/usecases/get_home.dart';
// import '../controller/home_controller.dart';

// class HomeBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<IHomeRemoteDataSource>(() => HomeRemoteDataSourceImpl());
//     Get.lazyPut<IHomeRepository>(() => HomeRepositoyImpl(Get.find()));
//     Get.lazyPut<GetHomeUseCase>(() => GetHomeUseCase(Get.find()));
//     Get.lazyPut<HomeController>(() => HomeController(Get.find()));
//   }
// }

import 'package:get/get.dart';

import '../../../home/domain/usecases/get_product_detail.dart';
import '../controller/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetProductDetailUseCase>(
        () => GetProductDetailUseCase(Get.find()));
    Get.lazyPut<DetailController>(() => DetailController(Get.find()));
  }
}
