import 'feature_page/features.dart';
import 'package:flutter/material.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';

class TabbarCarDescription extends StatefulWidget {
  final String? myDescription, myRating, myComment;

  final String? featureSuv, featuresSeats, featuresSpeed, featuresAutomatic, featuresDoors,
      featuresElectric, featuresEngine_capacity, featuresFuelCapacity, featuresMeterReading, featuresNewCars;
   TabbarCarDescription({super.key, this.myDescription, this.myRating, this.myComment,

     this.featureSuv, this.featuresSeats, this.featuresSpeed,
     this.featuresAutomatic, this.featuresDoors, this.featuresElectric, this.featuresEngine_capacity,
     this.featuresFuelCapacity, this.featuresMeterReading, this.featuresNewCars
   });

  @override
  State<TabbarCarDescription> createState() => _TabbarCarDescriptionState();
}

class _TabbarCarDescriptionState extends State<TabbarCarDescription>{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text("Features", style: TextStyle(fontSize: 16, color: kBlack, fontWeight: FontWeight.bold, fontFamily: poppinRegular),),
            ),),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Features(
                featureSuv: widget.featureSuv,
                featuresDoors: widget.featuresDoors,
                featuresSeats: widget.featuresSeats,
                featuresAutomatic: widget.featuresAutomatic,
                featuresSpeed: widget.featuresSpeed,
                featuresElectric: widget.featuresElectric,
                featuresEngine_capacity: widget.featuresEngine_capacity,
                featuresMeterReading: widget.featuresMeterReading,
                featuresNewCars: widget.featuresNewCars,
                featuresFuelCapacity: widget.featuresFuelCapacity,
              ),
        ),
      ],
    );
  }
}
