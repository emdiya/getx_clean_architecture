import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/detail_controller.dart';

class DetailBody extends GetView<DetailController> {
  const DetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => RefreshIndicator(
        onRefresh: () => controller.refreshProduct(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${state?.id}"),
              Text("${state?.id}"),
            ],
          ),
        ),
      ),
      onLoading: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      onEmpty: const Center(child: Text('No data found')),
      onError: (error) => Center(child: Text("$error")),
    );
  }
}
