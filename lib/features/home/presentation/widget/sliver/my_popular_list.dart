import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class MyPopularList extends StatelessWidget {
  const MyPopularList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 300 / 400,
        mainAxisSpacing: context.width * 0.03,
        crossAxisSpacing: context.width * 0.03,
      ),
      initialItemCount: 20,
      itemBuilder: (context, index, animation) => ScaleTransition(
        scale: animation,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Image.network(
                        'https://i.imgur.com/cBuLvBi.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.primary),
                        ),
                        IconButton(
                          splashRadius: 10,
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_circle,
                            color: context.theme.colorScheme.primary,
                            size: 36,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
