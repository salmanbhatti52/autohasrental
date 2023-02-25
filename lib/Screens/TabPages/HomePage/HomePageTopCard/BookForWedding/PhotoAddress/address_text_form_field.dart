import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';

class AddressTextFormField {
  TextFormField getCustomEditTextArea(
      {String labelValue = "",
        String hintValue = "",
        String helperText = "",
        bool? validation,
        TextEditingController? controller,
        TextInputType keyboardType = TextInputType.text,
        TextStyle? textStyle,
        String? validationErrorMsg}) {
    TextFormField textFormField = TextFormField(
      keyboardType: keyboardType,
      style: textStyle,
      controller: controller,
      validator: (String? value) {
        if (validation!) {
          if (value!.isEmpty) {
            return validationErrorMsg;
          }
        }
      },
      decoration: InputDecoration(
          helperText: helperText,
          labelText: labelValue,
          hintText: hintValue,
          // labelStyle: textStyle,
          // hintStyle: const TextStyle(color: Color(0xff8D8D8D)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: kWhite)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: borderColor)
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: kWhite),
            borderRadius: BorderRadius.circular(30)
        ),
        // fillColor: Colors.green,
        labelStyle: TextStyle(color: textLabelColor),
        hintStyle: TextStyle(color: borderColor),
      ),
    );
    return textFormField;
  }
}