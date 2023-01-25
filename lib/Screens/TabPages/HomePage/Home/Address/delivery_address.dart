import 'package:flutter/material.dart';

import '../../../../../Utils/colors.dart';
import '../../../../../Utils/fontFamily.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';
import 'AddressTabs/address_tabbar.dart';

class DeliveryAddress extends StatefulWidget {
  final String? carImage, discountPercentage, carName, myDate, myDay, discountedAmount,
      carModel, amount, carRating, selectedHoursInString, carMakerName,
  selectedStartTime, selectedEndTime;
  final int? carYear, totalHoursInNumber;
  final double? hoursAmount, totalAmount;
  const DeliveryAddress({Key? key, this.carImage, this.carName, this.carModel,
    this.totalHoursInNumber, this.carYear, this.discountPercentage,
    this.carMakerName, this.selectedHoursInString, this.myDate, this.hoursAmount,
    this.totalAmount, this.selectedStartTime, this.selectedEndTime, this.myDay,
    this.amount, this.carRating, this.discountedAmount}) : super(key: key);

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {

  mySelectedData(){
    print("carName: ${widget.carName}");
    print("carImage: ${widget.carImage}");
    print("carDiscount: ${widget.discountPercentage}");
    print("carModel: ${widget.carModel}");
    print("carYear: ${widget.carYear}");
    print("carOriginalAmount: ${widget.discountedAmount}");
    print("carDiscountAmount: ${widget.amount}");
    print("carRatings: ${widget.carRating}");
    print("carDayDate: ${widget.myDay} ${widget.myDate}");
    print("carMakersName: ${widget.carMakerName} ${widget.totalHoursInNumber}");
    print("carStartEndTime: ${widget.selectedStartTime} ${widget.selectedEndTime}");
    print("carRatings: ${widget.selectedHoursInString} ${widget.hoursAmount} ${widget.totalAmount}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySelectedData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarSingleImageWithText(
        title: "BMW 2 series, ", subtitle: "2022",
        backImage: "assets/messages_images/Back.png"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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

              AddressTabBar(
                carName: widget.carName,
                carYear: widget.carYear,
                carModel: widget.carModel,
                carImage: widget.carImage,
                discountedAmount: widget.discountedAmount,
                amount: widget.amount,
                carRating: widget.carRating,
                discountPercentage: widget.discountPercentage,
                selectedHours: widget.selectedHoursInString,
                hoursAmount: widget.hoursAmount,
                totalAmount: widget.totalAmount,
                carMakerName: widget.carMakerName,
                selectedStartTime: widget.selectedStartTime,
                selectedEndTime: widget.selectedEndTime,

                myDate: widget.myDate,
                myDay: widget.myDay,
                totalHoursInNumber: widget.totalHoursInNumber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
