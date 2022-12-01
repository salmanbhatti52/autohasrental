import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import '../../../../../../Widget/colors.dart';
import 'driving_tab_description.dart';

class DrivingTabBar extends StatefulWidget {
  const DrivingTabBar({super.key});

  @override
  State<DrivingTabBar> createState() => _DrivingTabBarState();
}

abstract class TickerProvider {}

class _DrivingTabBarState extends State<DrivingTabBar> with TickerProviderStateMixin {
  List<String> tabs = ["Description", "Features", "Ratings"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 3, vsync: this);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              decoration: BoxDecoration(
                  color: const Color(0xffd4dce1),
                  borderRadius: BorderRadius.circular(30)),
              child: TabBar(
                controller: tabcontroller,
                indicator: BubbleTabIndicator(
                  indicatorHeight: 35.0,
                  indicatorColor: kWhite,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                ),
                indicatorColor: kWhite,
                isScrollable: true,
                labelColor: kBlack,
                labelPadding: const EdgeInsets.all(10),
                labelStyle: const TextStyle(fontSize: 14),
                unselectedLabelColor: kBlack,
                tabs: const [
                  Tab(text: "Description",),
                  Tab(text: "Features",),
                  Tab(text: "Ratings",),
                ],
              )),
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height*0.35,
          child: TabBarView(
            controller: tabcontroller,
            children: const [
              Description(),
              Description(),
              Description(),
            ],
          ),
        ),
      ],
    );
  }
}
