import 'package:flutter/material.dart';

import '../../../../../Widget/colors.dart';
import '../../../../../Widget/fontFamily.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';
import 'AddressTabs/address_tabbar.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({Key? key}) : super(key: key);

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const myAppBarSingleImage(
        title: "BMW 2 series, 2022", backImage: "assets/messages_images/Back.png",),
      body: SingleChildScrollView(
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
                  style: TextStyle(fontSize: 12, fontFamily: poppinRegular, color: borderColor),),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              const AddressTabBar(),

            ],
          ),
        ),
      ),
    );
  }
}
