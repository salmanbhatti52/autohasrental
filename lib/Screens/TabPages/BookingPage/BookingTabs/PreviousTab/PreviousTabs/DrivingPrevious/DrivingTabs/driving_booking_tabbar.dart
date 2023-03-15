import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../Model/BookingModels/Previous/Driving/driving_previous_model.dart';
import 'DrivingDescription/driving_description.dart';
import 'DrivingFeatures/features.dart';
import 'DrivingRatings/driving_rating_previous.dart';

class DrivingBookingTabbar extends StatefulWidget {
  final DatumDrivingPrevious? datumP;
  const DrivingBookingTabbar({super.key, this.datumP});

  @override
  State<DrivingBookingTabbar> createState() => _DrivingBookingTabbarState();
}

abstract class TickerProvider {}

class _DrivingBookingTabbarState extends State<DrivingBookingTabbar> with TickerProviderStateMixin {
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
          height: MediaQuery.of(context).size.height*0.4,
          child: TabBarView(
            controller: tabController,
            children: [
              DrivingDescription(
                datumP: widget.datumP,
              ),
              const DrivingFeaturesDetails(),
              DrivingRatingDetails(
               datumP: widget.datumP,
              )
            ],
          ),
        ),
      ],
    );
  }
}
