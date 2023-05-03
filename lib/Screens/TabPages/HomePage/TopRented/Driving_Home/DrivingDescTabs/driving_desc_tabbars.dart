
import 'Rating/driving_rating.dart';
import 'description/driving_desc.dart';
import 'package:flutter/material.dart';
import 'Features/driving_features.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/top_rented_cars_model.dart';

class DrivingDescTabBars extends StatefulWidget {
  final DatumTopRented? datumTopRented;
  DrivingDescTabBars({super.key, this.datumTopRented});

  @override
  State<DrivingDescTabBars> createState() => _DrivingDescTabBarsState();
}

abstract class TickerProvider {}

class _DrivingDescTabBarsState extends State<DrivingDescTabBars>
    with TickerProviderStateMixin {
  List<String> tabs = ["Description", "Features", "Ratings"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

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
                padding:  EdgeInsets.all(5),
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
                    Tab(text: "Ratings"),
                  ],
                ),
              )),
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.2,
          child: TabBarView(
            controller: tabController,
            children: [
              DrivingDesc(datumTopRented: widget.datumTopRented),
              DrivingFeatures(datumTopRented: widget.datumTopRented),
              DrivingRating(datumTopRented: widget.datumTopRented),
            ]
          ),
        ),
      ],
    );
  }
}
