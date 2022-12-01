
import 'package:flutter/material.dart';

import 'bookingsdetail/description_page/description.dart';
import 'bookingsdetail/feature_page/features.dart';
import 'bookingsdetail/rating_page.dart/rating.dart';
import 'colors.dart';

class TabbarBookingsDetails extends StatefulWidget {
  const TabbarBookingsDetails({super.key});

  @override
  State<TabbarBookingsDetails> createState() => _TabbarBookingsDetailsState();
}

abstract class TickerProvider {}

class _TabbarBookingsDetailsState extends State<TabbarBookingsDetails>
    with TickerProviderStateMixin {
  List<String> tabs = ["Description", "Features", "Ratings"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 3, vsync: this);

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
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
                      //indicatorSize: TabBarIndicatorSize,
                      indicatorColor: kWhite,

                      isScrollable: true,
                      labelColor: kBlack,
                      labelPadding: const EdgeInsets.only(left: 23, right: 22),
                      labelStyle: const TextStyle(fontSize: 14),
                      unselectedLabelColor: kBlack,
                      tabs: const [
                        Tab(
                          text: "Description",
                        ),
                        Tab(
                          text: "Features",
                        ),
                        Tab(
                          text: "Ratings",
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
                children: const [
                  DescriptionBookingsDetails(),
                  FeaturesBookingsDetails(),
                  RatingBookingsDetails()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
