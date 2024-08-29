import 'package:flutter/material.dart';

import '../test_page.dart';

class PersistentTabsWidget extends StatefulWidget {
  const PersistentTabsWidget({
    super.key,
  });

  @override
  _PersistentTabsWidgetState createState() => _PersistentTabsWidgetState();
}

class _PersistentTabsWidgetState extends State<PersistentTabsWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> tabs = [
    const Tab(text: 'Media'),
    const Tab(text: 'Links'),
    const Tab(text: 'Voice'),
    const Tab(text: 'GIFs'),
    const Tab(text: 'Groups'),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 25,
      flexibleSpace: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: leftPadding),
            child: TabBar(
              controller: tabController,
              labelPadding: const EdgeInsets.symmetric(horizontal: 5),
              indicatorColor: Colors.lightBlue,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.lightBlue,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: tabs,
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.8,
            height: 1,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }
}
