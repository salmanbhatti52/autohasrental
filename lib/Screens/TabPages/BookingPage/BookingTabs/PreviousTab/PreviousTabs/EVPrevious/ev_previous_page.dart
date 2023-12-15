import 'package:auto_haus_rental_app/Model/BookingModels/Previous/EvPrevious/ev_previous_model.dart';
import 'package:auto_haus_rental_app/Model/GetCarByIdModel/ev_car_details_byId_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../../HomePage/HomePageTopCard/EvSubscriptions/ev_car_description.dart';
import '../../../UpcomingTab/UpcomingTabs/EvUpcoming/ev_upcoming_page.dart';
import '../bookingsdetail/previous_bookings_details_page.dart';

class EvPreviousPage extends StatefulWidget {
   EvPreviousPage({super.key});

  @override
  State<EvPreviousPage> createState() => _EvPreviousPageState();
}

class _EvPreviousPageState extends State<EvPreviousPage> {
  EvPreviousModel evPreviousObject = EvPreviousModel();
  bool loadingP = true;

  getPreviousBookingCarWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print('in evPreviousBookingCarApi');

    // try {
      String apiUrl = bookingPreviousCarsApiUrl;
      print("evPreviousBookingApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
        'Accept': 'application/json'
          }, body: {
        "users_customers_id": userId,
        "cars_usage_type": "EV Subscriptions"
      });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("responseEvPrevious: ${responseString.toString()}");
        loadingP = false;
        setState(() {});
        evPreviousObject = evPreviousModelFromJson(responseString);
        print("evPreviousBookingLength: ${evPreviousObject.data?.length}");
      }
    // } catch (e) {
    //   print('Error in upcomingBookingCar: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPreviousBookingCarWidget();
  }

  CarDetailsByIdModel carDetailsByIdModelObject = CarDetailsByIdModel();
  getCarDetailsByIdWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print('in getCarDetailByIDApi');

    // try {
    String apiUrl = getCarDetailsByIdApiUrl;
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
      carDetailsByIdModelObject = carDetailsByIdModelFromJson(responseString);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => EVCarDescription(
              carName: carDetailsByIdModelObject.data?.vehicalName,
              carYear: "${carDetailsByIdModelObject.data?.year}",
              carId: carDetailsByIdModelObject.data?.carsId,
              carRating: carDetailsByIdModelObject.data?.rating,
              carColorName: carDetailsByIdModelObject.data!.carsColors!.name,
              carMakesName: carDetailsByIdModelObject.data!.carsMakes!.name,
              carModelName: carDetailsByIdModelObject.data!.carsModels!.name,
              carImage: carDetailsByIdModelObject.data!.image1!.endsWith('.jpg') || carDetailsByIdModelObject.data!.image1!.endsWith('.png') || carDetailsByIdModelObject.data!.image1!.endsWith('.jpeg')
                  ? "$baseUrlImage${carDetailsByIdModelObject.data?.image1}"
                  : carDetailsByIdModelObject.data?.image1,
              carMakesImage: "$baseUrlImage${carDetailsByIdModelObject.data!.carsMakes!.image}",
              favouriteStatus: carDetailsByIdModelObject.data!.status,
              discountPercentage: carDetailsByIdModelObject.data!.discountPercentage,
              carDiscountPrice: "${carDetailsByIdModelObject.data!.carsPlans![0].discountedPricePerMonth}",
              carPrice: carDetailsByIdModelObject.data!.carsPlans![0].pricePerMonth,
              carOwnerImage: "$baseUrlImage${carDetailsByIdModelObject.data!.usersCompanies!.companyLogo}",
              carOwnerName: "${carDetailsByIdModelObject.data!.usersCompanies!.companyName}",
              carOwnerId: carDetailsByIdModelObject.data!.usersCompanies!.usersCompaniesId,
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
  Widget build(BuildContext context) {
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
        : evPreviousObject.data?[0].carsDetails?.carsUsageType == "EV Subscriptions" ?
      Padding(
        padding:  EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.builder(
                shrinkWrap: true,
                physics:  BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: evPreviousObject.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  int reversedindex = evPreviousObject.data!.length - 1 - index;
                  String priceString = evPreviousObject.data![reversedindex].carsPlans![0].pricePerMonth.toString();
                  double price = double.parse(priceString);
                  NumberFormat format = NumberFormat('#,##0.00', 'en_US');
                  String formattedPrice = format.format(price);
                  // print("previousBookingModelObject ${previousBookingModelObject.data?.length}");
                  return Stack(
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.33)),
                      Positioned(
                        top: 90,
                        left: 30,
                        right: 30,
                        child: Padding(
                          padding:  EdgeInsets.only(left: 9),
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
                                  offset:  Offset(3, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    evPreviousObject.data![reversedindex].status == "Completed"?
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.1,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding:  EdgeInsets.only(top: 40, left: 20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: 100, height: 30,
                                            decoration: BoxDecoration(
                                                color: colorGreen,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Center(
                                              child: Text('${evPreviousObject.data![reversedindex].status}', textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 12,
                                                      fontFamily: poppinRegular, color: kWhite)),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ):
                                    evPreviousObject.data![reversedindex].status == "Rejected"?
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.1,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding:  EdgeInsets.only(top: 40, left: 20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: 100, height: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Center(
                                              child: Text('${evPreviousObject.data![reversedindex].status}', textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 12,
                                                      fontFamily: poppinRegular, color: kWhite)),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ):
                                    evPreviousObject.data![reversedindex].status == "Accepted"?
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.1,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding:  EdgeInsets.only(top: 40, left: 20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: 100, height: 30,
                                            decoration: BoxDecoration(
                                                color: colorGreen,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Center(
                                              child: Text('${evPreviousObject.data![reversedindex].status}', textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 12,
                                                      fontFamily: poppinRegular, color: kWhite)),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ):
                                    evPreviousObject.data![reversedindex].status == "Pending"?
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.1,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding:  EdgeInsets.only(top: 40, left: 20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: 100, height: 30,
                                            decoration: BoxDecoration(
                                                color: borderColor,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Center(
                                              child: Text('${evPreviousObject.data![reversedindex].status}', textAlign: TextAlign.center,
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
                                        padding:  EdgeInsets.only(top: 40, left: 20),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: 100, height: 30,
                                            decoration: BoxDecoration(
                                                color: kRed,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Center(
                                              child: Text('${evPreviousObject.data![reversedindex].status}', textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 12,
                                                      fontFamily: poppinRegular, color: kWhite)),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: (){
                                        carID = evPreviousObject.data![reversedindex].carsId;
                                        print("photoPreviousObject $carID");
                                        getCarDetailsByIdWidget();
                                      },

                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding:  EdgeInsets.only(top: 40, right: 20),
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
                                      padding:  EdgeInsets.symmetric(horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("${evPreviousObject.data![reversedindex].carsDetails!.vehicalName}  ",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 14, fontFamily: poppinBold)),

                                              Text("${evPreviousObject.data![reversedindex].carsDetails!.carsColors!.name}",
                                                  textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 10, fontFamily: poppinRegular)),

                                            ],
                                          ),
                                          Row(
                                            children: [

                                              Text(
                                                "${evPreviousObject.data![reversedindex].carsDetails!.carsMakes!.name}, ",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                    color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                              Text(
                                                "${evPreviousObject.data![reversedindex].carsDetails!.carsModels}, ",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                    color: kBlack, fontSize: 12, fontFamily: poppinMedium)),
                                              Text("${evPreviousObject.data![reversedindex].carsDetails!.year}",
                                                  textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                            ],
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(top: 06),
                                                child: Text("RM", textAlign: TextAlign.left, style: TextStyle(
                                                    color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                                              ),
                                              Text("${formattedPrice}", textAlign: TextAlign.left, style: TextStyle(
                                                      color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                              Text("/", textAlign: TextAlign.left, style: TextStyle(color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                                              // SizedBox(
                                              //   width: MediaQuery.of(context).size.height * 0.01,),
                                              //
                                              // showRatingStars(double.parse("${evPreviousObject.data![reversedindex].carsDetails!.rating}")),
                                              // SizedBox(
                                              //   width: MediaQuery.of(context).size.height * 0.01),
                                              //
                                              // evPreviousObject.data![reversedindex].carsDetails!.rating == null?
                                              // Text("0.0", textAlign: TextAlign.left,
                                              //   style: TextStyle(color: kBlack,
                                              //       fontSize: 12, fontFamily: poppinRegular)):
                                              // Text("${evPreviousObject.data![reversedindex].carsDetails!.rating}", textAlign: TextAlign.left,
                                              //     style: TextStyle(color: kBlack,
                                              //         fontSize: 12, fontFamily: poppinRegular)),
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
                        right: 30, bottom: 30,
                        child: GestureDetector(
                          onTap: (){
                            carID = evPreviousObject.data![reversedindex].carsId;
                            carBookingsId = "${evPreviousObject.data![reversedindex].bookingsId}";
                            print("bookingCarId $carID $carBookingsId");
                            print("${evPreviousObject.data![reversedindex].carsDetails!.vehicalName}");
                            print("${evPreviousObject.data![reversedindex].carsDetails!.carsModels}");
                            print("${evPreviousObject.data![reversedindex].carsDetails!.rating}");

                            // evPreviousObject.data![index].status == "Completed"?
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PreviousBookingDetailsPage(
                                  myStatus: evPreviousObject.data![reversedindex].status,
                                  bookingId: "${evPreviousObject.data![reversedindex].bookingsId}",
                                )));
                                // : print("not completed");

                          },
                            child: Image.asset("assets/car_bookings_images/more_button.png")),
                      ),
                      // Positioned(
                      //   left: 20, right: 20,top: 30,
                      //   child: Image.network("$baseUrlImage${evPreviousObject.data![reversedindex].carsDetails!.image1}",
                      //       width: MediaQuery.of(context).size.width * 0.3,
                      //       height: MediaQuery.of(context).size.height * 0.1),
                      // ),
                      Positioned(
                        left: 20, right: 20,top: 0,
                        child: evPreviousObject.data![reversedindex].carsDetails!.image1 == null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/icon/fade_in_image.jpeg'),
                        )
                            : evPreviousObject.data![reversedindex].carsDetails!.image1!.endsWith('.jpg') || evPreviousObject.data![reversedindex].carsDetails!.image1!.endsWith('.png') || evPreviousObject.data![reversedindex].carsDetails!.image1!.endsWith('.jpeg')
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            placeholder: AssetImage("assets/icon/fade_in_image.jpeg"),
                            height: 65,
                            image: NetworkImage("$baseUrlImage${evPreviousObject.data![reversedindex].carsDetails!.image1}"),
                          ),
                        )
                            : Container(
                          height: MediaQuery.of(context).size.height * 0.19,
                          child: ModelViewer(
                            // cameraOrbit: Clipboard.kTextPlain,
                            backgroundColor: Colors.transparent,
                            src: '${evPreviousObject.data![reversedindex].carsDetails!.image1}',
                            alt: "A 3D model of car",
                            autoPlay: false,
                            autoRotate: false,
                            cameraControls: false,
                            disableTap: false,
                            ar: false,
                            disablePan: true,
                            arModes: ["quicklook", "scene-viewer"],
                            iosSrc: "${evPreviousObject.data![reversedindex].carsDetails!.image1}",
                            disableZoom: true,
                          ),
                        ),
                      ),
                      evPreviousObject.data![reversedindex].carsDetails!.discountPercentage != "0.00"
                      ? Positioned(
                          top: 10, left: 15,
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.07,
                            width: MediaQuery.of(context).size.width * 0.16,
                            decoration: BoxDecoration(
                              color: kRed.withOpacity(0.8),
                              borderRadius:  BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${evPreviousObject.data![reversedindex].carsDetails!.discountPercentage}",
                                  style: TextStyle(color: kWhite,
                                    fontSize: 13, fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins')),
                                Text(" OFF ", style: TextStyle(
                                  color: kWhite, fontSize: 8,
                                  fontWeight: FontWeight.w300, fontFamily: 'Poppins')),
                              ],
                            ),
                          ))
                      : Positioned(top: 10, left: 15, child: SizedBox()),

                      // Positioned(
                      //     top: 10, right: 15,
                      //     child: Image.asset("assets/car_bookings_images/heart.png",),
                      // ),
                    ],
                  );
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
}
