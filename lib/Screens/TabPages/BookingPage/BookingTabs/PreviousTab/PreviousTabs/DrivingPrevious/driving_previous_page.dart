import 'package:auto_haus_rental_app/Model/BookingModels/Previous/Driving/driving_previous_model.dart';
import 'package:auto_haus_rental_app/Model/GetCarByIdModel/driving_car_details_by_id_model.dart' as topRented;
import 'package:auto_haus_rental_app/Model/HomePageModels/top_rented_cars_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Widget/cars_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../../Homepage/TopRented/Driving_Home/home_driving_booking.dart';
import '../../../UpcomingTab/UpcomingTabs/EvUpcoming/ev_upcoming_page.dart';
import '../bookingsdetail/previous_bookings_details_page.dart';

class DrivingPreviousPage extends StatefulWidget {
  DrivingPreviousPage({super.key});

  @override
  State<DrivingPreviousPage> createState() => _DrivingPreviousPageState();
}

class _DrivingPreviousPageState extends State<DrivingPreviousPage> {
  DrivingPreviousModel drivingPreviousObject = DrivingPreviousModel();
  bool loadingP = true;

  getPreviousBookingCarWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print('in previousBookingCarApi');

    // try {
      String apiUrl = bookingPreviousCarsApiUrl;
      print("previousBookingCarModelApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Accept': 'application/json'
      }, body: {
        "users_customers_id": userId,
        "cars_usage_type": "Driving Experience"
      });
      print('statusCode ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseString = response.body;
        print("responsePreviousDrivingBookingCar: ${responseString.toString()}");
        // loadingP = false;
        // setState(() {});
        drivingPreviousObject = drivingPreviousModelFromJson(responseString);
        print("drivingBookingLength: ${drivingPreviousObject.data?.length}");
      }
    // } catch (e) {
    //   print('Error in upcomingBookingCar: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
    print("loadingStatus $loadingP");
  }

  // topRented.DrivingCarDetailsByIdModel drivingCarDetailsByIdModelObject = topRented.DrivingCarDetailsByIdModel();
  // getCarDetailsByIdWidget() async {
  //   loadingP = true;
  //   setState(() {});
  //
  //   prefs = await SharedPreferences.getInstance();
  //   userId = (prefs!.getString('userid'));
  //   print('in getCarDetailByIDApi');
  //
  //   // try {
  //   String apiUrl = getCarDetailsByIdApiUrl;
  //   print("getCarDetailByIDApi: $apiUrl");
  //   final response = await http.post(Uri.parse(apiUrl), headers: {
  //     'Accept': 'application/json'
  //   }, body: {
  //     "cars_id": "$carID",
  //   });
  //   print('${response.statusCode}');
  //   print(response);
  //   if (response.statusCode == 200) {
  //     final responseString = response.body;
  //     print("responseGetCarDetailByID: ${responseString.toString()}");
  //     drivingCarDetailsByIdModelObject = topRented.drivingCarDetailsByIdModelFromJson(responseString);
  //     // Future.delayed(Duration(seconds: 2), () {
  //     // Navigator.push(context, MaterialPageRoute(
  //     //     builder: (context) => HomeDrivingBooking(
  //     //
  //     //       datum: drivingCarDetailsByIdModelObject.data,
  //     //       carName: drivingCarDetailsByIdModelObject.data?.vehicalName,
  //     //       carYear: "${drivingCarDetailsByIdModelObject.data?.year}",
  //     //       carId: drivingCarDetailsByIdModelObject.data?.carsId,
  //     //       carRating: drivingCarDetailsByIdModelObject.data?.rating,
  //     //       carColorName: drivingCarDetailsByIdModelObject.data!.carsColors!.name,
  //     //       carMakesName: drivingCarDetailsByIdModelObject.data!.carsMakes!.name,
  //     //       carModelName: drivingCarDetailsByIdModelObject.data!.carsModels!.name,
  //     //       carImage: "$baseUrlImage${drivingCarDetailsByIdModelObject.data!.image1}",
  //     //       carMakesImage: "$baseUrlImage${drivingCarDetailsByIdModelObject.data!.carsMakes!.image}",
  //     //       favouriteStatus: drivingCarDetailsByIdModelObject.data!.status,
  //     //       discountPercentage: drivingCarDetailsByIdModelObject.data!.discountPercentage,
  //     //       carDiscountPrice: double.parse("${drivingCarDetailsByIdModelObject.data!.carsPlans![0].discountedPricePerSlot}"),
  //     //       carPrice: drivingCarDetailsByIdModelObject.data!.carsPlans![0].pricePerSlot,
  //     //       carOwnerImage: "$baseUrlImage${drivingCarDetailsByIdModelObject.data!.usersCompanies!.companyLogo}",
  //     //       carOwnerName: "${drivingCarDetailsByIdModelObject.data!.usersCompanies!.companyName}",
  //     //       carOwnerId: drivingCarDetailsByIdModelObject.data!.usersCompanies!.usersCompaniesId,
  //     //       myCarDescription: drivingCarDetailsByIdModelObject.data!.description,
  //     //     )));
  //     // });
  //   }
  //   // } catch (e) {
  //   //   print('Error in upcomingBookingCar: ${e.toString()}');
  //   // }
  //   loadingP = false;
  //   setState(() {});
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreviousBookingCarWidget();
  }

  TopRentedCarsModel topRentedCarsModelObject = TopRentedCarsModel();
  getTopRentedCarsWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    print('in topRenterCarModelApi');
    // try {
    String apiUrl = topRentedCarsApiUrl;
    print("topRenterCarModelApi: $apiUrl");
    final response = await http.post(Uri.parse(apiUrl),
        body: {
          "users_customers_id" : userId
        },
        headers: {
          'Accept': 'application/json'
        });
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("topRenterCarResponse : ${responseString.toString()}");
      topRentedCarsModelObject = topRentedCarsModelFromJson(responseString);
      print("topRentedCarsLength: ${topRentedCarsModelObject.data!.length}");
      for(int i = 0; i<topRentedCarsModelObject.data!.length; i++){
        if(carID == topRentedCarsModelObject.data![i].carsId) {
          print("cariddd $carID ${topRentedCarsModelObject.data![i].carsId}");
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomeDrivingBooking(
                datum: topRentedCarsModelObject.data![i],
              )));
          break;
        }
      }

    }
    // } catch (e) {
    //   print('Error: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
        : drivingPreviousObject.data?[0].carsDetails?.carsUsageType == "Driving Experience" ?
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
                itemCount: drivingPreviousObject.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  int reversedIndex =  drivingPreviousObject.data!.length - 1 - index;

                  // print("previousBookingModelObject ${previousBookingModelObject.data?.length}");
                  return Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.33)),
                      Positioned(
                        top: 90,
                        child: Padding(
                          padding: EdgeInsets.only(left: 9),
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
                                  offset: Offset(3, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    drivingPreviousObject.data![reversedIndex].status == "Completed"?
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
                                              child: Text('${drivingPreviousObject.data![reversedIndex].status}', textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 12,
                                                      fontFamily: poppinRegular, color: kWhite)),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ):
                                    drivingPreviousObject.data![reversedIndex].status == "Rejected"?
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
                                                color: Colors.orange,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Center(
                                              child: Text('${drivingPreviousObject.data![reversedIndex].status}', textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 12,
                                                      fontFamily: poppinRegular, color: kWhite)),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ):
                                    // drivingPreviousObject.data![index].status == "Cancelled"?
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
                                                color: kRed,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Center(
                                              child: Text('${drivingPreviousObject.data![reversedIndex].status}', textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 12,
                                                      fontFamily: poppinRegular, color: kWhite)),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: (){
                                        carID = drivingPreviousObject.data![reversedIndex].carsId;
                                        print("photoPreviousObject $carID");
                                        // loadingP ? Center(child: CircularProgressIndicator(color: borderColor)) :
                                        getTopRentedCarsWidget();


                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 40, right: 20),
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
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(height: 93.6),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("${drivingPreviousObject.data![reversedIndex].carsDetails!.vehicalName}  ",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 14, fontFamily: poppinBold)),

                                              Text("${drivingPreviousObject.data![reversedIndex].carsDetails!.carsColors!.name}",
                                                  textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 10, fontFamily: poppinRegular)),

                                            ],
                                          ),
                                          Row(
                                            children: [

                                              Text(
                                                "${drivingPreviousObject.data![reversedIndex].carsDetails!.carsMakes!.name}, ",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                    color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                              Text(
                                                "${drivingPreviousObject.data![reversedIndex].carsDetails!.carsModels}, ",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                    color: kBlack, fontSize: 12, fontFamily: poppinMedium)),
                                              Text("${drivingPreviousObject.data![reversedIndex].carsDetails!.year}",
                                                  textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                            ],
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 06),
                                                child: Text("RM", textAlign: TextAlign.left, style: TextStyle(
                                                    color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                                              ),
                                              Text("${drivingPreviousObject.data![reversedIndex].carsPlans![0].pricePerSlot}", textAlign: TextAlign.left, style: TextStyle(
                                                      color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                              Text("/Slot", textAlign: TextAlign.left, style: TextStyle(color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.height * 0.01,),
                                              showRatingStars(double.parse("${drivingPreviousObject.data![reversedIndex].carsDetails!.rating}")),

                                              SizedBox(
                                                width: MediaQuery.of(context).size.height * 0.01),

                                              drivingPreviousObject.data![reversedIndex].carsDetails!.rating == null?
                                              Text("0.0", textAlign: TextAlign.left,
                                                style: TextStyle(color: kBlack,
                                                    fontSize: 12, fontFamily: poppinRegular)):
                                              Text("${drivingPreviousObject.data![reversedIndex].carsDetails!.rating}", textAlign: TextAlign.left,
                                                  style: TextStyle(color: kBlack,
                                                      fontSize: 12, fontFamily: poppinRegular)),
                                            ],
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                          // verifiedDealerText(),
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
                            carID = drivingPreviousObject.data![reversedIndex].carsId;
                            carBookingsId = "${drivingPreviousObject.data![reversedIndex].bookingsId}";
                            print("clicked....");
                            print("bookingCarId $carID");
                            print("${drivingPreviousObject.data![reversedIndex].carsDetails!.vehicalName}");
                            print("${drivingPreviousObject.data![reversedIndex].carsDetails!.carsModels}");
                            print("${drivingPreviousObject.data![reversedIndex].carsDetails!.rating}");
                            print("carImage $baseUrlImage${drivingPreviousObject.data![reversedIndex].carsDetails!.image1}");
                            print("carId123 ${drivingPreviousObject.data![reversedIndex].carsId}");


                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PreviousBookingDetailsPage(
                                  bookingId: "${drivingPreviousObject.data![reversedIndex].bookingsId}",
                                  myStatus: drivingPreviousObject.data![reversedIndex].status,
                                )));

                            print("userRating ${drivingPreviousObject.data![reversedIndex].carsRatings![0].rateStars}");
                          },
                            child: Image.asset("assets/car_bookings_images/more_button.png")),
                      ),
                      Positioned(
                        left: 20,
                        child: Image.network("$baseUrlImage${drivingPreviousObject.data![reversedIndex].carsDetails!.image1}",
                            width: 332, height: 120),
                      ),
                      Positioned(
                          top: 10, left: 15,
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.07,
                            width: MediaQuery.of(context).size.width * 0.16,
                            decoration: BoxDecoration(
                              color: kRed.withOpacity(0.8),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${drivingPreviousObject.data![reversedIndex].carsDetails!.discountPercentage}",
                                  style: TextStyle(color: kWhite,
                                    fontSize: 13, fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins')),
                                Text(" OFF ", style: TextStyle(
                                  color: kWhite, fontSize: 8,
                                  fontWeight: FontWeight.w300, fontFamily: 'Poppins')),
                              ],
                            ),
                          )),

                      // Positioned(
                      //     top: 10, right: 15,
                      //     child: Image.asset("assets/car_bookings_images/heart.png",),
                      // ),
                    ],
                  );
                    // Center(child: Text('booking unavailable...',
                    //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)));
                }),
          ),
        ),
      ):
    Padding(
        padding: EdgeInsets.only(left: 100, top: 250),
        child: Text('No booking Found',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
    );
  }
}
