import '../../Utils/colors.dart';
import '../../Utils/fontFamily.dart';
import 'package:flutter/material.dart';

class AddressTextUtils {
  TextField getCustomEditTextArea(
      {
        String hintValue = "",
        String helperText = "",
        String errorTextMsg = "",
        bool? validation,
        TextEditingController? textController,
        TextInputType keyboardType = TextInputType.text,
        TextStyle? textStyle,
        String? validationErrorMsg}) {
    TextField textField = TextField(
      controller: textController,
      cursorColor: borderColor,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
        hintText: hintValue,
        fillColor: kWhite,
        hintStyle: TextStyle(color: textLabelColor, fontFamily: poppinRegular,),
        focusColor: borderColor,
      ),
      style: TextStyle(color: borderColor, fontSize: 14),

    );
    return textField;
  }
}

