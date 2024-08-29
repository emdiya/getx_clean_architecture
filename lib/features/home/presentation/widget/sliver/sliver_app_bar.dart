import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySliverAppbar extends StatelessWidget {
  const MySliverAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // title: const Text("Explore Products"),
      collapsedHeight: kToolbarHeight,
      expandedHeight: context.height * .12,
      // pinned: true,
      floating: false,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.only(
          left: 20,
          right: 16,
        ),
        title: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "Discorever\nYour Products",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: context.height * .08,
                width: 50,
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80)),
                  child: InkWell(
                      onTap: () {}, child: const Icon(CupertinoIcons.search)),
                ),
              )
            ],
          ),
        ),
        expandedTitleScale: 1.3,
        collapseMode: CollapseMode.parallax,
      ),
    );
  }
}
