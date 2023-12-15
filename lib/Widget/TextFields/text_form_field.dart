import 'package:flutter/material.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';

class EditTextUtils {
  TextField getCustomEditTextArea({
        // String labelValue = "",
        String hintValue = "",
        String helperText = "",
        String errorTextMsg = "",
        bool? validation,
        TextEditingController? textController,
        TextInputType keyboardType = TextInputType.text,
        TextStyle? textStyle,
        // String? validationErrorLength,
        String? validationErrorMsg}) {
    TextField textField = TextField(
      controller: textController,
      cursorColor: borderColor,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: textLabelColor)
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: textLabelColor),
            borderRadius: BorderRadius.circular(30)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: borderColor)
        ),
        hintText: hintValue,
        hintStyle: TextStyle(color: textLabelColor, fontFamily: poppinRegular,),
        focusColor: borderColor,
      ),
      style: TextStyle(color: borderColor, fontSize: 14),

    );
    return textField;
  }
}

