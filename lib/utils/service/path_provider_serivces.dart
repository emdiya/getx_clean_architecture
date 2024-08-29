import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class PathProviderService extends GetxService {
  Directory? directory;

  Future<PathProviderService> init() async {
    directory = await getTemporaryDirectory();
    return this;
  }
}
