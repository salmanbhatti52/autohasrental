import 'package:auto_haus_rental_app/Model/BookingModels/Previous/Photo/photo_previous_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../DrivingPrevious/driving_booking_detail.dart';

class PhotoPreviousPage extends StatefulWidget {
  const PhotoPreviousPage({super.key});

  @override
  State<PhotoPreviousPage> createState() => _PhotoPreviousPageState();
}

class _PhotoPreviousPageState extends State<PhotoPreviousPage> {
  PhotoPreviousModel photoPreviousObject = PhotoPreviousModel();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhotoPreviousWidget();
  }

  @override
  Widget build(BuildContext context) {
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
        : photoPreviousObject.data?[0].carsDetails?.carsUsageType == "Photography" ?
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.67,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: photoPreviousObject.data!.length,
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

                                    photoPreviousObject.data![index].status == "Completed"?
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
                                              child: Text('${photoPreviousObject.data![index].status}', textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 12,
                                                      fontFamily: poppinRegular, color: kWhite)),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ):
                                    photoPreviousObject.data![index].status == "Rejected"?
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
                                                color: Colors.orange,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Center(
                                              child: Text('${photoPreviousObject.data![index].status}', textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 12,
                                                      fontFamily: poppinRegular, color: kWhite)),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ):
                                    // photoPreviousObject.data![index].status == "Cancelled"?
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
                                                color: kRed,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Center(
                                              child: Text('${photoPreviousObject.data![index].status}', textAlign: TextAlign.center,
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
                                              Text("${photoPreviousObject.data![index].carsDetails!.vehicalName}  ",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 14, fontFamily: poppinBold)),

                                              Text("${photoPreviousObject.data![index].carsDetails!.carsColors!.name}",
                                                  textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 10, fontFamily: poppinRegular)),

                                            ],
                                          ),
                                          Row(
                                            children: [

                                              Text(
                                                "${photoPreviousObject.data![index].carsDetails!.carsMakes}, ",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                    color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                              Text(
                                                "${photoPreviousObject.data![index].carsDetails!.carsModels}, ",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                    color: kBlack, fontSize: 12, fontFamily: poppinMedium)),
                                              Text("${photoPreviousObject.data![index].carsDetails!.year}",
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
                                              Text("${photoPreviousObject.data![index].carsPlans![0].pricePerHour}", textAlign: TextAlign.left, style: TextStyle(
                                                      color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                              Text("/Hour", textAlign: TextAlign.left, style: TextStyle(color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.height * 0.01,),
                                              // Image.asset("assets/car_bookings_images/rating_stars.png"),
                                              SizedBox(width: MediaQuery.of(context).size.height * 0.01),

                                              showRatingStars(double.parse("${photoPreviousObject.data![index].carsDetails!.rating}")),

                                              SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                              photoPreviousObject.data![index].carsDetails!.rating == null?
                                              Text("0.0", textAlign: TextAlign.left,
                                                style: TextStyle(color: kBlack,
                                                    fontSize: 12, fontFamily: poppinRegular)):
                                              Text("${photoPreviousObject.data![index].carsDetails!.rating}", textAlign: TextAlign.left,
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
                            print("clicked....");
                            print("${photoPreviousObject.data![index].carsDetails!.vehicalName}");
                            print("${photoPreviousObject.data![index].carsDetails!.carsModels}");
                            print("${photoPreviousObject.data![index].carsDetails!.rating}");

                            photoPreviousObject.data![index].status == "Completed"?
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => DrivingBookingDetail(
                                  carId: "${photoPreviousObject.data![index].carsId}",
                                  carName: photoPreviousObject.data![index].carsDetails!.vehicalName,
                                  carYear: "${photoPreviousObject.data![index].carsDetails!.year}",
                                  carColors: photoPreviousObject.data![index].carsDetails!.carsColors!.name,
                                  carMakes: photoPreviousObject.data![index].carsDetails!.carsMakes,
                                  carModel: photoPreviousObject.data![index].carsDetails!.carsModels,
                                  carRating: photoPreviousObject.data![index].carsDetails!.rating,
                                  carPrice: photoPreviousObject.data![index].carsPlans![0].pricePerHour,
                                  discountPercentage: photoPreviousObject.data![index].carsDetails!.discountPercentage,
                                  carImage: "$baseUrlImage${photoPreviousObject.data![index].carsDetails!.image1}",
                                  carDesc: photoPreviousObject.data![index].carsDetails!.description,
                                  userRating: photoPreviousObject.data![index].carsRatings![0].rateStars,
                                  userComment: photoPreviousObject.data![index].carsRatings![0].comments,

                                  // datum: photoPreviousObject.data![index],
                                  // carDesc: photoPreviousObject.data![index].carsDetails!.description,
                                )))
                                : print("not completed");
                            print("userRating ${photoPreviousObject.data![index].carsRatings![0].rateStars}");
                          },
                            child: Image.asset("assets/car_bookings_images/more_button.png")),
                      ),
                      Positioned(
                        left: 20,
                        child: Image.network("$baseUrlImage${photoPreviousObject.data![index].carsDetails!.image1}",
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
                                Text("${photoPreviousObject.data![index].carsDetails!.discountPercentage}",
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
                          child: Image.asset("assets/car_bookings_images/heart.png",),
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
