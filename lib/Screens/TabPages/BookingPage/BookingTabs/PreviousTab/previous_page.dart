import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Model/HomePageModels/BookingModels/booking_previous_model.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/constants.dart';
import 'bookings_detail_page.dart';
import 'package:http/http.dart' as http;

class PreviousPage extends StatefulWidget {
  const PreviousPage({super.key});

  @override
  State<PreviousPage> createState() => _PreviousPageState();
}

class _PreviousPageState extends State<PreviousPage> {
  PreviousBookingModel previousBookingModelObject = PreviousBookingModel();
  bool loadingP = true;
  sharedPrefs() async {
    loadingP = true;
    setState(() {});
    print('in PreviousBookingCar sharedPrefs');
    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print("userId in PreviousBookingCar is = $userId");
    setState(() {
      getPreviousBookingCarWidget();
    });
  }

  getPreviousBookingCarWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print('in previousBookingCarApi');

    try {
      String apiUrl = bookingPreviousCarsApiUrl;
      print("upcomingBookingCarModelApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Accept': 'application/json'
      }, body: {
        "users_customers_id": userId
      });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("responsePreviousBookingCar: ${responseString.toString()}");
        previousBookingModelObject = previousBookingModelFromJson(responseString);
        print("previousBookingLength: ${previousBookingModelObject.data!.length}");
      }
    } catch (e) {
      print('Error in upcomingBookingCar: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
        : previousBookingModelObject.status != "success" ?
    const Center(child: Text('booking unavailable...',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))) :
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => const BookingDetailPage()));
          },
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height * 0.70,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: previousBookingModelObject.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.33)),
                        Positioned(
                          top: 90,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 9),
                            child: Container(
                              height:
                              MediaQuery.of(context).size.height * 0.24,
                              width: 343,
                              decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: const Offset(3, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 40, left: 20),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              width: 100, height: 30,
                                              decoration: BoxDecoration(
                                                  color: borderColor,
                                                  borderRadius: BorderRadius.circular(30)
                                              ),
                                              child: Center(
                                                child: Text('${previousBookingModelObject.data![index].status}', textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 12,
                                                        fontFamily: poppinRegular, color: kWhite)),

                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 40, right: 20),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              width: 100, height: 30,
                                              decoration: BoxDecoration(
                                                color: borderColor,
                                                borderRadius: BorderRadius.circular(30)
                                              ),
                                              child: Center(
                                                child: Text('Rebook', textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 12,
                                                        fontFamily: poppinRegular, color: kWhite)),

                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(height: 93.6),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text("${previousBookingModelObject.data![index].carsDetails!.vehicalName} | ",
                                                  textAlign: TextAlign.left, style: TextStyle(
                                                        color: kBlack, fontSize: 14, fontFamily: poppinBold)),
                                                Text(
                                                  "${previousBookingModelObject.data![index].carsDetails!.carsMakes} ",
                                                  textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                                Text(
                                                  "${previousBookingModelObject.data![index].carsDetails!.carsModels} ",
                                                  textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 14, fontFamily: poppinMedium)),
                                                Text("${previousBookingModelObject.data![index].carsDetails!.year}",
                                                  textAlign: TextAlign.left, style: TextStyle(
                                                        color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
                                              ],
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                            Row(
                                              children: [
                                                // Padding(
                                                //   padding: const EdgeInsets.only(top: 04),
                                                //   child: Text("RM", textAlign: TextAlign.left,
                                                //     style: TextStyle(color: kRed,
                                                //         fontSize: 5, fontFamily: poppinRegular)),
                                                // ),
                                                // Text("${previousBookingModelObject.data![index].carsDetails!.year}",
                                                //     textAlign: TextAlign.left,
                                                //     style: TextStyle(color: kRed,
                                                //     decoration: TextDecoration.lineThrough,
                                                //     decorationColor: kRed,
                                                //     decorationThickness: 3, fontSize: 10,
                                                //     fontFamily: poppinLight, height: 2)),
                                                // const SizedBox(width: 5),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 06),
                                                  child: Text("RM", textAlign: TextAlign.left,
                                                    style: TextStyle(color: borderColor,
                                                      fontSize: 7, fontFamily: poppinSemiBold)),
                                                ),
                                                Text("${previousBookingModelObject.data![index].carsPlans![0].pricePerSlot}",
                                                  textAlign: TextAlign.left, style: TextStyle(
                                                    color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                                Text("/ Month", textAlign: TextAlign.left,
                                                  style: TextStyle(color: kBlack,
                                                      fontSize: 8, fontFamily: poppinRegular)),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.height * 0.01,),
                                                Image.asset("assets/car_bookings_images/rating_stars.png"),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.height * 0.01),
                                                Text("4.0", textAlign: TextAlign.left,
                                                  style: TextStyle(color: kBlack,
                                                      fontSize: 12, fontFamily: poppinRegular)),
                                              ],
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                            Row(
                                              children: [
                                                Image.asset("assets/car_bookings_images/promoted.png"),
                                                const SizedBox(width: 5),
                                                Text("Verified Dealer", textAlign: TextAlign.left,
                                                  style: TextStyle(color: textLabelColor,
                                                    fontSize: 10, fontFamily: poppinRegular)),
                                                const SizedBox(width: 05),
                                                Container(
                                                  height: 15,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                      color: kBlack,
                                                      borderRadius: BorderRadius.circular(10)),
                                                  child: Center(
                                                    child: Text("New", textAlign: TextAlign.left,
                                                      style: TextStyle(color: kWhite,
                                                        fontSize: 8, fontFamily: poppinRegular)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 30, bottom: 35,
                          child: Image.asset("assets/car_bookings_images/more_button.png"),
                        ),
                        Positioned(
                            top: 10, left: 15,
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.07,
                              width: MediaQuery.of(context).size.width * 0.16,
                              decoration: BoxDecoration(
                                color: kRed.withOpacity(0.8),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${previousBookingModelObject.data![index].carsDetails!.discountPercentage}",
                                    style: TextStyle(color: kWhite,
                                      fontSize: 13, fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins')),
                                  Text(" OFF ", style: TextStyle(
                                    color: kWhite, fontSize: 8,
                                    fontWeight: FontWeight.w300, fontFamily: 'Poppins')),
                                ],
                              ),
                            )),
                        Positioned(
                          child: Image.network("$baseUrlImage${previousBookingModelObject.data![index].carsDetails!.image1}",
                            width: 332, height: 120),
                        ),
                        Positioned(
                            top: 10, right: 15,
                            child: Image.asset("assets/car_bookings_images/heart.png",),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      );
  }
}

List previousItemsList = [
  PreviousItemsClass("assets/car_bookings_images/tesla_car_image.png", "5%",
      'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  PreviousItemsClass("assets/car_bookings_images/bmw_car_image.png", "5%",
      'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  PreviousItemsClass("assets/car_bookings_images/tesla_car_image.png", "5%",
      'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  PreviousItemsClass("assets/car_bookings_images/bmw_car_image.png", "5%",
      'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
];

class PreviousItemsClass {
  final String carImage;
  final String discountText;
  final String carCompanyName;
  final String textModel;
  final String range;
  final String carModelYear;
  final String oldPrice;
  final String newPrice;

  PreviousItemsClass(
      this.carImage,
      this.discountText,
      this.carCompanyName,
      this.textModel,
      this.carModelYear,
      this.range,
      this.oldPrice,
      this.newPrice);
}
