
import 'package:flutter/material.dart';
import '../../Utils/colors.dart';
import '../../Utils/fontFamily.dart';

class ChangePasswordEditTextUtils {
  TextField getChangePasswordTextField(
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
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 10, 0),
        border: InputBorder.none,
        // enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(30.0),
        //     borderSide: BorderSide(color: textLabelColor)
        // ),
        // border: OutlineInputBorder(
        //     borderSide: BorderSide(color: textLabelColor),
        //     borderRadius: BorderRadius.circular(30)
        // ),
        // focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(30.0),
        //     borderSide: BorderSide(color: borderColor)
        // ),
        hintText: hintValue,
        hintStyle: TextStyle(color: textLabelColor, fontFamily: poppinRegular,letterSpacing: 3,),
        focusColor: borderColor,
        suffixIcon: suffixIcon,
        // errorText: errorTextMsg,
      ),
      style: TextStyle(color: borderColor, fontSize: 14, fontFamily: poppinRegular),
    );
    return textField;
  }
}

