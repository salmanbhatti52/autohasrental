import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../../../../Model/BookingModels/Upcoming/DrivingUpComing/driving_upcoming_model.dart';
import '../../../PreviousTab/PreviousTabs/previous_bookings_details_page.dart';
import '../../upcoming_bookings_details_page.dart';
import '../EvUpcoming/ev_upcoming_page.dart';
import 'driving_upcoming_details_page.dart';

class DrivingUpcomingPage extends StatefulWidget {
  const DrivingUpcomingPage({super.key});

  @override
  State<DrivingUpcomingPage> createState() => _DrivingUpcomingPageState();
}

class _DrivingUpcomingPageState extends State<DrivingUpcomingPage> {
  DrivingUpcomingModel drivingUpcomingModelObject = DrivingUpcomingModel();

  bool loadingP = true;

  getUpcomingBookingCarWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print('in upcomingBookingCarApi');

    // try {
    String apiUrl = bookingUpcomingCarsApiUrl;
    print("upcomingBookingCarModelApi: $apiUrl");
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      "users_customers_id": userId,
      "cars_usage_type": "Driving Experience"
    });
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("responseUpcomingDrivingCar: ${responseString.toString()}");
      loadingP = false;
      setState(() {});
      drivingUpcomingModelObject = drivingUpcomingModelFromJson(responseString);
      print("drivingUpcomingCarLength: ${drivingUpcomingModelObject.data?.length}");
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

  @override
  Widget build(BuildContext context) {
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
        : drivingUpcomingModelObject.data?[0].carsDetails?.carsUsageType == "Driving Experience" ?
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: drivingUpcomingModelObject.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  // print("previousBookingModelObject ${previousBookingModelObject.data?.length}");
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
                                    drivingUpcomingModelObject.data![index].status == "Pending"?
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
                                              child: Text('${drivingUpcomingModelObject.data![index].status}', textAlign: TextAlign.center,
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
                                        padding: const EdgeInsets.only(top: 40, left: 20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: 100, height: 30,
                                            decoration: BoxDecoration(
                                                color: colorGreen,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Center(
                                              child: Text('${drivingUpcomingModelObject.data![index].status}', textAlign: TextAlign.center,
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
                                              Text("${drivingUpcomingModelObject.data![index].carsDetails!.vehicalName}  ",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 14, fontFamily: poppinBold)),

                                              Text("${drivingUpcomingModelObject.data![index].carsDetails!.carsColors!.name}",
                                                  textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 10, fontFamily: poppinRegular)),

                                            ],
                                          ),
                                          Row(
                                            children: [

                                              Text(
                                                "${drivingUpcomingModelObject.data![index].carsDetails!.carsMakes}, ",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                    color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                              Text(
                                                "${drivingUpcomingModelObject.data![index].carsDetails!.carsModels}, ",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                    color: kBlack, fontSize: 12, fontFamily: poppinMedium)),
                                              Text("${drivingUpcomingModelObject.data![index].carsDetails!.year}",
                                                  textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                            ],
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 06),
                                                child: Text("RM", textAlign: TextAlign.left, style: TextStyle(
                                                    color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                                              ),
                                              Text("${drivingUpcomingModelObject.data![index].carsPlans![0].pricePerSlot}", textAlign: TextAlign.left, style: TextStyle(
                                                      color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                              Text("/Slot", textAlign: TextAlign.left, style: TextStyle(color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.height * 0.01,),

                                              showRatingStars(double.parse("${drivingUpcomingModelObject.data![index].carsDetails!.rating}")),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.height * 0.01),

                                              drivingUpcomingModelObject.data![index].carsDetails!.rating == null?
                                              Text("0.0", textAlign: TextAlign.left,
                                                style: TextStyle(color: kBlack,
                                                    fontSize: 12, fontFamily: poppinRegular)):
                                              Text("${drivingUpcomingModelObject.data![index].carsDetails!.rating}", textAlign: TextAlign.left,
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
                        child: GestureDetector(
                          onTap: (){
                            carBookingsId = "${drivingUpcomingModelObject.data![index].bookingsId}";
                            print("clicked....");
                            print("${drivingUpcomingModelObject.data![index].carsDetails!.vehicalName}");
                            print("${drivingUpcomingModelObject.data![index].carsDetails!.carsModels}");
                            print("${drivingUpcomingModelObject.data![index].carsDetails!.rating}");
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => UpcomingBookingDetailsPage(
                                  bookingId: "${drivingUpcomingModelObject.data![index].bookingsId}",
                                )));
                            print("carImage $baseUrlImage${drivingUpcomingModelObject.data![index].carsDetails!.image1}");
                          },
                            child: Image.asset("assets/car_bookings_images/more_button.png")),
                      ),
                      Positioned(
                        left: 20,
                        child: Image.network("$baseUrlImage${drivingUpcomingModelObject.data![index].carsDetails!.image1}",
                            width: 332, height: 120),
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
                                Text("${drivingUpcomingModelObject.data![index].carsDetails!.discountPercentage}",
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
                          top: 10, right: 15,
                          child: Image.asset("assets/car_bookings_images/heart.png"),
                      ),
                    ],
                  );
                    // const Center(child: Text('booking unavailable...',
                    //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)));
                }),
          ),
        ),
      ):
    const Center(child: Text('booking unavailable...',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)));
  }
}
