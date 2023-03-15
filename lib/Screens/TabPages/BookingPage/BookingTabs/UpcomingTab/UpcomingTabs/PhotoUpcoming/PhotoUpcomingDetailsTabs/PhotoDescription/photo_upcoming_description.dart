import 'package:flutter/material.dart';

import '../../../../../../../../../Model/BookingModels/Upcoming/Photography/photo_upcoming_model.dart';

class PhotoUpcomingDescription extends StatefulWidget {
  final PhotoDatum? datumUpcoming;
  const PhotoUpcomingDescription({super.key, this.datumUpcoming});

  @override
  State<PhotoUpcomingDescription> createState() => _PhotoUpcomingDescriptionState();
}

class _PhotoUpcomingDescriptionState extends State<PhotoUpcomingDescription> {

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
