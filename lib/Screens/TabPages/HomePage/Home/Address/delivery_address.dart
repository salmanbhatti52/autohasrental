import 'package:flutter/material.dart';

import '../../../../../Utils/colors.dart';
import '../../../../../Utils/fontFamily.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';
import 'AddressTabs/address_tabbar.dart';

class DeliveryAddress extends StatefulWidget {
  final String? carImage, discountPercentage, carName, carModel, amount, carRating;
  final int? carYear, discountedAmount;
  const DeliveryAddress({Key? key,
    this.carImage, this.discountPercentage,
    this.carName, this.carModel, this.carYear,
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
    print("carDiscountAmount: ${widget.discountedAmount}");
    print("carDiscountAmount: ${widget.amount}");
    print("carRatings: ${widget.carRating}");
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
                discountPercentage: widget.discountPercentage,

              ),
            ],
          ),
        ),
      ),
    );
  }
}
