
import 'package:auto_haus_rental_app/Model/HomePageModels/HomeTopWidgetModels/driving_cars_model.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';

class DrivingDescription extends StatefulWidget {
  final DatumDrivingTopCard? datumTopCard;
  const DrivingDescription({super.key, this.datumTopCard});

  @override
  State<DrivingDescription> createState() => _DrivingDescriptionState();
}

class _DrivingDescriptionState extends State<DrivingDescription> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Text(
            "${widget.datumTopCard!.description}",
            style: TextStyle(
                fontSize: 12,
                fontFamily: poppinRegular,
                color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
