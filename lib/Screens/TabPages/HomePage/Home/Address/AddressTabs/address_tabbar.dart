import 'package:flutter/material.dart';
import '../../../../../../Model/HomePageModels/HomeTopWidgetModels/photography_model.dart';
import '../../../../../../Utils/colors.dart';
import 'billing_address_page.dart';
import 'home_address.dart';

class AddressTabBar extends StatefulWidget {
  final DatumPhotography? datumPhotography;
  final String? amount, myDate, myDay, selectedHours, selectedStartTime, selectedEndTime;
  final int? totalHoursInNumber;
  final double? hoursAmount, totalAmount;

  const AddressTabBar({Key? key,
    this.datumPhotography,
    this.selectedHours, this.myDate, this.myDay, this.totalHoursInNumber,
    this.hoursAmount, this.totalAmount, this.selectedStartTime, this.selectedEndTime,
    this.amount}): super(key: key);

  @override
  State<AddressTabBar> createState() => _AddressTabBarState();
}

abstract class TickerProvider {}

class _AddressTabBarState extends State<AddressTabBar> with TickerProviderStateMixin {

  mySelectedData(){
    print("carOriginalAmount1: ${widget.amount}");
    print("carDayDate1: ${widget.myDay} ${widget.myDate}");
    print("carMakersName1: ${widget.totalHoursInNumber}");
    print("carStartEndTime1: ${widget.selectedStartTime} ${widget.selectedEndTime}");
    print("carHours1: ${widget.selectedHours} ${widget.hoursAmount} ${widget.totalAmount}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySelectedData();
  }


  List<String> tabs = ["Home Address", "Billing Address",];

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
                padding: const EdgeInsets.all(05),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  indicatorColor: kWhite,
                  labelColor: kBlack,
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
            children: [
              const HomeAddressPage(),
              BillingAddressPage(
                datumPhotography: widget.datumPhotography,
                amount: widget.amount,
                selectedHours: widget.selectedHours,
                hoursAmount: widget.hoursAmount,
                totalAmount: widget.totalAmount,
                selectedStartTime: widget.selectedStartTime,
                selectedEndTime: widget.selectedEndTime,
                myDate: widget.myDate,
                myDay: widget.myDay,
                totalHoursInNumber: widget.totalHoursInNumber,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
