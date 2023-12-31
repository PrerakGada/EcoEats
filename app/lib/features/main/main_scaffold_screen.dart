// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/palette.dart';
import '../edit_profile/profile_screen.dart';
import '../feed/feed_screen.dart';
import '../foods/food_screen.dart';
import '../map/map_screen.dart';

@RoutePage()
class MainScaffoldScreen extends StatefulWidget {
  const MainScaffoldScreen({super.key});

  @override
  State<MainScaffoldScreen> createState() => _MainScaffoldScreenState();
}

class _MainScaffoldScreenState extends State<MainScaffoldScreen> {
  PageController pageController = PageController();
  int index = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          FeedScreen(),
          FoodScreen(),
          // ByteScreen(),
          ProfileScreen(),
          MapScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (value) {
          setState(() {
            index = value;
            pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/feed.svg',
              color: index == 0
                  ? Palette.primary
                  : MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Palette.grey
                      : Palette.black,
            ),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/network.svg',
              color: index == 1
                  ? Palette.primary
                  : MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Palette.grey
                      : Palette.black,
            ),
            label: 'Food',
          ),
          // BottomNavigationBarItem(
          //   icon: SvgPicture.asset(
          //     'assets/svgs/bytes.svg',
          //     color: index == 2
          //         ? Palette.primary
          //         : MediaQuery.of(context).platformBrightness == Brightness.dark
          //             ? Palette.grey
          //             : Palette.black,
          //   ),
          //   label: 'Instamart',
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/stars.svg',
              color: index == 2
                  ? Palette.primary
                  : MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Palette.grey
                      : Palette.black,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/dashboard.svg',
              color: index == 3
                  ? Palette.primary
                  : MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Palette.grey
                      : Palette.black,
            ),
            label: 'Genie',
          ),
        ],
      ),
    );
  }
}
