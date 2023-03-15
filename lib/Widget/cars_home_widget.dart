import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';

Widget originalPriceWidget(originalPrice){
  return Padding(
    padding: const EdgeInsets.only(top: 04),
    child: Text("$originalPrice",
        textAlign: TextAlign.left, style: TextStyle(
            color: kRed, decoration: TextDecoration.lineThrough,
            fontSize: 8, fontFamily: poppinLight)),
  );
}

Widget discountedPriceWidget(price, typeText){
  return  Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 04),
        child: Text("$price", textAlign: TextAlign.left, style: TextStyle(
                fontSize: 12, fontFamily: poppinBold, color: borderColor)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(typeText, textAlign: TextAlign.left, style: TextStyle(
            color: borderColor, fontSize: 8, fontFamily: poppinSemiBold)),
      ),
    ],
  );
}

Widget verifiedDealerText(){
  return Row(
    children: [
      Image.asset("assets/car_bookings_images/promoted.png"),
      const SizedBox(width: 5),
      Text("Verified Dealer", textAlign: TextAlign.left,
          style: TextStyle(color: textLabelColor,
              fontSize: 10, fontFamily: poppinRegular)),
      const SizedBox(width: 05),
      Container(
        height: 15, width: 35,
        decoration: BoxDecoration(
            color: kBlack,
            borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text("New",  textAlign: TextAlign.left,
            style: TextStyle(color: kWhite,
                fontSize: 8, fontFamily: poppinRegular)),
        ),
      ),
    ],
  );
}