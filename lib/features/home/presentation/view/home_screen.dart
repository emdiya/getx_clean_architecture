import 'package:flutter/material.dart';

import '../../../../utils/helper/state_manager/my_state_manager.dart';
import '../controller/home_controller.dart';
import '../widget/home_body.dart';

class HomeScreen extends BindingInjection<HomeController> {
  const HomeScreen({super.key, super.binding});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeBody(),
    );
  }
}

extension NumExtension on num {
  T coerceAtLeast<T extends num>(T min) => this < min ? min : this as T;
  T coerceAtMost<T extends num>(T max) => this > max ? max : this as T;
  T coerceIn<T extends num>(T min, T max) =>
      coerceAtMost(max).coerceAtLeast(min);
}
