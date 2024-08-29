import 'package:flutter/material.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final double paddingTop;

  const ProfileHeaderWidget({
    super.key,
    required this.paddingTop,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5 + paddingTop,
      left: 0,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            const Expanded(child: SizedBox()),
            IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
