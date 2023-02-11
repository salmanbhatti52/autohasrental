import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import '../../../../../../Model/HomePageModels/HomeTopWidgetModels/ev_cars_model.dart';
import '../../../../MyAppBarHeader/app_bar_header.dart';
import 'EvAddressTabBar/ev_address_tabbar.dart';

class EvDeliveryAddress extends StatefulWidget {
  final Datum? evDatum;
  final String? mySelectedTabMonth, mySelectedTabPrice;
  final double? totalAmount;

  const EvDeliveryAddress({Key? key, this.evDatum, this.totalAmount,
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

              EvAddressTabBar(
                myDatum: widget.evDatum,
                mySelectedTabMonth: widget.mySelectedTabMonth,
                mySelectedTabPrice: widget.mySelectedTabPrice,
                totalAmount: widget.totalAmount,
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
