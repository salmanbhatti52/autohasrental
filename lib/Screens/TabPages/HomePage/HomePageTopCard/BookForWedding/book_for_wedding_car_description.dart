import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/HomePageTopCard/BookForWedding/book_for_wedding_booking_details.dart';
import 'package:auto_haus_rental_app/Widget/day_slot.dart';
import 'package:auto_haus_rental_app/Widget/hour_slot.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/fontFamily.dart';
import '../../../../../Widget/button.dart';
import '../../../../../Utils/colors.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';
import 'BookForWeddingTabbar/tabbar_book_for_wedding.dart';

class BookForWeddingCarDescription extends StatefulWidget {
  final String? carName, carImage, carRating, carDescription;
  final int? carYear;
  const BookForWeddingCarDescription({super.key, this.carName,
    this.carYear, this.carImage, this.carRating, this.carDescription});

  @override
  State<BookForWeddingCarDescription> createState() =>
      _BookForWeddingCarDescriptionState();
}

class _BookForWeddingCarDescriptionState
    extends State<BookForWeddingCarDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: MyAppBarDoubleImageRichText(
        frontImage: "assets/live_chat_images/back_arrow.png",
        title: "${widget.carName} ", year: "${widget.carYear}",
        // title: "Tesla S series, ",
        // year: "2022",

        backImage: "assets/car_description_images/chat.png",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.37,
              decoration: const BoxDecoration(
                color: Color(0xff0f172a),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/home_page/9004787_star_favorite_award_like_icon.png',),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      widget.carRating == null?
                          Text("0.0", style: TextStyle(fontSize: 16,
                              color: kWhite, fontFamily: poppinSemiBold)):
                      Text('${widget.carRating}', style: TextStyle(fontSize: 16,
                          color: kWhite, fontFamily: poppinSemiBold)),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Image.asset('assets/car_description_images/tesla.png', width: 41, height: 41),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Image.asset('assets/car_description_images/heart.png', width: 24, height: 20),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Positioned(
                        child: Image.network("${widget.carImage}", height: 190, width: 310),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Image.asset(
                          'assets/car_description_images/circle.png',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppins-Medium',
                        color: borderColor),
                    textAlign: TextAlign.left,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'RM',
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: poppinBold,
                          color: borderColor),
                      children: [
                        TextSpan(
                          text: '250',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: poppinBold,
                              color: borderColor),
                        ),
                        TextSpan(
                          text: '/hrs',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: poppinMedium,
                              color: borderColor),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Select Booking Day and Time',
                style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Bold'),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: const DaySlotContainer()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: const HourSlotContainer()),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            const TabbarBookForWedding(),
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                          builder: (context) => BookForWeddingBookingDetails(
                            carName: widget.carName,
                            carYear: widget.carYear,
                          )));
                },
                child: loginButton('Book Now', context)),
          ],
        ),
      ),
    );
  }
}
