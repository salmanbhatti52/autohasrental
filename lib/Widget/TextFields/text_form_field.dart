import 'package:flutter/material.dart';

import '../colors.dart';
import '../fontFamily.dart';

// class EditTextUtils {
//   TextFormField getCustomEditTextArea(
//       {String labelValue = "",
//         String hintValue = "",
//         String helperText = "",
//         bool? validation,
//         TextEditingController? controller,
//         TextInputType keyboardType = TextInputType.text,
//         TextStyle? textStyle,
//         String? validationErrorMsg}) {
//     TextFormField textFormField = TextFormField(
//       keyboardType: keyboardType,
//       style: textStyle,
//       controller: controller,
//       validator: (String? value) {
//         if (validation!) {
//           if (value!.isEmpty) {
//             return validationErrorMsg;
//           }
//         }
//       },
//       decoration: InputDecoration(
//           helperText: helperText,
//           labelText: labelValue,
//           hintText: hintValue,
//           // labelStyle: textStyle,
//           // hintStyle: const TextStyle(color: Color(0xff8D8D8D)),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30.0),
//             borderSide: BorderSide(color: textLabelColor)
//         ),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30.0),
//             borderSide: BorderSide(color: borderColor)
//         ),
//         border: OutlineInputBorder(
//             borderSide: BorderSide(color: textLabelColor),
//             borderRadius: BorderRadius.circular(30)
//         ),
//         labelStyle: TextStyle(color: textLabelColor),
//         hintStyle: TextStyle(color: borderColor),
//       ),
//     );
//     return textFormField;
//   }
// }

class EditTextUtils {
  TextField getCustomEditTextArea(
      {
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
        contentPadding: const EdgeInsets.only(top: 15, left: 20, bottom: 15),
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
        // errorText: errorTextMsg,
      ),
      style: TextStyle(color: borderColor, fontSize: 14),

    );
    return textField;
  }
}

