import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';

// import '../../../config/routes.dart';

extension Context on BuildContext {
  double get h {
    return MediaQuery.of(this).size.height;
  }

  bool get isLightMode =>
      Theme.of(this).colorScheme.brightness == Brightness.light;

  TextTheme get text {
    return Theme.of(this).textTheme;
  }

  double get w {
    return MediaQuery.of(this).size.width;
  }

  T buildCrossPlatform<T>({
    required T mobile,
    required T web,
  }) {
    final isMobile = GetPlatform.isIOS && GetPlatform.isAndroid;
    final isWeb = GetPlatform.isWeb;
    return isMobile
        ? mobile
        : isWeb
            ? web
            : mobile;
  }

  double containerMaxWidth() {
    final wd = MediaQuery.of(this).size.width;
    return wd >= 2048
        ? 3840
        : wd >= 1920
            ? 2048
            : wd >= 1366
                ? 1920
                : 1366;
  }

  /// responsive
  /// Eight pixel margin above and below, no horizontal margins:
  T responsive<T>(
    ///
    /// min-width >=1024
    T defaultVal, {
    ///
    /// min-width >=1024
    T? sm,

    /// min-width >=1024
    T? md,

    /// min-width >=1024
    T? lg,

    /// min-width >=1024
    T? xl,

    /// min-width >=1024
    T? xxl,
  }) {
    final wd = MediaQuery.of(this).size.width;
    return wd >= 1536
        ? (xxl ?? xl ?? lg ?? md ?? sm ?? defaultVal)
        : wd >= 1280
            ? (xl ?? lg ?? md ?? sm ?? defaultVal)
            : wd >= 1024
                ? (lg ?? md ?? sm ?? defaultVal)
                : wd >= 768
                    ? (md ?? sm ?? defaultVal)
                    : wd >= 640
                        ? (sm ?? defaultVal)
                        : defaultVal;
  }

  // void goToSubRoute<T extends Object?>(String subRoute, {Object? extra}) {
  //   final RouteMatch lastMatch =
  //       router.routerDelegate.currentConfiguration.last;
  //   final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
  //       ? lastMatch.matches
  //       : router.routerDelegate.currentConfiguration;
  //   final String location = matchList.uri.toString();
  //   String pushPath = location + subRoute;
  //   debugPrint("location: $location ,pushPath: $pushPath");

  //   go(pushPath, extra: extra);
  // }
  // Future<T?> pushToSubRoute<T extends Object?>(String subRoute,
  //     {Object? extra}) async {
  //   final RouteMatch lastMatch =
  //       router.routerDelegate.currentConfiguration.last;
  //   final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
  //       ? lastMatch.matches
  //       : router.routerDelegate.currentConfiguration;
  //   final String location = matchList.fullPath;
  //   String pushPath = location + subRoute;
  //   debugPrint("location: $location ,pushPath: $pushPath");

  //   return await push(pushPath, extra: extra);
  // }

  EdgeInsetsGeometry responsivePadding() {
    final wd = MediaQuery.of(this).size.width;

    return responsive(
      const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      md: EdgeInsets.symmetric(
        horizontal: wd * 0.06,
      ),
      xl: EdgeInsets.symmetric(
        horizontal: wd * 0.1,
      ),
      xxl: EdgeInsets.symmetric(
        horizontal: wd * 0.09,
      ),
    );
  }

  T responsiveSize<T>({
    required T small,
    required T normal,
    required T large,
    required T extraLarge,
    T? ultraLarge,
    T? megaLarge,
  }) {
    double deviceWidth = MediaQuery.of(this).size.width;
    // debugPrint("deviceWidth:$deviceWidth");
    if (deviceWidth > 1920) return megaLarge ?? ultraLarge ?? extraLarge;
    if (deviceWidth > 1200) return ultraLarge ?? extraLarge;
    if (deviceWidth > 900) return extraLarge;
    if (deviceWidth > 600) return large;
    if (deviceWidth > 400) return normal;
    return small;
  }

  T responsiveSize2<T>({
    required T small,
    required T normal,
    required T large,
    required T extraLarge,
    T? ultraLarge,
  }) {
    double deviceWidth = MediaQuery.of(this).size.width;
    if (deviceWidth > 2000) return ultraLarge ?? extraLarge;
    if (deviceWidth > 1100) return extraLarge;
    if (deviceWidth > 1000) return large;
    if (deviceWidth > 900) return large;
    if (deviceWidth > 600) return large;
    if (deviceWidth > 400) return normal;
    return small;
  }
}

extension Formater on String {
  // formatPhoneNumber({bool isHideThreeLength = true}) {
  //   final result = NumberFormat('#,##0', 'en');
  //   // RegExp regex = RegExp(r"([.]*0+)(?!.*\d)");
  //   double num = double.parse(this);
  //   if (isHideThreeLength) {
  //     String str = result.format(num).replaceAll(",", " ");
  //     str = str.replaceRange(str.length - 3, str.length, "***");
  //     return str;
  //   }
  //   return result.format(num).replaceAll(",", " ");
  // }

  removeLocalUrl() {
    final str = replaceAll("http://localhost:8080", "");
    return str;
  }

  // toCurrency({bool hideDollar = false}) {
  //   final result =
  //       NumberFormat(hideDollar ? "#,##0.00" : "\$#,##0.00", "en_US");
  //   double num = double.parse(this);
  //   return result.format(num);
  // }

  // asInput() {
  //   String result = '';
  //   var number = double.tryParse(this);

  //   if (number != null) {
  //     debugPrint(
  //         'NUMBER = ${FormatNumber.formatNumberDefualt(number.floor())}');
  //     if (contains('.')) {
  //       result =
  //           '${FormatNumber.formatNumberDefualt(number.floor())}.${substring(indexOf('.') + 1)}';
  //       return result;
  //     } else {
  //       result = FormatNumber.formatNumberDefualt(number.floor());
  //       return result;
  //     }
  //   } else {
  //     return this;
  //   }
  // }

  toDuration(
    Duration duration,
  ) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    // String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${duration.inMinutes.remainder(60).abs()}:$twoDigitSeconds";
  }

  // toRemoveTrailingZero() {
  //   final result = NumberFormat("#,##0.00", "en_US");
  //   RegExp regex = RegExp(r"([.]*0+)(?!.*\d)");
  //   double num = double.parse(this);
  //   return result.format(num).toString().replaceAll(regex, '');
  // }
}

extension SwappableList<E> on List<E> {
  void swap(int first, int second) {
    final temp = this[first];
    this[first] = this[second];
    this[second] = temp;
  }
}
