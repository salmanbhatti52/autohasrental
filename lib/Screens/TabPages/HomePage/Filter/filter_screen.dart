import 'package:flutter/material.dart';
import '../../../../Utils/fontFamily.dart';
import '../../../../Widget/button.dart';
import '../../../../Utils/colors.dart';
import '../../tab_page.dart';
import 'choose_filter_mileage.dart';
import 'choose_filter_price.dart';
import 'filter_logo_container.dart';
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Stack(
                children: [
                  Positioned(
                    left: 160,
                    child: Text('Filter', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kWhite),),
                  ),
                  Positioned(
                    top: 5,
                    right: 15,
                    child: Text('Clear Filter', textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14,
                          fontFamily: poppinMedium, color: kWhite),),
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
                  Text('TESLA', textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 10,
                        fontFamily: poppinRegular, color: kWhite),
                  ),
                  const SizedBox(width: 5),
                  Icon(Icons.close, color: borderColor, size: 10,),
                  const SizedBox(width: 10),
                  Text('Low to High', textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 10,
                        fontFamily: poppinRegular, color: kWhite),
                  ),
                  const SizedBox(width: 5),
                  Icon(Icons.close, color: borderColor, size: 10,),
                  const SizedBox(width: 10),
                  Text('400 km to 800', textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: poppinRegular,
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
                  'Select Car make', textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: kWhite,
                    fontFamily: poppinBold,
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
                  child: const FilterLogoContainer()),
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
                    'Price', textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: poppinBold,
                        color: kWhite),
                  ),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                      text: 'from RM ',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: poppinMedium,
                          color: borderColor),
                      children: [
                        TextSpan(
                            text: '1,000 ',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: poppinMedium,
                                color: Colors.white)),
                        TextSpan(
                            text: 'to RM ',
                            style: TextStyle(
                                fontSize: 14, fontFamily: poppinMedium)),
                        TextSpan(
                            text: '1,500',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: poppinMedium,
                                color: Colors.white)),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const CustomRangeSlider(),
            const SizedBox(height: 10),
            const ChooseFilterPrice(),
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
                  Text('Mileage', textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, fontFamily: poppinBold, color: kWhite),),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                      text: 'from KM ',
                      style: TextStyle(fontSize: 14, fontFamily: poppinMedium, color: borderColor),
                      children: [
                        TextSpan(
                            text: '400 ',
                            style: TextStyle(fontSize: 14, fontFamily: poppinMedium, color: Colors.white)),
                        TextSpan(
                            text: 'to KM ',
                            style: TextStyle(fontSize: 14, fontFamily: poppinMedium)),
                        TextSpan(
                            text: '800',
                            style: TextStyle(fontSize: 14, fontFamily: poppinMedium, color: Colors.white)),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const CustomRangeSlider2(),
            const SizedBox(height: 10),
            const ChooseFilterMileage(),
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
                  Text('Car Year', textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, fontFamily: poppinBold, color: kWhite),
                  ),
                  const SizedBox(width: 105),
                  Text('Listing Date', textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, fontFamily: poppinBold, color: kWhite),
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
            SizedBox(height: MediaQuery.of(context).size.height* 0.02),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TabBarPage()));
                },
                child: loginButton('Apply', context)),
          ],
        ),
      ),
    );
  }
}
