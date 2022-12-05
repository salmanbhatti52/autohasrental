import 'package:flutter/material.dart';
import '../../../../../../Widget/colors.dart';
import 'billing_address_page.dart';
import 'home_address.dart';

class AddressTabBar extends StatefulWidget {
  const AddressTabBar({super.key});

  @override
  State<AddressTabBar> createState() => _AddressTabBarState();
}

abstract class TickerProvider {}

class _AddressTabBarState extends State<AddressTabBar> with TickerProviderStateMixin {
  List<String> tabs = ["Home Address", "Billing Address",];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              decoration: BoxDecoration(
                  color: const Color(0xffd4dce1),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  indicatorColor: kWhite,
                  labelColor: kBlack,
                  labelPadding: const EdgeInsets.only(left: 30, right: 30),
                  labelStyle: const TextStyle(fontSize: 12),
                  unselectedLabelColor: kBlack,
                  tabs: const [
                    Tab(
                      text: "Home Address",
                    ),
                    Tab(
                      text: "Billing Address",
                    ),

                  ],
                ),
              )),
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height*0.8,
          child: TabBarView(
            controller: tabController,
            children: const [
              HomeAddressPage(),
              BillingAddressPage(),
              // Description(),
            ],
          ),
        ),
      ],
    );
  }
}
