
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Model/cancel_booking_model.dart';
import 'package:auto_haus_rental_app/Model/BookingModels/Upcoming/EvUpComing/ev_upcoming_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/BookingPage/BookingTabs/UpcomingTab/upcoming_bookings_details_page.dart';

String? carBookingsId;
class EvUpcomingPage extends StatefulWidget {
  EvUpcomingPage({super.key});

  @override
  State<EvUpcomingPage> createState() => _EvUpcomingPageState();
}

class _EvUpcomingPageState extends State<EvUpcomingPage> {
  EvUpcomingModel evUpcomingModelObject = EvUpcomingModel();
  bool loadingP = true;

  getUpcomingBookingCarWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print(userId);

    String apiUrl = bookingUpcomingCarsApiUrl;
    print("upcomingBookingCarModelApi: $apiUrl");
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      "users_customers_id": userId,
      "cars_usage_type": "EV Subscriptions"
    });
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("responseEvUpcomingCar: ${responseString.toString()}");
      loadingP = false;
      setState(() {});
      evUpcomingModelObject = evUpcomingModelFromJson(responseString);
      print("evUpcomingCarLength: ${evUpcomingModelObject.data?.length}");
      // print("evUpcomingCarStatus: ${evUpcomingModelObject.data?[0].userFavouriteCars![0].status}");
    }
    // } catch (e) {
    //   print('Error in upcomingBookingCar: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUpcomingBookingCarWidget();
  }
  var selectedBookingId;

  @override
  Widget build(BuildContext context) {
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
        : evUpcomingModelObject.data?[0].carsDetails?.carsUsageType == "EV Subscriptions" ?
      Padding(
        padding: EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: evUpcomingModelObject.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  int reversedIndex = evUpcomingModelObject.data!.length - 1 - index;
                  selectedBookingId = evUpcomingModelObject.data![reversedIndex].bookingsId;
                  print('selectedBookingId $selectedBookingId');
                  String priceString = evUpcomingModelObject.data![reversedIndex].carsPlans![0].pricePerMonth.toString();
                  double price = double.parse(priceString);
                  NumberFormat format = NumberFormat('#,##0.00', 'en_US');
                  String formattedPrice = format.format(price);
                  return Container(
                    height: Get.height * 0.25,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: Get.width * 0.9,
                            height: Get.height * 0.22,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(3,3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 18.0, top: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${evUpcomingModelObject.data![reversedIndex].carsDetails!.vehicalName}",
                                          style: TextStyle(
                                            color: kBlack,
                                            fontSize: 14,
                                            fontFamily: poppinBold,
                                          ),
                                        ),
                                        Text(
                                          "${evUpcomingModelObject.data![reversedIndex].carsDetails!.year}",
                                          style: TextStyle(
                                            color: textLabelColor,
                                            fontSize: 14,
                                            fontFamily: poppinSemiBold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 70,
                          child: evUpcomingModelObject.data![reversedIndex].status == "Pending"?
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.1,
                                              color: Colors.transparent,
                                              child: Padding(
                                                padding: EdgeInsets.only(top: 40, left: 20),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Container(
                                                    width: 100, height: 30,
                                                    decoration: BoxDecoration(
                                                        color: borderColor,
                                                        borderRadius: BorderRadius.circular(30)
                                                    ),
                                                    child: Center(
                                                      child: Text('${evUpcomingModelObject.data![reversedIndex].status}', textAlign: TextAlign.center,
                                                          style: TextStyle(fontSize: 12,
                                                              fontFamily: poppinRegular, color: kWhite)),

                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ):
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.1,
                                              color: Colors.transparent,
                                              child: Padding(
                                                padding: EdgeInsets.only(top: 40, left: 20),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Container(
                                                    width: 100, height: 30,
                                                    decoration: BoxDecoration(
                                                        color: colorGreen,
                                                        borderRadius: BorderRadius.circular(30)
                                                    ),
                                                    child: Center(
                                                      child: Text('${evUpcomingModelObject.data![reversedIndex].status}', textAlign: TextAlign.center,
                                                          style: TextStyle(fontSize: 12, fontFamily: poppinRegular, color: kWhite)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                          //
                        ),
                        Positioned(
                          right: 20,
                          bottom: 70,
                          child: GestureDetector(
                                            onTap: () {
                                              print('selectedBookingId $selectedBookingId');
                                              showCancelDialog();
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context).size.height * 0.1,
                                              color: Colors.transparent,
                                              child: Padding(
                                                padding: EdgeInsets.only(top: 40, right: 20),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Container(
                                                    width: 100, height: 30,
                                                    decoration: BoxDecoration(
                                                        color: kRed,
                                                        borderRadius: BorderRadius.circular(30)
                                                    ),
                                                    child: Center(
                                                      child: Text('Cancel', textAlign: TextAlign.center,
                                                          style: TextStyle(fontSize: 12, fontFamily: poppinRegular, color: kWhite)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                        ),
                        Positioned(
                          left: 40,
                          bottom: 20,
                          child: Row(
                            children: [
                              Text(
                                "RM ",
                                style: TextStyle(
                                  color: kBlack,
                                  fontSize: 14,
                                  fontFamily: poppinSemiBold,
                                ),
                              ),
                              Text(
                                "${formattedPrice}",
                                style: TextStyle(
                                  color: kBlack,
                                  fontSize: 14,
                                  fontFamily: poppinSemiBold,
                                ),
                              ),
                              // Text(
                              //   "/Month",
                              //   style: TextStyle(
                              //     color: textLabelColor,
                              //     fontSize: 14,
                              //     fontFamily: poppinSemiBold,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 19,
                          bottom: 10,
                          child:  GestureDetector(
                                    onTap: (){
                                      carBookingsId = "${evUpcomingModelObject.data![reversedIndex].bookingsId}";
                                      print("bookingId $carBookingsId");
                                      print("${evUpcomingModelObject.data![reversedIndex].carsDetails!.vehicalName}");
                                      print("${evUpcomingModelObject.data![reversedIndex].carsDetails!.carsModels}");
                                      print("${evUpcomingModelObject.data![reversedIndex].carsDetails!.rating}");
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => UpcomingBookingDetailsPage(
                                            bookingId: "${evUpcomingModelObject.data![reversedIndex].bookingsId}",
                                          )));
                                    },
                            child: Image.asset(
                                "assets/car_bookings_images/more_button.png"),
                          ),
                        ),
                        Positioned(
                          left: 30,
                          top: -45,
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: Image.network(
                              '$baseUrlImage${evUpcomingModelObject.data![reversedIndex].carsDetails!.image1}',
                              errorBuilder: (BuildContext context, Object exception,
                                  StackTrace? stackTrace) {
                                return Container(
                                  child: Image.asset(
                                      'assets/icon/fade_in_image.jpeg'),
                                );
                              },
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: borderColor,
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),

                          // evUpcomingModelObject.data![reversedIndex].carsDetails!.image1 == null
                          //     ? Padding(
                          //   padding: const EdgeInsets.only(top: 80.0),
                          //   child: Image.asset('assets/icon/fade_in_image.jpeg', width: 50,
                          //     height: 50, ),
                          // )
                          //     :FadeInImage(
                          //   placeholder: AssetImage(
                          //     "assets/icon/fade_in_image.jpeg",),
                          //   width: 180,
                          //   height: 180,
                          //   image: NetworkImage(
                          //     "$baseUrlImage${evUpcomingModelObject.data![reversedIndex].carsDetails!.image1}",),
                          // ),
                        ),
                      ],
                    ),
                  );

                  //   Stack(
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(vertical: 20),
                  //       child: Container(
                  //         height: MediaQuery.of(context).size.height * 0.33)),
                  //     Positioned(
                  //       top: 90,
                  //       left: 30,
                  //       right: 30,
                  //       child: Padding(
                  //         padding: EdgeInsets.only(left: 9),
                  //         child: Container(
                  //           height:
                  //           MediaQuery.of(context).size.height * 0.24,
                  //           width: 343,
                  //           decoration: BoxDecoration(
                  //             color: kWhite,
                  //             borderRadius: BorderRadius.circular(20),
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.grey.withOpacity(0.1),
                  //                 spreadRadius: 5,
                  //                 blurRadius: 5,
                  //                 offset: Offset(3, 3),
                  //               ),
                  //             ],
                  //           ),
                  //           child: Column(
                  //             children: [
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //
                  //                   evUpcomingModelObject.data![reversedIndex].status == "Pending"?
                  //                   Container(
                  //                     height: MediaQuery.of(context).size.height * 0.1,
                  //                     color: Colors.transparent,
                  //                     child: Padding(
                  //                       padding: EdgeInsets.only(top: 40, left: 20),
                  //                       child: Align(
                  //                         alignment: Alignment.centerLeft,
                  //                         child: Container(
                  //                           width: 100, height: 30,
                  //                           decoration: BoxDecoration(
                  //                               color: borderColor,
                  //                               borderRadius: BorderRadius.circular(30)
                  //                           ),
                  //                           child: Center(
                  //                             child: Text('${evUpcomingModelObject.data![reversedIndex].status}', textAlign: TextAlign.center,
                  //                                 style: TextStyle(fontSize: 12,
                  //                                     fontFamily: poppinRegular, color: kWhite)),
                  //
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ):
                  //                   Container(
                  //                     height: MediaQuery.of(context).size.height * 0.1,
                  //                     color: Colors.transparent,
                  //                     child: Padding(
                  //                       padding: EdgeInsets.only(top: 40, left: 20),
                  //                       child: Align(
                  //                         alignment: Alignment.centerLeft,
                  //                         child: Container(
                  //                           width: 100, height: 30,
                  //                           decoration: BoxDecoration(
                  //                               color: colorGreen,
                  //                               borderRadius: BorderRadius.circular(30)
                  //                           ),
                  //                           child: Center(
                  //                             child: Text('${evUpcomingModelObject.data![reversedIndex].status}', textAlign: TextAlign.center,
                  //                                 style: TextStyle(fontSize: 12, fontFamily: poppinRegular, color: kWhite)),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //
                  //                   GestureDetector(
                  //                     onTap: () {
                  //                       print('selectedBookingId $selectedBookingId');
                  //                       showCancelDialog();
                  //                     },
                  //
                  //                     child: Container(
                  //                       height: MediaQuery.of(context).size.height * 0.1,
                  //                       color: Colors.transparent,
                  //                       child: Padding(
                  //                         padding: EdgeInsets.only(top: 40, right: 20),
                  //                         child: Align(
                  //                           alignment: Alignment.centerLeft,
                  //                           child: Container(
                  //                             width: 100, height: 30,
                  //                             decoration: BoxDecoration(
                  //                                 color: kRed,
                  //                                 borderRadius: BorderRadius.circular(30)
                  //                             ),
                  //                             child: Center(
                  //                               child: Text('Cancel', textAlign: TextAlign.center,
                  //                                   style: TextStyle(fontSize: 12, fontFamily: poppinRegular, color: kWhite)),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //
                  //                 ],
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   SizedBox(height: 93.6),
                  //                   Padding(
                  //                     padding: EdgeInsets.symmetric(horizontal: 15),
                  //                     child: Column(
                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                  //                       children: [
                  //                         Row(
                  //                           children: [
                  //                             Text("${evUpcomingModelObject.data![reversedIndex].carsDetails!.vehicalName}  ",
                  //                               textAlign: TextAlign.left, style: TextStyle(
                  //                                     color: kBlack, fontSize: 14, fontFamily: poppinBold)),
                  //                             Text("${evUpcomingModelObject.data![reversedIndex].carsDetails!.carsColors!.name}",
                  //                                 textAlign: TextAlign.left, style: TextStyle(
                  //                                     color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
                  //                           ],
                  //                         ),
                  //                         Row(
                  //                           children: [
                  //                             Text(
                  //                               "${evUpcomingModelObject.data![reversedIndex].carsDetails!.carsMakes!.name}, ",
                  //                               textAlign: TextAlign.left, style: TextStyle(
                  //                                   color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                  //                             Text(
                  //                               "${evUpcomingModelObject.data![reversedIndex].carsDetails!.carsModels}, ",
                  //                               textAlign: TextAlign.left, style: TextStyle(
                  //                                   color: kBlack, fontSize: 12, fontFamily: poppinMedium)),
                  //                             Text("${evUpcomingModelObject.data![reversedIndex].carsDetails!.year}",
                  //                                 textAlign: TextAlign.left, style: TextStyle(
                  //                                     color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                  //                           ],
                  //                         ),
                  //                         SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  //                         Row(
                  //                           children: [
                  //                             Padding(
                  //                               padding: EdgeInsets.only(top: 06),
                  //                               child: Text("RM", textAlign: TextAlign.left, style: TextStyle(
                  //                                   color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                  //                             ),
                  //                             // "${upcomingBookingModelObject.data![index].carsPlans![0].pricePerHour}",
                  //                             Text("${formattedPrice}", textAlign: TextAlign.left, style: TextStyle(
                  //                                     color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                  //                             Text("/", textAlign: TextAlign.left, style: TextStyle(color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                  //                             // SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
                  //                             // showRatingStars(double.parse("${evUpcomingModelObject.data![reversedIndex].carsDetails!.rating}")),
                  //                             //
                  //                             // SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                  //                             //
                  //                             // evUpcomingModelObject.data![reversedIndex].carsDetails!.rating == null?
                  //                             // Text("0.0", textAlign: TextAlign.left,
                  //                             //   style: TextStyle(color: kBlack,
                  //                             //       fontSize: 12, fontFamily: poppinRegular)):
                  //                             // Text("${evUpcomingModelObject.data![reversedIndex].carsDetails!.rating}", textAlign: TextAlign.left,
                  //                             //     style: TextStyle(color: kBlack,
                  //                             //         fontSize: 12, fontFamily: poppinRegular)),
                  //                           ],
                  //                         ),
                  //
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //       right: 30, bottom: 30,
                  //       child: GestureDetector(
                  //         onTap: (){
                  //           carBookingsId = "${evUpcomingModelObject.data![reversedIndex].bookingsId}";
                  //           print("bookingId $carBookingsId");
                  //           print("${evUpcomingModelObject.data![reversedIndex].carsDetails!.vehicalName}");
                  //           print("${evUpcomingModelObject.data![reversedIndex].carsDetails!.carsModels}");
                  //           print("${evUpcomingModelObject.data![reversedIndex].carsDetails!.rating}");
                  //           Navigator.push(context, MaterialPageRoute(
                  //               builder: (context) => UpcomingBookingDetailsPage(
                  //                 bookingId: "${evUpcomingModelObject.data![reversedIndex].bookingsId}",
                  //               )));
                  //         },
                  //           child: Image.asset("assets/car_bookings_images/more_button.png"),
                  //       ),
                  //     ),
                  //     // Positioned(
                  //     //   left: 20, right: 20,top: 30,
                  //     //   child: Image.network("$baseUrlImage${evUpcomingModelObject.data![reversedIndex].carsDetails!.image1}",
                  //     //       width: MediaQuery.of(context).size.width * 0.3,
                  //     //       height: MediaQuery.of(context).size.height * 0.1),
                  //     // ),
                  //
                  //
                  //     Positioned(
                  //       left: 20, right: 20,top: 0,
                  //       child: evUpcomingModelObject.data![reversedIndex].carsDetails!.image1 == null
                  //           ? ClipRRect(
                  //         borderRadius: BorderRadius.circular(10),
                  //         child: Image.asset('assets/icon/fade_in_image.jpeg'),
                  //       )
                  //           : evUpcomingModelObject.data![reversedIndex].carsDetails!.image1!.endsWith('.jpg') || evUpcomingModelObject.data![reversedIndex].carsDetails!.image1!.endsWith('.png') || evUpcomingModelObject.data![reversedIndex].carsDetails!.image1!.endsWith('.jpeg')
                  //           ? ClipRRect(
                  //         borderRadius: BorderRadius.circular(10),
                  //         child: FadeInImage(
                  //           placeholder: AssetImage("assets/icon/fade_in_image.jpeg"),
                  //           height: 65,
                  //           image: NetworkImage("$baseUrlImage${evUpcomingModelObject.data![reversedIndex].carsDetails!.image1}"),
                  //         ),
                  //       )
                  //           : Container(
                  //         height: MediaQuery.of(context).size.height * 0.19,
                  //         child: ModelViewer(
                  //           // cameraOrbit: Clipboard.kTextPlain,
                  //           backgroundColor: Colors.transparent,
                  //           src: '${evUpcomingModelObject.data![reversedIndex].carsDetails!.image1}',
                  //           alt: "A 3D model of car",
                  //           autoPlay: false,
                  //           autoRotate: false,
                  //           cameraControls: false,
                  //           disableTap: false,
                  //           ar: false,
                  //           disablePan: true,
                  //           arModes: ["quicklook", "scene-viewer"],
                  //           iosSrc: "${evUpcomingModelObject.data![reversedIndex].carsDetails!.image1}",
                  //           disableZoom: true,
                  //         ),
                  //       ),
                  //     ),
                  //     evUpcomingModelObject.data![reversedIndex].carsDetails!.discountPercentage != "0.00"
                  //     ? Positioned(
                  //         top: 10, left: 15,
                  //         child: Container(
                  //           height: MediaQuery.of(context).size.width * 0.07,
                  //           width: MediaQuery.of(context).size.width * 0.16,
                  //           decoration: BoxDecoration(
                  //             color: kRed.withOpacity(0.8),
                  //             borderRadius: BorderRadius.only(
                  //                 topRight: Radius.circular(15),
                  //                 bottomLeft: Radius.circular(15)),
                  //           ),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text("${evUpcomingModelObject.data![reversedIndex].carsDetails!.discountPercentage}",
                  //                 style: TextStyle(color: kWhite,
                  //                   fontSize: 13, fontWeight: FontWeight.bold,
                  //                   fontFamily: 'Poppins')),
                  //               Text(" OFF ", style: TextStyle(
                  //                 color: kWhite, fontSize: 8,
                  //                 fontWeight: FontWeight.w300, fontFamily: 'Poppins')),
                  //             ],
                  //           ),
                  //         ),
                  //     )
                  //     : Positioned(top: 10, left: 15,child: SizedBox()),
                  //
                  // //     Positioned(
                  // //         top: 10, right: 15,
                  // //         child:
                  // //         // evUpcomingModelObject.data![index].userFavouriteCars!.length> 0 ?
                  // //         // evUpcomingModelObject.data![index].userFavouriteCars![0].status == "dislike"?
                  // //         // Image.asset("assets/home_page/heart.png") :
                  // //         // Image.asset("assets/car_bookings_images/heart.png"),
                  // //         Image.asset("assets/car_bookings_images/heart.png"),
                  // //
                  // // // Image.asset("assets/car_bookings_images/heart.png"):
                  // //
                  // //     ),
                  //   ],
                  // );
                }),
          ),
        ),
      ):
    Center(
      child: Text('No booking Found',
          style: TextStyle(color: Colors.black,
              fontSize: 20, fontWeight: FontWeight.bold,
              fontFamily: 'Poppins')),
    );
  }

  Widget yesButton() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Container(
        height: screenHeight * 0.05,
        width: screenWidth * 0.6,
        decoration: BoxDecoration(
          color: borderColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text("Yes", textAlign: TextAlign.center, style: TextStyle(
              color: kWhite, fontFamily: poppinRegular, fontSize: 16)),
        ),
      ),
    );
  }

  Widget noButton() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: screenHeight * 0.05,
        width: screenWidth,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: kRed, width: 2)),
        child: Center(
          child: Text("No", textAlign: TextAlign.center, style: TextStyle(
              color: kRed, fontFamily: poppinRegular, fontSize: 16)),
        ),
      ),
    );
  }

  void showCancelDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Color(0xffb0b0b0),
            child: Container(
              color: Color(0xff0f172a).withOpacity(0.5),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)), //this right here
                child: Container(
                  decoration: BoxDecoration(
                      color: homeBgColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {
                        //         Navigator.pop(context);
                        //       },
                        //       child: Image.asset("assets/payment_card_images/cancle.png",),
                        //     ),
                        //   ],
                        // ),
                        Text(
                          "Cancellation Confirmation",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: borderColor,
                                fontSize: 20,
                                fontFamily: poppinSemiBold,
                            ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Text("Are you sure you want to cancel this booking?",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kBlack,
                                fontSize: 20, fontFamily: poppinMedium)),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Text("PLease Note:",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: kRed,
                                fontSize: 14, fontFamily: poppinRegular)),
                        Text("* Once Cancelled, the refund process will be initiated",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kRed,
                                fontSize: 14, fontFamily: poppinRegular)),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Text("* Refund typically take 7 to 14 working days to reflect in your account",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kRed,
                                fontSize: 14, fontFamily: poppinRegular)),
                        GestureDetector(
                            onTap: () async {
                              await cancelBookingWidget();
                              if (cancelBookingModelObject.status == "success"){
                                Fluttertoast.showToast(
                                    msg: "${cancelBookingModelObject.status}",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: colorGreen,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.pop(context);
                                await getUpcomingBookingCarWidget();
                              }

                              else{
                                print('cancelBookingMessage ${cancelBookingModelObject.message}');
                              }
                              // if (cancelBookingModelObject.status != "success"){
                              //   print('cancelBookingMessage ${cancelBookingModelObject.message}');
                              //   toastFailedMessage(cancelBookingModelObject.message, kRed);
                              // }
                            },
                            child: yesButton()
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: noButton()),
                        SizedBox(height: Get.height * 0.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  CancelBookingModel cancelBookingModelObject = CancelBookingModel();
  cancelBookingWidget() async {
    try {
      String apiUrl = cancelBookingDialogBoxApiUrl;
      print("api: $apiUrl");
      print("userId: $userId");
      print('selectedBookingId $selectedBookingId');
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Accept': 'application/json'},
        body: {
          'users_customers_id': userId,
          'bookings_id': "$selectedBookingId",
          'status': "Cancelled",
        },
      );
      final responseString = response.body;
      print("cancelBookingModelResponse: $responseString");

      print("statusCodeCancelModel: ${response.statusCode}");
      if (response.statusCode == 200) {

        cancelBookingModelObject = cancelBookingModelFromJson(responseString);
        setState(() {});
        print('cancelBookingModelMessage: ${cancelBookingModelObject.message}');
      }
    } catch (e) {
      print('cancelBookingModel error in catch = ${e.toString()}');
      return null;
    }
  }
}
