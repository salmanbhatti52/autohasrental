import 'package:flutter/material.dart';

import 'colors.dart';
import 'previous_page.dart/previous_page.dart';
import 'upcoming_page/upcoming_page.dart';

class TabbarCarBooings extends StatefulWidget {
  const TabbarCarBooings({super.key});

  @override
  State<TabbarCarBooings> createState() => _TabbarCarBooingsState();
}

abstract class TickerProvider {}

class _TabbarCarBooingsState extends State<TabbarCarBooings>
    with TickerProviderStateMixin {
  List<String> tabs = ["Previous", "Upcoming"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 2, vsync: this);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
              width: 344,
              height: 48,
              decoration: BoxDecoration(
                  color: const Color(0xffd4dce1),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                child: TabBar(
                  controller: tabcontroller,
                  indicator: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  indicatorColor: kWhite,
                  isScrollable: true,
                  labelColor: kBlack,
                  labelPadding: const EdgeInsets.only(left: 50, right: 46),
                  labelStyle: const TextStyle(fontSize: 14),
                  unselectedLabelColor: kBlack,
                  tabs: const [
                    Tab(
                      text: "Previous",
                    ),
                    Tab(
                      text: "Upcoming",
                    ),
                  ],
                ),
              )),
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height,
          child: TabBarView(
            controller: tabcontroller,
            children: const [PreviousPage(), UpcomingPage()],
          ),
        ),
      ],
    );
  }
}
