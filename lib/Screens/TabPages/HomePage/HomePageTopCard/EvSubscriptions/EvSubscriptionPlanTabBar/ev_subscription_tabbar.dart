import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import '12MonthsPlan/12_months_plan.dart';
import '24MonthsPlan/24_months_plan.dart';
import '36MonthsPlan/36_months_plan.dart';

class EvSubscriptionTabbarPage extends StatefulWidget {
  const EvSubscriptionTabbarPage({super.key});

  @override
  State<EvSubscriptionTabbarPage> createState() => _EvSubscriptionTabbarPageState();
}

abstract class TickerProvider {}

class _EvSubscriptionTabbarPageState extends State<EvSubscriptionTabbarPage>
    with TickerProviderStateMixin {
  List<String> tabs = ["12 Months", "24 Months", "36 Months"];
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
                  color: homeBgColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 09, horizontal: 0),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  indicatorColor: kWhite,
                  // isScrollable: true,
                  labelColor: kWhite,
                  labelStyle: TextStyle(fontSize: 12, fontFamily: poppinRegular),
                  unselectedLabelColor: kBlack,
                  tabs: const [
                    Tab(text: "12 Months"),
                    Tab(text: "24 Months"),
                    Tab(text: "36 Months"),
                  ],
                ),
              )),
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.14,
          child: TabBarView(
            controller: tabController,
            children: const [
              TwelveMonthsPlan(),
              TwentyFourMonthsPlan(),
              ThirtySixMonthsPlan(),
            ]
          ),
        ),
      ],
    );
  }
}
