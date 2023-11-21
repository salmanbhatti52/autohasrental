
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Model/GetCarByIdModel/photo_car_details_byId_model.dart';
import 'package:auto_haus_rental_app/Model/BookingModels/Previous/Photo/photo_previous_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/HomePageTopCard/BookForWedding/book_for_wedding_car_description.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/BookingPage/BookingTabs/UpcomingTab/UpcomingTabs/EvUpcoming/ev_upcoming_page.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/BookingPage/BookingTabs/PreviousTab/PreviousTabs/bookingsdetail/previous_bookings_details_page.dart';

class PhotoPreviousPage extends StatefulWidget {
  PhotoPreviousPage({super.key});

  @override
  State<PhotoPreviousPage> createState() => _PhotoPreviousPageState();
}

class _PhotoPreviousPageState extends State<PhotoPreviousPage> {
  PhotoPreviousModel photoPreviousObject = PhotoPreviousModel();
  CarDetailsByIdModelPhoto carDetailsByIdModelObject = CarDetailsByIdModelPhoto();
  bool loadingP = true;

  getPhotoPreviousWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print('in previousBookingCarApi');

    // try {
      String apiUrl = bookingPreviousCarsApiUrl;
      print("upcomingBookingCarModelApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Accept': 'application/json'
      }, body: {
        "users_customers_id": userId,
        "cars_usage_type": "Photography"
      });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("responsePreviousBookingCar: ${responseString.toString()}");
        loadingP = false;
        setState(() {});
        photoPreviousObject = photoPreviousModelFromJson(responseString);
        print("PhotographyBookingLength: ${photoPreviousObject.data?.length}");
      }
    // } catch (e) {
    //   print('Error in upcomingBookingCar: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

  getCarDetailsByIdWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print('in getCarDetailByIDApi');

    // try {
    String apiUrl = getCarDetailsByIdApiUrl;
    print("getCarID: $carID");
    print("getCarDetailByIDApi: $apiUrl");

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      "cars_id": "$carID",
    });
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("responseGetCarDetailByID: ${responseString.toString()}");
      carDetailsByIdModelObject = carDetailsByIdModelPhotoFromJson(responseString);
      // Future.delayed(Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => BookForWeddingCarDescription(
            carName: carDetailsByIdModelObject.data?.vehicalName,
            carYear: "${carDetailsByIdModelObject.data?.year}",
            carId: carDetailsByIdModelObject.data?.carsId,
            carRating: carDetailsByIdModelObject.data?.rating,
            carColorName: carDetailsByIdModelObject.data!.carsColors.name,
            carMakesName: carDetailsByIdModelObject.data!.carsMakes.name,
            carModelName: carDetailsByIdModelObject.data!.carsModels.name,
            carImage: "$baseUrlImage${carDetailsByIdModelObject.data!.image1}",
            carMakesImage: "$baseUrlImage${carDetailsByIdModelObject.data!.carsMakes.image}",
            favouriteStatus: carDetailsByIdModelObject.data!.status,
            discountPercentage: carDetailsByIdModelObject.data!.discountPercentage,
            carDiscountPrice: "${carDetailsByIdModelObject.data!.carsPlans[0].discountedPricePerHour}",
            carPrice: carDetailsByIdModelObject.data!.carsPlans[0].pricePerHour,
            carOwnerImage: "$baseUrlImage${carDetailsByIdModelObject.data!.usersCompanies.companyLogo}",
            carOwnerName: "${carDetailsByIdModelObject.data!.usersCompanies.companyName}",
            carOwnerId: carDetailsByIdModelObject.data!.usersCompanies.usersCompaniesId,
            myCarDescription: carDetailsByIdModelObject.data!.description,
          )));
      // });
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
    getPhotoPreviousWidget();
  }

  String? bookingCompleteStatus;

  @override
  Widget build(BuildContext context) {
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
        : photoPreviousObject.data?[0].carsDetails?.carsUsageType == "Photography" ?
      Padding(
        padding: EdgeInsets.only(top: 15),
        child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.67,
          child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: photoPreviousObject.data!.length,
              itemBuilder: (BuildContext context, int Index) {
                int reversedindex = photoPreviousObject.data!.length - 1 - Index;
                // print("previousBookingModelObject ${previousBookingModelObject.data?.length}");
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.33)),
                    Positioned(
                      top: 90,
                      left: 30,
                      right: 30,
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

                                  photoPreviousObject.data![reversedindex].status == "Completed"?
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
                                            child: Text('${photoPreviousObject.data![reversedindex].status}', textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 12,
                                                    fontFamily: poppinRegular, color: kWhite)),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ):
                                  photoPreviousObject.data![reversedindex].status == "Rejected"?
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
                                            child: Text('${photoPreviousObject.data![reversedindex].status}', textAlign: TextAlign.center,
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
                                              color: kRed,
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child: Center(
                                            child: Text('${photoPreviousObject.data![reversedindex].status}', textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 12,
                                                    fontFamily: poppinRegular, color: kWhite)),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(),
                                  GestureDetector(
                                    onTap: () {
                                      carID = photoPreviousObject.data![reversedindex].carsId;
                                      print("photoPreviousObject $carID");
                                      getCarDetailsByIdWidget();

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
                                            Text("${photoPreviousObject.data![reversedindex].carsDetails!.vehicalName}  ",
                                              textAlign: TextAlign.left, style: TextStyle(
                                                    color: kBlack, fontSize: 14, fontFamily: poppinBold)),

                                            Text("${photoPreviousObject.data![reversedindex].carsDetails!.carsColors!.name}",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                    color: kBlack, fontSize: 10, fontFamily: poppinRegular)),

                                          ],
                                        ),
                                        Row(
                                          children: [

                                            Text(
                                              "${photoPreviousObject.data![reversedindex].carsDetails!.carsMakes!.name}, ",
                                              textAlign: TextAlign.left, style: TextStyle(
                                                  color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                            Text(
                                              "${photoPreviousObject.data![reversedindex].carsDetails!.carsModels}, ",
                                              textAlign: TextAlign.left, style: TextStyle(
                                                  color: kBlack, fontSize: 12, fontFamily: poppinMedium)),
                                            Text("${photoPreviousObject.data![reversedindex].carsDetails!.year}",
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
                                            Text("${photoPreviousObject.data![reversedindex].carsPlans![0].pricePerHour}", textAlign: TextAlign.left, style: TextStyle(
                                                    color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                            Text("/Hour", textAlign: TextAlign.left, style: TextStyle(color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.height * 0.01,),
                                            SizedBox(width: MediaQuery.of(context).size.height * 0.01),

                                            showRatingStars(double.parse("${photoPreviousObject.data![reversedindex].carsDetails!.rating}")),

                                            SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                            photoPreviousObject.data![reversedindex].carsDetails!.rating == null?
                                            Text("0.0", textAlign: TextAlign.left,
                                              style: TextStyle(color: kBlack,
                                                  fontSize: 12, fontFamily: poppinRegular)):
                                            Text("${photoPreviousObject.data![reversedindex].carsDetails!.rating}", textAlign: TextAlign.left,
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
                      right: 30  , bottom: 30,
                      child: GestureDetector(
                        onTap: (){
                          carID = photoPreviousObject.data![reversedindex].carsId;
                          carBookingsId = "${photoPreviousObject.data![reversedindex].bookingsId}";
                          bookingCompleteStatus = photoPreviousObject.data![reversedindex].status;
                          print("bookingCarId $carID");
                          print("bookingCompleteStatus $bookingCompleteStatus");
                          print("${photoPreviousObject.data![reversedindex].carsDetails!.vehicalName}");
                          print("${photoPreviousObject.data![reversedindex].carsDetails!.carsModels}");
                          print("${photoPreviousObject.data![reversedindex].carsDetails!.rating}");

                          // photoPreviousObject.data![index].status == "Completed"?
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => PreviousBookingDetailsPage(
                                myStatus: photoPreviousObject.data![reversedindex].status,
                                bookingId: "${photoPreviousObject.data![reversedindex].bookingsId}"
                              )));
                              // : print("not completed");
                          print("userRating ${photoPreviousObject.data![reversedindex].carsRatings![0].rateStars}");
                        },
                          child: Image.asset("assets/car_bookings_images/more_button.png")),
                    ),
                    Positioned(
                      left: 20, right: 20,top: 30,
                      child: Image.network("$baseUrlImage${photoPreviousObject.data![reversedindex].carsDetails!.image1}",
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.1),
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
                              Text("${photoPreviousObject.data![reversedindex].carsDetails!.discountPercentage}",
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
              }),
        ),
      ):
    Padding(
        padding: EdgeInsets.only(left: 100, top: 250),
        child: Text('No booking Found',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
    );
  }
}
