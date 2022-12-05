
import 'package:flutter/cupertino.dart';

Widget carWidget( BuildContext context, IconData iconData, textDetails, Color containerColor){
  return Container(
    height: 100, width: 160,
    decoration: BoxDecoration(
        color: containerColor,
      borderRadius: BorderRadius.circular(15)
    ),
    child: Row(
      children: [
        Icon(iconData),
        Container(
            width: MediaQuery.of(context).size.width* 0.3,
            child: Text(textDetails))
      ],
    ),
  );
}