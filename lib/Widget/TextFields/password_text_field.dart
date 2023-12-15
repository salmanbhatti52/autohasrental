import '../../Utils/colors.dart';
import '../../Utils/fontFamily.dart';
import 'package:flutter/material.dart';

class PasswordEditTextUtils {
  TextField getPasswordTextField(
      {String labelValue = "",
        String hintValue = "",
        String helperText = "",
        bool? validation,
        IconButton? suffixIcon,
        bool obscureText = true,
        TextEditingController? textController,
        TextInputType keyboardType = TextInputType.text,
        TextStyle? textStyle,
        String? validationErrorMsg}) {
    TextField textField = TextField(
      controller: textController,
      cursorColor: borderColor,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 10, 0),
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
        hintStyle: TextStyle(color: textLabelColor, fontFamily: poppinRegular,letterSpacing: 3,),
        focusColor: borderColor,
        suffixIcon: suffixIcon,
      ),
      style: TextStyle(color: borderColor, fontSize: 14, fontFamily: poppinRegular),
    );
    return textField;
  }
}

