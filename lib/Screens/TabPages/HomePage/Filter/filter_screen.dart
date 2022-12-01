import 'package:flutter/material.dart';

import '../../../../Widget/button.dart';
import '../../../../Widget/colors.dart';
import '../../../../Widget/logo_container.dart';
import '../../../../Widget/range_slider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: appBgColor,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Stack(
                children: [
                  Positioned(
                    left: 160,
                    child: Text(
                      'Filter',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins-Bold',
                          color: kWhite),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 15,
                    child: Text(
                      'Clear Filter',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins-Medium',
                          color: kWhite),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('TESLA',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Poppins-Regular',
                        color: kWhite),
                  ),
                  const SizedBox(width: 5),
                  Icon(Icons.close, color: borderColor, size: 10,),
                  const SizedBox(width: 10),
                  Text('Low to High',
                    style: TextStyle(fontSize: 10,
                        fontFamily: 'Poppins-Regular', color: kWhite),
                  ),
                  const SizedBox(width: 5),
                  Icon(Icons.close, color: borderColor, size: 10,),
                  const SizedBox(width: 10),
                  Text('400 km to 800',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Poppins-Regular',
                        color: kWhite),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.close,
                    color: borderColor,
                    size: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color(0xff3F4655),
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Select Car make',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kWhite,
                    fontFamily: 'Poppins-Bold',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: const LogoContainer()),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color(0xff3F4655),
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold',
                        color: kWhite),
                  ),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                      text: 'from RM ',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins-Medium',
                          color: borderColor),
                      children: const [
                        TextSpan(
                            text: '1,000 ',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins-Medium',
                                color: Colors.white)),
                        TextSpan(
                            text: 'to RM ',
                            style: TextStyle(
                                fontSize: 14, fontFamily: 'Poppins-Medium')),
                        TextSpan(
                            text: '1,500',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins-Medium',
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const CustomRangeSlider(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  filterButton1('High to Low', context),
                  const SizedBox(width: 10),
                  filterButton2('Low to High', context),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color(0xff3F4655),
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Mileage',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold',
                        color: kWhite),
                  ),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                      text: 'from KM ',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins-Medium',
                          color: borderColor),
                      children: const [
                        TextSpan(
                            text: '400 ',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins-Medium',
                                color: Colors.white)),
                        TextSpan(
                            text: 'to KM ',
                            style: TextStyle(
                                fontSize: 14, fontFamily: 'Poppins-Medium')),
                        TextSpan(
                            text: '800',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins-Medium',
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const CustomRangeSlider2(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: filterButton1('High to Low', context),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color(0xff3F4655),
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Car Year',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold',
                        color: kWhite),
                  ),
                  const SizedBox(width: 105),
                  Text(
                    'Listing Date',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-Bold',
                        color: kWhite),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  filterButton3('Latest to Oldest', context),
                  const SizedBox(width: 55),
                  filterButton1('New to Old', context)
                ],
              ),
            ),
            const SizedBox(height: 40),
            loginButton('Apply', context),
          ],
        ),
      ),
    );
  }
}
