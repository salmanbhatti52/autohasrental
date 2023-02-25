import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import '../../../../../../Model/HomePageModels/HomeTopWidgetModels/photography_model.dart';
import 'AddressTabs/photo_address_tabbar.dart';

class PhotoDeliveryAddress extends StatefulWidget {
  // final DatumPhotography? myDatumPhotography;
  final String? amount, myDate, myDay, discountedAmount,
      selectedHoursInString, selectedStartTime, selectedEndTime;
  final int? totalHoursInNumber;
  final double? hoursAmount, totalAmount;

  final String? carName, carImage, carYear, carPrice, favouriteStatus,
      carColorName, carModelName, carMakesName, carMakesImage,
      carRating, carOwnerImage, carOwnerName, discountPercentage, carDiscountPrice;
  final int? carId, carOwnerId;

  const PhotoDeliveryAddress({Key? key, /*this.myDatumPhotography,*/ this.selectedHoursInString,
    this.totalHoursInNumber, this.myDate, this.hoursAmount, this.totalAmount,
    this.selectedStartTime, this.selectedEndTime, this.myDay, this.amount,  this.discountedAmount,
    this.carName, this.carColorName, this.carModelName, this.discountPercentage,
    this.carDiscountPrice, this.carImage, this.carYear, this.carMakesImage,
    this.favouriteStatus, this.carMakesName, this.carId, this.carPrice, this.carRating,
    this.carOwnerId, this.carOwnerImage, this.carOwnerName}) : super(key: key);

  @override
  State<PhotoDeliveryAddress> createState() => _PhotoDeliveryAddressState();
}

class _PhotoDeliveryAddressState extends State<PhotoDeliveryAddress> {

  mySelectedData(){
    print("carOriginalAmount: ${widget.discountedAmount}");
    print("carDiscountAmount: ${widget.amount}");
    print("carDayDate: ${widget.myDay} ${widget.myDate}");
    print("carTotalHours: ${widget.totalHoursInNumber}");
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
      appBar: MyAppBarSingleImageWithText(
        title: "${widget.carName}, ", subtitle: "${widget.carYear}",
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

              PhotoAddressTabBar(
                // datumPhotography: widget.myDatumPhotography,
                amount: widget.amount,
                selectedHours: widget.selectedHoursInString,
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
      ),
    );
  }
}
