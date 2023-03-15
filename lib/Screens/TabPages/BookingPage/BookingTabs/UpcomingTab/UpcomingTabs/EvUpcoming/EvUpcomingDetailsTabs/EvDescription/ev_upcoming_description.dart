import 'package:flutter/material.dart';
import '../../../../../../../../../Model/BookingModels/Upcoming/EvUpComing/ev_upcoming_model.dart';

class EvUpcomingDescription extends StatefulWidget {
  final EvUpcomingDatum? datumUpcoming;
  const EvUpcomingDescription({super.key, this.datumUpcoming});

  @override
  State<EvUpcomingDescription> createState() => _EvUpcomingDescriptionState();
}

class _EvUpcomingDescriptionState extends State<EvUpcomingDescription> {

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
            "${widget.datumUpcoming!.carsDetails!.description}",
            style: const TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
