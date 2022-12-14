import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import '../../../../../../Utils/colors.dart';
import '../../../../MyAppBarHeader/app_bar_header.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const MyAppBarAboutUsPage(
        backImage: "assets/home_page/Side_Menu.png", title: "About Us", ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 20),
                child: Text(
                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor '
                      'invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et '
                      'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata '
                      'sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing '
                      'elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, '
                      'sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita '
                      'kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor '
                      'sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et '
                      'dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores '
                      'et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. '
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt '
                      'ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo '
                      'dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor '
                      'sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod '
                      'tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et '
                      'accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus '
                      'est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed '
                      'diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. '
                      'At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata.',
                  style: TextStyle(fontSize: 16,
                      fontFamily: poppinRegular, color: kWhite),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
