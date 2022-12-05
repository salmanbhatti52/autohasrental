import 'package:flutter/material.dart';

import '../../../../../../../Widget/colors.dart';

Widget featuretext(text1, text2, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Text(
          text1,
          style: const TextStyle(fontSize: 30, height: 0.8),
        ), //bullet text
        const SizedBox(width: 10), //space between bullet and text
        Expanded(
          child: Text(
            text2,
            style: TextStyle(
              fontSize: 12,
              color: kBlack,
              height: 0.8,
            ),
          ), //text
        ),
      ],
    ),
  );
}
