import 'package:flutter/material.dart';

class ContainerDividerWidget extends StatelessWidget {
  const ContainerDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: double.infinity,
      color: Colors.black.withOpacity(0.65),
    );
  }
}
