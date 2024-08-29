import 'package:flutter/material.dart';

import 'components/container_divider_widget.dart';
import 'components/custom_grid_widget.dart';
import 'components/notifications_widget.dart';
import 'components/persistent_profile_header.dart';
import 'components/persistent_tabs_widget.dart';
import 'components/profile_info_widget.dart';

const Duration duration = Duration(milliseconds: 100);
const double initialScrollOffset = 550.0;
const double leftPadding = 20.0;
const double scrollDesiredPercent = 0.65;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController =
      ScrollController(initialScrollOffset: initialScrollOffset);

  bool get mustExpand =>
      scrollController.offset < initialScrollOffset * scrollDesiredPercent;

  bool get mustRetract =>
      !mustExpand && scrollController.offset < initialScrollOffset;

  bool get scrollStopped =>
      !scrollController.position.isScrollingNotifier.value;

  void animateToMaxExtent() {
    scrollController.animateTo(
      50,
      duration: duration,
      curve: Curves.linear,
    );
  }

  void animateToNormalExtent() {
    scrollController.animateTo(
      initialScrollOffset,
      duration: duration,
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPersistentHeader(
            delegate: PersistentProfileHeader(),
            pinned: true,
          ),
          const SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileInfoWidget(),
                Divider(
                  indent: leftPadding,
                  color: Colors.black,
                  thickness: 0.8,
                  height: 10,
                ),
                NotificationsWidget(),
                ContainerDividerWidget(),
              ],
            ),
          ),
          const PersistentTabsWidget(),
          const CustomGridWidget(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.position.addListener(_handleScrollingActivity);
    });
  }

  void _handleScrollingActivity() {
    if (scrollStopped) {
      if (mustRetract) {
        animateToNormalExtent();
      } else if (mustExpand) {
        animateToMaxExtent();
      }
    }
  }
}
