import 'package:auto_haus_rental_app/Model/BookingModels/Upcoming/DrivingUpComing/driving_upcoming_model.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'DrivingUpcomingDescription/driving_upcoming_description.dart';
import 'EvFeatures/upcoming_features_details.dart';
import 'UpcomingRatings/upcoming_rating_details.dart';

class DrivingUpcomingTabBar extends StatefulWidget {
  final DrivingDatum? drivingDatum;
  const DrivingUpcomingTabBar({super.key, this.drivingDatum});

  @override
  State<DrivingUpcomingTabBar> createState() => _DrivingUpcomingTabBarState();
}

abstract class TickerProvider {}

class _DrivingUpcomingTabBarState extends State<DrivingUpcomingTabBar>
    with TickerProviderStateMixin {
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
              DrivingUpcomingDescription(
              drivingDatum: widget.drivingDatum,
              ),
              const UpComingFeaturesDetails(),
              UpcomingRatingDetails(
                drivingDatum: widget.drivingDatum,
              )
            ],
          ),
        ),
      ],
    );
  }
}
