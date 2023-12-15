import 'package:flutter/material.dart';
import '../../../../Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';

textWidget(myText) {
  return Text(
    myText,
    textAlign: TextAlign.left,
    style: TextStyle(
      color: kWhite,
      fontFamily: poppinSemiBold,
      fontSize: 14,
    ),
  );
}

textWidgetBlack(myText) {
  return Text(
    myText,
    textAlign: TextAlign.left,
    style: TextStyle(
      color: kBlack,
      fontFamily: poppinSemiBold,
      fontSize: 14,
    ),
  );
}
