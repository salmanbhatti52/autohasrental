import 'package:flutter/material.dart';
import '../../../Utils/colors.dart';
import 'BookingTabs/PreviousTab/PreviousTabs/previous_tabs_page.dart';
import 'BookingTabs/UpcomingTab/UpcomingTabs/upcoming_tabs_page.dart';

class TabbarCarBookings extends StatefulWidget {
  const TabbarCarBookings({super.key});

  @override
  State<TabbarCarBookings> createState() => _TabbarCarBookingsState();
}

abstract class TickerProvider {}

class _TabbarCarBookingsState extends State<TabbarCarBookings>
    with TickerProviderStateMixin {
  List<String> tabs = ["Previous", "Upcoming"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color(0xffd4dce1),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 05, vertical: 05),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  indicatorColor: kWhite,
                  isScrollable: true,
                  labelColor: kBlack,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 65),
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
            controller: tabController,
            children: [
              PreviousTabsPages(),
              UpComingTabsPages(),
            ],
          ),
        ),
      ],
    );
  }
}
