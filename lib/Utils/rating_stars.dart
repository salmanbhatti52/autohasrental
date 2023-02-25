

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'colors.dart';

Widget showRatingStars( ratingValue){
  return RatingBar(
      initialRating: ratingValue,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      minRating: 0,
      itemSize: 18.0,
      ignoreGestures: true,
      ratingWidget: RatingWidget(
          full: Icon(Icons.star, color: borderColor),
          half: Icon(
            Icons.star_half,
            color: borderColor,
          ),
          empty: Icon(
            Icons.star_outline,
            color: borderColor,
          )),

      onRatingUpdate: (value) {
        // setState(() {
        // photoPreviousObject.data![index].carsDetails!.rating = "$value";
        // print("ratingValue ${photoPreviousObject.data![index].carsDetails!.rating}");
        // });
      });
}