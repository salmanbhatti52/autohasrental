
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/top_rented_cars_model.dart';

class DrivingDesc extends StatefulWidget {
  final DatumTopRented? datumTopRented;
  DrivingDesc({super.key, this.datumTopRented});

  @override
  State<DrivingDesc> createState() => _DrivingDescState();
}

class _DrivingDescState extends State<DrivingDesc> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 5),
          child: HtmlWidget('${widget.datumTopRented?.description}'),
        ),
      ],
    );
  }
}
