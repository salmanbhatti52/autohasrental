import 'package:flutter/material.dart';

import '../../../../../../../../../Model/BookingModels/Previous/EvPrevious/ev_previous_model.dart';
import '../../../../../../../../../Model/BookingModels/Previous/Photo/photo_previous_model.dart';

class PhotoDescription extends StatefulWidget {
  final DatumPhotoPrevious? datumP;
  const PhotoDescription({super.key, this.datumP});

  @override
  State<PhotoDescription> createState() => _PhotoDescriptionState();
}

class _PhotoDescriptionState extends State<PhotoDescription> {

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
            "${widget.datumP!.carsDetails!.description}",
            style: const TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
