import 'package:flutter/material.dart';

class MyTabbar extends SliverPersistentHeaderDelegate {
  final Widget child;

  MyTabbar({required this.child});
  @override
  // TODO: implement maxExtent
  double get maxExtent => 48.0;

  @override
  // TODO: implement minExtent
  double get minExtent => 48.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
