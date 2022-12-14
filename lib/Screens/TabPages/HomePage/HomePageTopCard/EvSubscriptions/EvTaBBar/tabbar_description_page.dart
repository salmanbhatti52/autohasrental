import 'package:flutter/material.dart';
import '../../../../../../Utils/colors.dart';
import '../../../../../../Utils/fontFamily.dart';
import 'description_page/description.dart';
import 'feature_page/features.dart';
import 'rating_page.dart/rating.dart';

class TabbarCarDescription extends StatefulWidget {
  const TabbarCarDescription({super.key});

  @override
  State<TabbarCarDescription> createState() => _TabbarCarDescriptionState();
}

abstract class TickerProvider {}

class _TabbarCarDescriptionState extends State<TabbarCarDescription>
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
          height: MediaQuery.of(context).size.height * 0.28,
          child: TabBarView(
            controller: tabController,
            children: const [
              Description(),
              Features(),
              Rating(),
            ]
          ),
        ),
      ],
    );
  }
}
