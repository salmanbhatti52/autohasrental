import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import '../../../../../../../Model/HomePageModels/HomeTopWidgetModels/photography_model.dart';
import 'photo_billing_address.dart';
import 'photo_home_address.dart';

class PhotoAddressTabBar extends StatefulWidget {
  // final DatumPhotography? datumPhotography;
  final String? amount, myDate, myDay, selectedHours, selectedStartTime, selectedEndTime;
  final int? totalHoursInNumber;
  final double? hoursAmount, totalAmount;
  final String? carName, carImage, carYear, carPrice, favouriteStatus,
      carColorName, carModelName, carMakesName, carMakesImage,
      carRating, carOwnerImage, carOwnerName, discountPercentage, carDiscountPrice;
  final int? carId, carOwnerId;

  const PhotoAddressTabBar({Key? key,
    // this.datumPhotography,
    this.selectedHours, this.myDate, this.myDay, this.totalHoursInNumber,
    this.hoursAmount, this.totalAmount, this.selectedStartTime, this.selectedEndTime,
    this.amount,
    this.carName, this.carColorName, this.carModelName, this.discountPercentage,
    this.carDiscountPrice, this.carImage, this.carYear, this.carMakesImage,
    this.favouriteStatus, this.carMakesName, this.carId, this.carPrice, this.carRating,
    this.carOwnerId, this.carOwnerImage, this.carOwnerName
  }): super(key: key);

  @override
  State<PhotoAddressTabBar> createState() => _PhotoAddressTabBarState();
}

abstract class TickerProvider {}

class _PhotoAddressTabBarState extends State<PhotoAddressTabBar> with TickerProviderStateMixin {

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
              const PhotoHomeAddress(),
              PhotoBillingAddress(
                // datumPhotography: widget.datumPhotography,
                amount: widget.amount,
                selectedHours: widget.selectedHours,
                hoursAmount: widget.hoursAmount,
                totalAmount: widget.totalAmount,
                selectedStartTime: widget.selectedStartTime,
                selectedEndTime: widget.selectedEndTime,
                myDate: widget.myDate,
                myDay: widget.myDay,
                totalHoursInNumber: widget.totalHoursInNumber,

                carName: widget.carName,
                carYear: widget.carYear,
                carId: widget.carId,
                carRating: widget.carRating,
                carColorName: widget.carColorName,
                carMakesName: widget.carMakesName,
                carModelName: widget.carModelName,
                carImage: widget.carImage,
                carMakesImage: widget.carMakesImage,
                favouriteStatus: widget.favouriteStatus,
                discountPercentage: widget.discountPercentage,
                carDiscountPrice: widget.carDiscountPrice,
                carPrice: widget.carPrice,
                carOwnerImage: widget.carOwnerImage,
                carOwnerName: widget.carOwnerName,
                carOwnerId: widget.carOwnerId,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
