
import 'package:flutter/material.dart';
import 'EvAddressTabBar/ev_address_tabbar.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';

class EvDeliveryAddress extends StatefulWidget {

  final String? mySelectedTabMonth, mySelectedTabPrice;
  final String? totalAmount , setupCost;

  final String? carName, carImage, carYear, carPrice, carStatus, carRating,
      favouriteStatus, carColorName, carModelName, carMakesName, carOwnerName,
      carOwnerImage, evEndDate, discountPercentage, evStartDate, carMakesImage;
  final int? carId, carOwnerId, mileagePlanID;
  final String? carDiscountPrice;
  final double?  serviceFee;

  EvDeliveryAddress({Key? key, this.setupCost, this.mileagePlanID, this.totalAmount, this.carName, this.evStartDate,
    this.evEndDate, this.favouriteStatus, this.carColorName, this.carId,
    this.carModelName, this.discountPercentage, this.carDiscountPrice, this.serviceFee,
    this.carImage, this.carYear, this.carMakesImage, this.carStatus, this.carMakesName,
    this.carPrice, this.carRating, this.carOwnerId, this.carOwnerImage, this.carOwnerName,
    this.mySelectedTabMonth, this.mySelectedTabPrice}) : super(key: key);

  @override
  State<EvDeliveryAddress> createState() => _EvDeliveryAddressState();
}

class _EvDeliveryAddressState extends State<EvDeliveryAddress> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('xsdasc: ${widget.evEndDate} ');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: MyAppBarSingleImageWithText(
        title: "${widget.carName}, ", subtitle: "${widget.carYear}",
        backImage: "assets/messages_images/Back.png"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                color: Colors.transparent,
                child: Text("Our concierge will pick-up and drop-off the car right at your front doorstep.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontFamily: poppinRegular, color: borderColor)),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              EvAddressTabBar(
                setupCost: widget.setupCost,
                mySelectedTabMonth: widget.mySelectedTabMonth,
                mySelectedTabPrice: widget.mySelectedTabPrice,
                mileagePlanID: widget.mileagePlanID,
                totalAmount: widget.totalAmount,
                favouriteStatus: widget.favouriteStatus,
                evStartDate: widget.evStartDate,
                evEndDate: widget.evEndDate,
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
      ),
    );
  }
}
