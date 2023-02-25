import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import '../../../../../../../Model/HomePageModels/HomeTopWidgetModels/ev_cars_model.dart';
import 'ev_billing_address.dart';
import 'ev_home_address.dart';

class EvAddressTabBar extends StatefulWidget {
  // final Datum? myDatum;
  final String? mySelectedTabMonth, mySelectedTabPrice;
  final double? totalAmount;

  final String? carName, carImage, carYear, carPrice, carStatus,
      carColorName, carModelName, carMakesName, carMakesImage,
      carRating, carOwnerImage, carOwnerName, discountPercentage;
  final int? carId, carOwnerId;
  final double? carDiscountPrice;

  const EvAddressTabBar({Key? key, /*this.myDatum,*/ this.totalAmount,
    this.carName,
    this.carColorName, this.carModelName, this.discountPercentage, this.carDiscountPrice,
    this.carImage, this.carYear, this.carMakesImage, this.carStatus, this.carMakesName,
    this.carId, this.carPrice, this.carRating, this.carOwnerId, this.carOwnerImage, this.carOwnerName,
    this.mySelectedTabMonth, this.mySelectedTabPrice}): super(key: key);

  @override
  State<EvAddressTabBar> createState() => _EvAddressTabBarState();
}

abstract class TickerProvider {}

class _EvAddressTabBarState extends State<EvAddressTabBar> with TickerProviderStateMixin {

  // mySelectedData(){
  //   print("carDayDate: ${widget.selectedDate}");
  //   print("carTotalPrice: ${widget.totalPrice}");
  //   print("carStartEndTime: ${widget.startTime} ${widget.endTime}");
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // mySelectedData();
  }


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
              const EvHomeAddress(),
              EvBillingAddress(
                // myDatum: widget.myDatum,
                mySelectedTabMonth: widget.mySelectedTabMonth,
                mySelectedTabPrice: widget.mySelectedTabPrice,
                totalAmount: widget.totalAmount,

                carName: widget.carName,
                carImage: widget.carImage,
                carYear: widget.carYear,
                carPrice: widget.carPrice,
                carDiscountPrice: widget.carDiscountPrice,
                carRating: widget.carRating,
                carColorName: widget.carColorName,
                discountPercentage: widget.discountPercentage,
                carStatus: widget.carStatus,
                carId: widget.carId,
                carOwnerId: widget.carOwnerId,
                carMakesName: widget.carMakesName,
                carModelName: widget.carModelName,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
