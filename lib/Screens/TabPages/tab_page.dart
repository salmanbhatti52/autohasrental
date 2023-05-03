
import 'package:flutter/material.dart';
import 'package:auto_haus_rental_app/Widget/bottom_bar.dart';

class TabBarPage extends StatefulWidget {
  TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
