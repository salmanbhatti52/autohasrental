import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import '../../../../../../Model/HomePageModels/HomeTopWidgetModels/driving_cars_model.dart';
import '../../../../MyAppBarHeader/app_bar_header.dart';
import 'AddressTabsDriving/address_tabbar_experience.dart';


class DeliveryAddressExperience extends StatefulWidget {
  final String? startTime, endTime, selectedDate;
  final double? totalPrice, selectedSlotPrice;
  final Datum? myDatum;
  const DeliveryAddressExperience({Key? key, this.selectedDate,
    this.totalPrice, this.selectedSlotPrice,
    this.myDatum, this.startTime, this.endTime}) : super(key: key);

  @override
  State<DeliveryAddressExperience> createState() => _DeliveryAddressExperienceState();
}

class _DeliveryAddressExperienceState extends State<DeliveryAddressExperience> {

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

              AddressTabBarExperience(
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
