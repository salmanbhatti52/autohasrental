import 'package:flutter/material.dart';
import 'colors.dart';
import 'fontFamily.dart';

Widget loginButton(buttonText, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width*  0.7,
        decoration: BoxDecoration(
            color: borderColor, borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(buttonText, textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,
                  fontFamily: poppinRegular, fontSize: 18)),
        ),
      ),
    ),
  );
}

Widget filterButton1(buttonText, context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.04,
    width: MediaQuery.of(context).size.width * 0.28,
    decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xff8d8d8d))),
    child: Center(
      child: Text(buttonText, textAlign: TextAlign.left,
          style: TextStyle(
              color: const Color(0xff8d8d8d), fontFamily: poppinRegular, fontSize: 12)),
    ),
  );
}

Widget filterButton2(buttonText, context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.04,
    width: MediaQuery.of(context).size.width * 0.28,
    decoration: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white)),
    child: Center(
      child: Text(buttonText,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'Poppins', fontSize: 12)),
    ),
  );
}

Widget filterButton3(buttonText, context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.04,
    width: MediaQuery.of(context).size.width * 0.35,
    decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xff8d8d8d))),
    child: Center(
      child: Text(buttonText,
          style: const TextStyle(
              color: Color(0xff8d8d8d), fontFamily: 'Poppins', fontSize: 12)),
    ),
  );
}
