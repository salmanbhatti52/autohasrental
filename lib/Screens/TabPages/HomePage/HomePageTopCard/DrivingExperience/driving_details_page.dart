import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/HomePageTopCard/DrivingExperience/driving_experience_booking.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/Homepage/HomePageTopCard/EvSubscriptions/EvTabbar/tabbar_description_page.dart';
import 'package:auto_haus_rental_app/Widget/day_slot.dart';
import 'package:auto_haus_rental_app/Widget/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../../../../Utils/fontFamily.dart';
import '../../../../../Widget/button.dart';
import '../../../../../Utils/colors.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';

class DrivingDetailsPage extends StatefulWidget {
  final String? carName, carYear, carImage;
  const DrivingDetailsPage(
      {Key? key, this.carName, this.carYear, this.carImage})
      : super(key: key);

  @override
  State<DrivingDetailsPage> createState() => _DrivingDetailsPageState();
}

class _DrivingDetailsPageState extends State<DrivingDetailsPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: MyAppBarDoubleImageRichText(
        frontImage: "assets/home_page/back_arrow.png",
        // title: "Tesla S series, ",
        // year: "2022",
        title: "${widget.carName}, ",
        year: "${widget.carYear}",
        backImage: "assets/car_description_images/chat.png",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xff3d4a68),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
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
                        Image.asset(
                          'assets/home_page/9004787_star_favorite_award_like_icon.png',
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Text('4.0',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: poppinSemiBold,
                                color: kWhite)),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.asset(
                              'assets/car_description_images/tesla.png',
                              width: 41,
                              height: 41),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.asset(
                              'assets/car_description_images/heart.png',
                              width: 24,
                              height: 20),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(
                          child: Image.network("${widget.carImage}",
                              width: 307, height: 192),
                          // child: Image.asset('assets/home_page/tesla.png', width: 307, height: 192),
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
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                color: Color(0xff3d4a68),
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Driving Experiences",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: poppinMedium,
                              color: kWhite),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "\$250",
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: poppinBold,
                              color: kWhite),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Image.asset("assets/images/crown_image.png"),
                  RichText(
                    text: TextSpan(
                      text: 'Track Day Session \n',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: poppinMedium,
                          color: kWhite),
                      children: [
                        TextSpan(
                            text: 'Get driven around by \n',
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: poppinRegular,
                                color: kWhite)),
                        TextSpan(
                          text: "\" Alex Yoong \"",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: poppinBold,
                              color: kWhite),
                        ),
                        TextSpan(
                          text: ' at \n',
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: poppinRegular,
                              color: kWhite),
                        ),
                        TextSpan(
                          text: 'Sepang Circuit for \n RMx,xxx',
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: poppinRegular,
                              color: kWhite),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset("assets/images/crown_images_two.png")
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Available Time Slot',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins-Bold',
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.keyboard_arrow_left,
                  color: Color(0xffa5a5a5),
                ),
                GestureDetector(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime(2030, 1, 1), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      print('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    'December 2022',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins-SemiBold',
                      color: borderColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Color(0xffa5a5a5),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
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
                  child: const TimeSlotContainer()),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            const TabbarCarDescription(),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DrivingExperinceBooking()));
                },
                child: loginButton('Book Now', context)),
          ],
        ),
      ),
    );
  }
}
