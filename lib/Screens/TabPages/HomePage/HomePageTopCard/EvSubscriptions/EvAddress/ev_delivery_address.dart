import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import '../../../../MyAppBarHeader/app_bar_header.dart';
import 'EvAddressTabBar/ev_address_tabbar.dart';

class EvDeliveryAddress extends StatefulWidget {

  final String? mySelectedTabMonth, mySelectedTabPrice;
  final double? totalAmount;

  final String? carName, carImage, carYear, carPrice, carStatus,
      carColorName, carModelName, carMakesName, carMakesImage,
      carRating, carOwnerImage, carOwnerName, discountPercentage, evStartDate, evEndDate;
  final int? carId, carOwnerId;
  final double? carDiscountPrice;

  EvDeliveryAddress({Key? key, this.totalAmount, this.carName, this.evStartDate, this.evEndDate,
    this.carColorName, this.carModelName, this.discountPercentage, this.carDiscountPrice,
    this.carImage, this.carYear, this.carMakesImage, this.carStatus, this.carMakesName,
    this.carId, this.carPrice, this.carRating, this.carOwnerId, this.carOwnerImage, this.carOwnerName,

    this.mySelectedTabMonth, this.mySelectedTabPrice}) : super(key: key);

  @override
  State<EvDeliveryAddress> createState() => _EvDeliveryAddressState();
}

class _EvDeliveryAddressState extends State<EvDeliveryAddress> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                // myDatum: widget.evDatum,
                mySelectedTabMonth: widget.mySelectedTabMonth,
                mySelectedTabPrice: widget.mySelectedTabPrice,
                totalAmount: widget.totalAmount,

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
                // carName: widget.carName,
                // carYear: widget.carYear,
                // carModel: widget.carModel,
                // carImage: widget.carImage,
                // discountedAmount: widget.discountedAmount,
                // amount: widget.amount,
                // carRating: widget.carRating,
                // discountPercentage: widget.discountPercentage,
                // selectedHours: widget.selectedHoursInString,
                // hoursAmount: widget.hoursAmount,
                // totalAmount: widget.totalAmount,
                // carMakerName: widget.carMakerName,
                // selectedStartTime: widget.selectedStartTime,
                // selectedEndTime: widget.selectedEndTime,
                // myDate: widget.myDate,
                // myDay: widget.myDay,
                // totalHoursInNumber: widget.totalHoursInNumber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
