import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import 'sliver/my_popular_list.dart';
import 'sliver/my_tabbar.dart';
import 'sliver/my_title.dart';
import 'sliver/sliver_app_bar.dart';

const selectedColor = Color(0xff1a73e8);
const unselectedColor = Color(0xff5f6368);
final tabs = [
  const Tab(text: 'Tab1'),
  const Tab(text: 'Tab2'),
  const Tab(text: 'Tab3'),
];

class HomeBody extends GetView<HomeController> {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => RefreshIndicator(
          onRefresh: () => controller.refreshProduct(),
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                const MySliverAppbar(),
                const SliverToBoxAdapter(
                  child: Gap(20),
                ),
                SliverPersistentHeader(
                    delegate: MyTabbar(
                      child: Container(
                        color: context.theme.colorScheme.background,
                        child: TabBar(
                          isScrollable: true,
                          controller: controller.tabController,
                          tabs: tabs,
                          unselectedLabelColor: Colors.black,
                          // labelColor: selectedColor,
                          dividerHeight: 0,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            color: context.theme.colorScheme.primary
                                .withOpacity(0.2),
                          ),
                          automaticIndicatorColorAdjustment: true,
                          indicatorSize: TabBarIndicatorSize.tab,
                        ),
                      ),
                    ),
                    pinned: true),
                const MyTitle(),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: MyPopularList(),
                ),
              ],
            ),
          )
          // ListView.separated(
          //   itemCount: state!.length,
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   separatorBuilder: (context, index) => const Divider(
          //     height: 1,
          //   ),
          //   itemBuilder: (context, index) => ListTile(
          //     onTap: () {
          //       context.push('/detail?id=${state[index].id}');
          //     },
          //     title: Text("${state[index].title}"),
          //   ),
          // ),
          ),
      onLoading: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      onEmpty: const Center(child: Text('No data found')),
      onError: (error) => Center(child: Text("$error")),
    );
  }
}
