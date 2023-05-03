import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'DrivingPrevious/driving_previous_page.dart';
import 'EVPrevious/ev_previous_page.dart';
import 'PhotoPrevious/photo_previous_page.dart';

class PreviousTabsPages extends StatefulWidget {
  PreviousTabsPages({super.key});

  @override
  State<PreviousTabsPages> createState() => _PreviousTabsPagesState();
}

abstract class TickerProvider {}

class _PreviousTabsPagesState extends State<PreviousTabsPages> with TickerProviderStateMixin {
  List<String> tabs = ["Photography", "Driving ", "EV "];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 0, right: 05, top: 05),
          child: Container(
              width: MediaQuery.of(context).size.width*0.75,
              height: MediaQuery.of(context).size.height* 0.04,
              decoration: BoxDecoration(
                  color: Color(0xffd4dce1),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 0),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  indicatorColor: kWhite,
                  isScrollable: true,
                  labelColor: kBlack,
                  labelPadding: EdgeInsets.only(left: 20, right: 20),
                  labelStyle: TextStyle(fontSize: 14),
                  unselectedLabelColor: kBlack,
                  tabs: [
                    Tab(
                      text: "Photography",
                    ),
                    Tab(
                      text: "Driving ",
                    ),
                    Tab(
                      text: "EV ",
                    ),
                  ],
                ),
              )),
        ),

        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height*0.68,
          child: TabBarView(
            controller: tabController,
            children: [
              PhotoPreviousPage(),
              DrivingPreviousPage(),
              EvPreviousPage(),
            ],
          ),
        ),
      ],
    );
  }
}
