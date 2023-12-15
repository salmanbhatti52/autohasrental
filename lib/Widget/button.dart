import '../Utils/colors.dart';
import '../Utils/fontFamily.dart';
import 'package:flutter/material.dart';

Widget loginButton(buttonText, context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          color: borderColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: poppinRegular,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget paymentButton(buttonText, context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
            color: borderColor, borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: poppinRegular,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ),
  );
}
