
import 'package:auto_haus_rental_app/Model/HomePageModels/HomeTopWidgetModels/driving_cars_model.dart';
import 'package:auto_haus_rental_app/Model/search_model.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';

import '../../../../../../../Model/HomePageModels/top_rented_cars_model.dart';

class SearchDrivingDesc extends StatefulWidget {
  final SearchDatum? searchDatum;
  const SearchDrivingDesc({super.key, this.searchDatum});

  @override
  State<SearchDrivingDesc> createState() => _SearchDrivingDescState();
}

class _SearchDrivingDescState extends State<SearchDrivingDesc> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Text("${widget.searchDatum?.description}",
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
