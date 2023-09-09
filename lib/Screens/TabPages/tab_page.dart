
import 'package:flutter/material.dart';
import 'package:auto_haus_rental_app/Widget/bottom_bar.dart';

import '../../Model/filter_car_by_attribute_model.dart';

class TabBarPage extends StatefulWidget {
  FilterCarByAttributeModel? filterCarByAttributeModelObject;
  bool? clearFilters;
  TabBarPage({Key? key, this.filterCarByAttributeModelObject, this.clearFilters}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      bottomNavigationBar: MyBottomNavigationBar(clearFilters: widget.clearFilters,filterCarByAttributeModelObject: widget.filterCarByAttributeModelObject),
    );
  }
}
