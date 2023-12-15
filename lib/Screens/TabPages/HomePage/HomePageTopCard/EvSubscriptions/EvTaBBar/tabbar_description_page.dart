import 'feature_page/features.dart';
import 'package:flutter/material.dart';
import 'rating_page.dart/ev_rating.dart';
import 'description_page/description.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';

class TabbarCarDescription extends StatefulWidget {
  final String? myDescription, myRating, myComment;

  final String? featureSuv, featuresSeats, featuresSpeed, featuresAutomatic, featuresDoors,
      featuresElectric, featuresEngine_capacity, featuresFuelCapacity, featuresMeterReading, featuresNewCars;
   TabbarCarDescription({super.key, this.myDescription, this.myRating, this.myComment,

     this.featureSuv, this.featuresSeats, this.featuresSpeed,
     this.featuresAutomatic, this.featuresDoors, this.featuresElectric, this.featuresEngine_capacity,
     this.featuresFuelCapacity, this.featuresMeterReading, this.featuresNewCars
   });

  @override
  State<TabbarCarDescription> createState() => _TabbarCarDescriptionState();
}

abstract class TickerProvider {}

class _TabbarCarDescriptionState extends State<TabbarCarDescription>
    with TickerProviderStateMixin {
  List<String> tabs = ["Description", "Features"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 05),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              decoration: BoxDecoration(
                  color: Color(0xffd4dce1),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  indicatorColor: kWhite,
                  // isScrollable: true,
                  labelColor: kBlack,
                  labelStyle: TextStyle(fontSize: 12, fontFamily: poppinRegular),
                  unselectedLabelColor: kBlack,
                  tabs: [
                    Tab(text: "Description"),
                    Tab(text: "Features"),
                  ],
                ),
              )),
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.28,
          child: TabBarView(
            controller: tabController,
            children: [
              Description(carDescription: widget.myDescription),
              Features(
                featureSuv: widget.featureSuv,
                featuresDoors: widget.featuresDoors,
                featuresSeats: widget.featuresSeats,
                featuresAutomatic: widget.featuresAutomatic,
                featuresSpeed: widget.featuresSpeed,
                featuresElectric: widget.featuresElectric,
                featuresEngine_capacity: widget.featuresEngine_capacity,
                featuresMeterReading: widget.featuresMeterReading,
                featuresNewCars: widget.featuresNewCars,
                featuresFuelCapacity: widget.featuresFuelCapacity,
              ),
              // EvRating(),
            ]
          ),
        ),
      ],
    );
  }
}
