import 'package:flutter/material.dart';
import '../../../../../../../../../Model/BookingModels/Previous/Driving/driving_previous_model.dart';

class DrivingDescription extends StatefulWidget {
  final DatumDrivingPrevious? datumP;
  const DrivingDescription({super.key, this.datumP});

  @override
  State<DrivingDescription> createState() => _DrivingDescriptionState();
}

class _DrivingDescriptionState extends State<DrivingDescription> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Text(
            "${widget.datumP!.carsDetails!.description}",
            style: const TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
