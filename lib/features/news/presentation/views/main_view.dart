import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hot_news/features/news/presentation/animation/loading_animation_view.dart';
import 'package:hot_news/features/news/presentation/resources/color_manager.dart';
import 'package:hot_news/features/news/presentation/resources/value_manager.dart';
import 'package:hot_news/features/news/presentation/views/headline_news_view.dart';
import 'package:hot_news/features/news/presentation/views/hot_card_skeleton_loader.dart';
import 'package:hot_news/features/news/presentation/views/search_view.dart';
import 'package:hot_news/features/news/presentation/widgets/circle_avatar_loading_skeleton.dart';
import 'package:hot_news/main.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
//import 'package:hot_news/features/news/data/models/params.dart' as cat
//   show Category;
import 'package:skeleton_loader/skeleton_loader.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: controller,
      bottomScreenMargin: 0,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }

  List<Widget> _buildScreens() {
    return [
      const WorldNews(),
      const Saved(),
      MyHomePage(),
      const Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.newspaper),
        title: ("News"),
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.save),
        title: ("Saved"),
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}

class WorldNews extends StatelessWidget {
  const WorldNews({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SkeletonLoader(
      builder: Column(
        children: [
          const SingleChildScrollView(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(
                    AppPadding.p8,
                  ),
                  child: CircleAvatar(
                    radius: AppSize.s50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    AppPadding.p8,
                  ),
                  child: CircleAvatar(
                    radius: AppSize.s50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    AppPadding.p8,
                  ),
                  child: CircleAvatar(
                    radius: AppSize.s50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    AppPadding.p8,
                  ),
                  child: CircleAvatar(
                    radius: AppSize.s50,
                  ),
                ),
              ],
            ),
          ),
          CircleAvataLoadingSkeleton(),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p4),
            child: CircleAvatar(
              child: CircularProgressIndicator(
                strokeWidth: AppMagine.m16,
                color: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
      items: 1,
      period: Duration(seconds: 2),
      highlightColor: Colors.grey,
      direction: SkeletonDirection.ttb,
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchView();
  }
}

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    return const HeadLineNewsView();
  }
}
