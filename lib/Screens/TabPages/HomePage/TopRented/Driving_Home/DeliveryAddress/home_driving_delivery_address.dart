import 'package:auto_haus_rental_app/Model/HomePageModels/top_rented_cars_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'AddressTab/driving_address_tabbar.dart';

class HomeDrivingDeliveryAddress extends StatefulWidget {
  final String? startTime, endTime, selectedDate;
  final double? totalPrice, selectedSlotPrice;
  final DatumTopRented? myDatum;
   HomeDrivingDeliveryAddress({Key? key, this.selectedDate,
    this.totalPrice, this.selectedSlotPrice,
    this.myDatum, this.startTime, this.endTime}) : super(key: key);

  @override
  State<HomeDrivingDeliveryAddress> createState() => _HomeDrivingDeliveryAddressState();
}

class _HomeDrivingDeliveryAddressState extends State<HomeDrivingDeliveryAddress> {

  mySelectedData(){
    print("carDayDate: ${widget.selectedDate}");
    print("carTotalPrice: ${widget.totalPrice}");
    print("carStartEndTime: ${widget.startTime} ${widget.endTime}");
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
      appBar:  MyAppBarSingleImageWithText(
        title: "BMW 2 series, ", subtitle: "2022",
        backImage: "assets/messages_images/Back.png"),
      body: SingleChildScrollView(
        physics:  BouncingScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10),
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

              DrivingAddressTabBar(
                selectedSlotPrice: widget.selectedSlotPrice,
                myDatum: widget.myDatum,
                startTime: widget.startTime,
                endTime: widget.endTime,
                selectedDate: widget.selectedDate,
                totalPrice: widget.totalPrice,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
