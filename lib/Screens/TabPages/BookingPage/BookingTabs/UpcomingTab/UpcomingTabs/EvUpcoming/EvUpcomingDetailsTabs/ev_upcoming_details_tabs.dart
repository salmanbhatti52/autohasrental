import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../Model/BookingModels/Upcoming/EvUpComing/ev_upcoming_model.dart';
import '../../../../PreviousTab/PreviousTabs/DrivingPrevious/DrivingTabs/DrivingFeatures/features.dart';
import 'EvDescription/ev_upcoming_description.dart';
import 'EvRatings/ev_rating_details_upcoming.dart';

class EvUpcomingTabsPages extends StatefulWidget {
  final EvUpcomingDatum? datumUpcoming;
  const EvUpcomingTabsPages({super.key, this.datumUpcoming});

  @override
  State<EvUpcomingTabsPages> createState() => _EvUpcomingTabsPagesState();
}

abstract class TickerProvider {}

class _EvUpcomingTabsPagesState extends State<EvUpcomingTabsPages> with TickerProviderStateMixin {
  List<String> tabs = ["Description", "Features", "Ratings"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

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
                  controller: tabController,
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
          height: MediaQuery.of(context).size.height*0.45,
          child: TabBarView(
            controller: tabController,
            children: [
              EvUpcomingDescription(
                datumUpcoming: widget.datumUpcoming,
              ),
              const DrivingFeaturesDetails(),
              EvRatingDetailsUpcoming(
                datumUpcoming: widget.datumUpcoming,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
