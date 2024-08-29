import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../config/my_router.dart';

RouteMatchList getRouteMatchList() {
  final RouteMatch lastMatch = router.routerDelegate.currentConfiguration.last;
  final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
      ? lastMatch.matches
      : router.routerDelegate.currentConfiguration;
  return matchList;
}

abstract class BindingInjection<T extends GetxController> extends Widget {
  final Bindings? binding;
  const BindingInjection({
    super.key,
    required this.binding,
  }) : assert(binding != null);
  T get controller => GetInstance().find<T>();
  @protected
  Widget build(BuildContext context);

  @override
  CustomStatelessElement createElement() =>
      CustomStatelessElement<T>(this, binding);
}

class CustomStatelessElement<T extends GetxController>
    extends ComponentElement {
  final Bindings? binding;

  /// Creates an element that uses the given widget as its configuration.
  CustomStatelessElement(BindingInjection super.widget, this.binding);

  @override
  Widget build() => GetBuilder<T>(
      initState: (_) => binding?.dependencies(),
      autoRemove: true,
      builder: (controller) {
        return (widget as BindingInjection).build(this);
      });

  @override
  void update(BindingInjection newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild(force: true);
  }
}
// import 'package:go_router/go_router.dart';

// import '../../../config/routes.dart';

mixin GoRouterStateMixin on GetxController {
  GoException? get error => getRouteMatchList().error;
  Object? get extra => getRouteMatchList().extra;
  String get fullPath => getRouteMatchList().fullPath;
  String get pathParameter => getRouteMatchList().uri.path;
  Map<String, String> get queryParameters =>
      getRouteMatchList().uri.queryParameters;
  Uri? get uri => getRouteMatchList().uri;
}
