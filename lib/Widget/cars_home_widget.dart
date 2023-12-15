import 'package:flutter/material.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';

Widget originalPriceWidget(originalPrice) {
  return Padding(
    padding: EdgeInsets.only(top: 04),
    child: Text(
      "$originalPrice",
      textAlign: TextAlign.left,
      style: TextStyle(
        color: kRed,
        decoration: TextDecoration.lineThrough,
        fontSize: 8,
        fontFamily: poppinLight,
      ),
    ),
  );
}
