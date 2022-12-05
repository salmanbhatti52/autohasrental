import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:flutter/material.dart';
import '../../../../../Widget/button.dart';
import '../../../../../Widget/colors.dart';
import '../../../../../Widget/tabbar_description_page.dart';

class DrivingDetailsPage extends StatefulWidget {
  const DrivingDetailsPage({Key? key}) : super(key: key);

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
      appBar: const myAppBarDoubleImageRichText(frontImage: "assets/live_chat_images/back_arrow.png",
          title: "Tesla S series, ", year: "2022", backImage: "assets/car_description_images/chat.png",
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
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.07,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 20),
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           Navigator.pop(context);
                    //         },
                    //         child: const Icon(
                    //           Icons.arrow_back_ios,
                    //           color: Colors.white,
                    //           size: 20,
                    //         ),
                    //       ),
                    //     ),
                    //     RichText(
                    //       text: TextSpan(
                    //         text: 'Tesla S series, ',
                    //         style: TextStyle(
                    //             fontSize: 20,
                    //             fontFamily: 'Poppins-Bold',
                    //             color: kWhite),
                    //         children: const [
                    //           TextSpan(
                    //               text: '2022',
                    //               style: TextStyle(
                    //                   fontSize: 20,
                    //                   fontFamily: 'Poppins-Regular',
                    //                   color: Colors.white)),
                    //         ],
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(right: 20),
                    //       child: Image.asset(
                    //           'assets/car_description_images/chat.png',
                    //           width: 25,
                    //           height: 25),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/car_description_images/rating.png',
                            width: 75, height: 12),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                        Text(
                          '4.0',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-SemiBold',
                              color: kWhite),
                        ),
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
                          child: Image.asset('assets/home_page/tesla.png',
                              width: 307, height: 192),
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
                              fontFamily: 'Poppins-Medium',
                              color: kWhite),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "\$250",
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Poppins-Bold',
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
                          fontFamily: 'Poppins-Medium',
                          color: kWhite),
                      children: [
                        TextSpan(
                          text: 'Get driven around by \n',
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Poppins-Regular',
                              color: kWhite),
                        ),
                        TextSpan(
                          text: "\" Alex Yoong \"",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Poppins-Bold',
                              color: kWhite),
                        ),
                        TextSpan(
                          text: ' at \n',
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Poppins-Regular',
                              color: kWhite),
                        ),
                        TextSpan(
                          text: 'Sepang Circuit for \n RMx,xxx',
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Poppins-Regular',
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            const TabbarCarDescription(),
            loginButton('Book Me', context),
          ],
        ),
      ),
    );
  }
}
