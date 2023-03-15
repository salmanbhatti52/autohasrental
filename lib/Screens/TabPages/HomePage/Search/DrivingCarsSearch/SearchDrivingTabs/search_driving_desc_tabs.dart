import 'package:auto_haus_rental_app/Model/search_model.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';

import '../../../TopRented/Driving_Home/DrivingDescTabs/Features/driving_features.dart';
import 'SearchDescription/search_driving_desc.dart';
import 'SearchRating/search_driving_rating.dart';

class SearchDrivingDescTabs extends StatefulWidget {
  final SearchDatum? searchDatum;
  const SearchDrivingDescTabs({super.key, this.searchDatum});

  @override
  State<SearchDrivingDescTabs> createState() => _SearchDrivingDescTabsState();
}

abstract class TickerProvider {}

class _SearchDrivingDescTabsState extends State<SearchDrivingDescTabs>
    with TickerProviderStateMixin {
  List<String> tabs = ["Description", "Features", "Ratings"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 05),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              decoration: BoxDecoration(
                  color: const Color(0xffd4dce1),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(5),
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
                  tabs: const [
                    Tab(text: "Description",),
                    Tab(text: "Features",),
                    Tab(text: "Ratings",),
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
              SearchDrivingDesc(searchDatum: widget.searchDatum),
              const DrivingFeatures(),
              SearchDrivingRating(searchDatum: widget.searchDatum),
            ]
          ),
        ),
      ],
    );
  }
}
