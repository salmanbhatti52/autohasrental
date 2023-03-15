import 'package:auto_haus_rental_app/Model/BookingModels/Upcoming/DrivingUpComing/driving_upcoming_model.dart';
import 'package:flutter/material.dart';

class DrivingUpcomingDescription extends StatefulWidget {
  final DrivingDatum? drivingDatum;
  const DrivingUpcomingDescription({super.key, this.drivingDatum});

  @override
  State<DrivingUpcomingDescription> createState() => _DrivingUpcomingDescriptionState();
}

class _DrivingUpcomingDescriptionState extends State<DrivingUpcomingDescription> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Text(
            "${widget.drivingDatum!.carsDetails!.description}",
            style: const TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
