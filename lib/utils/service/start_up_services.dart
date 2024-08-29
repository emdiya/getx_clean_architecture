import 'package:get/get.dart';

import 'authentication_serivces.dart';
import 'local_storage_services.dart';
import 'path_provider_serivces.dart';

class StartUpService extends GetxService {
  Future<StartUpService> init() async {
    Get.lazyPut<AuthenticationService>(() => AuthenticationService());
    await Get.putAsync(() => PathProviderService().init());
    await LocalStorageService.init();
    return this;
  }
}
