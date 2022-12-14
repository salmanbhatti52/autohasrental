import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../../Utils/fontFamily.dart';

textWidget(myText){
  return Text(myText, style: TextStyle(
      color: kWhite, fontFamily: poppinSemiBold, fontSize: 14));
}

changePasswordTextWidget(myText){
  return Text(myText, textAlign: TextAlign.left, style: TextStyle(
      color: kBlack, fontFamily: poppinSemiBold, fontSize: 14));


}

paymentTextWidget(myText){
  return Text(myText, textAlign: TextAlign.left, style: TextStyle(
      color: kBlack, fontFamily: poppinSemiBold, fontSize: 14)
  );
}

