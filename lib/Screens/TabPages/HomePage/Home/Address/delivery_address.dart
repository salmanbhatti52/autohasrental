import 'package:flutter/material.dart';
import '../../../../../Model/HomePageModels/HomeTopWidgetModels/photography_model.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/fontFamily.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';
import 'AddressTabs/address_tabbar.dart';

class DeliveryAddress extends StatefulWidget {
  final DatumPhotography? myDatumPhotography;
  final String? amount, myDate, myDay, discountedAmount, selectedHoursInString, selectedStartTime, selectedEndTime;
  final int? totalHoursInNumber;
  final double? hoursAmount, totalAmount;
  const DeliveryAddress({Key? key,
    this.myDatumPhotography, this.selectedHoursInString, this.totalHoursInNumber,
    this.myDate, this.hoursAmount,
    this.totalAmount, this.selectedStartTime, this.selectedEndTime, this.myDay,
    this.amount,  this.discountedAmount}) : super(key: key);

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {

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
        // title: "BMW 2 series, ", subtitle: "2022",
        title: "${widget.myDatumPhotography!.vehicalName}, ", subtitle: "${widget.myDatumPhotography!.year}",
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
                datumPhotography: widget.myDatumPhotography,
                amount: widget.amount,
                selectedHours: widget.selectedHoursInString,
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
      ),
    );
  }
}
