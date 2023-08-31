import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../../Utils/fontFamily.dart';
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
  // List<String> tabs = ["Photography", "Driving ", "EV "];
  List<String> tabs = ["EV"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 1, vsync: this);

    return Column(
      children: [
        Padding(
          // padding: EdgeInsets.only(left: 0, right: 05, top: 05),
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.3, vertical: 5),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              decoration: BoxDecoration(
                  color: Color(0xffd4dce1),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  indicatorColor: kWhite,
                  labelColor: kBlack,
                  labelStyle: TextStyle(fontSize: 14, fontFamily: poppinRegular),
                  unselectedLabelColor: kBlack,
                  tabs: [
                    // Tab(
                    //   text: "Photography",
                    // ),
                    // Tab(
                    //   text: "Driving ",
                    // ),
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
            physics: BouncingScrollPhysics(),
            children: [
              // PhotoPreviousPage(),
              // DrivingPreviousPage(),
              EvPreviousPage(),
            ],
          ),
        ),
      ],
    );
  }
}
