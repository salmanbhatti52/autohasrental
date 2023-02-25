import 'package:flutter/material.dart';

class DrivingDescription extends StatefulWidget {
  final String? carDescription, carMonth;
  const DrivingDescription({super.key, this.carDescription, this.carMonth});

  @override
  State<DrivingDescription> createState() => _DrivingDescriptionState();
}

class _DrivingDescriptionState extends State<DrivingDescription> {

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
            // "${widget.datumPrevious!.carsDetails!.description}",
            "${widget.carDescription}",
            style: const TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
