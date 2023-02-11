import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Model/HomePageModels/BookingModels/booking_upcoming_model.dart';
import 'upcoming_bookings_details_page.dart';
import 'package:http/http.dart' as http;

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({super.key});

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  UpcomingBookingModel upcomingBookingModelObject = UpcomingBookingModel();
  bool loadingP = true;
  sharedPrefs() async {
    loadingP = true;
    setState(() {});
    print('in UpcomingBookingCar sharedPrefs');
    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print("userId in UpcomingBookingCar is = $userId");
    setState(() {
      getUpcomingBookingCarWidget();
    });
  }

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
        "users_customers_id": userId
      });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("responseUpcomingBookingCar: ${responseString.toString()}");
        loadingP = false;
        setState(() {});
        upcomingBookingModelObject = upcomingBookingModelFromJson(responseString);
        print("upcomingBookingCarLength: ${upcomingBookingModelObject.data!.length}");
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
    sharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return loadingP ? Center(
        child: CircularProgressIndicator(color: borderColor)) :
    upcomingBookingModelObject.status != "success" ? const Center(
      child: Text('booking unavailable....', style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20))) :
    GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(
        //     builder: (context) => const UpcomingBookingDetailPage()));
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
                itemCount: upcomingBookingModelObject.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.33),
                      ),
                      Positioned(
                        top: 90,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.24,
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
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              width: 100, height: 30,
                                              decoration: BoxDecoration(
                                                color: borderColor,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: Center(
                                                child: Text('${upcomingBookingModelObject.data![index].status}', style: TextStyle(fontSize: 12,
                                                    fontFamily: poppinRegular, color: kWhite)),
                                              ),
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
                                          child: GestureDetector(
                                            onTap: () {
                                              print("cancel Clicked");
                                              },
                                            child: Container(
                                              width: 100, height: 30,
                                              decoration: BoxDecoration(
                                                color: kRed,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: Center(
                                                child: Text('Cancel', style: TextStyle(fontSize: 12,
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
                                    const SizedBox(height: 93.6),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("${upcomingBookingModelObject.data![index].carsDetails!.vehicalName} ",
                                                style: TextStyle(color: kBlack, fontSize: 14, fontFamily: poppinBold,),
                                                textAlign: TextAlign.left,
                                              ),

                                              Text("${upcomingBookingModelObject.data![index].carsDetails!.carsColors!.name}",
                                                style: TextStyle(color: kBlack,
                                                  fontSize: 10, fontFamily: poppinRegular),
                                                textAlign: TextAlign.left),
                                            ],
                                          ),
                                          Row(
                                            children: [

                                              Text("${upcomingBookingModelObject.data![index].carsDetails!.carsMakes}, ",
                                                style: TextStyle(color: kBlack, fontSize: 12, fontFamily: poppinRegular),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text("${upcomingBookingModelObject.data![index].carsDetails!.carsModels}, ",
                                                style: TextStyle(color: kBlack, fontSize: 12, fontFamily: poppinMedium),
                                                textAlign: TextAlign.left),
                                              Text("${upcomingBookingModelObject.data![index].carsDetails!.year}",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                      color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                            ],
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 06),
                                                child: Text("RM", textAlign: TextAlign.left,
                                                  style: TextStyle(color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                                              ),

                                              // if(upcomingBookingModelObject.data![index].carsPlans![0].pricePerMonth == "1"){
                                              //   Text("0.0", style: TextStyle(color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                              // }else if (upcomingBookingModelObject.data![index].carsPlans![0].pricePerMonth == "2"){
                                              //   Text("0.0", textAlign: TextAlign.left,
                                              //       style: TextStyle(color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                              // }
                                              // else if (upcomingBookingModelObject.data![index].carsPlans![0].pricePerMonth == "3"){
                                              //   Text("0.0", textAlign: TextAlign.left,
                                              //       style: TextStyle(color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                              // }else{
                                              //
                                              //   },


                                              upcomingBookingModelObject.data![index].carsPlans![0].pricePerMonth ==
                                                  upcomingBookingModelObject.data![index].carsPlans![0].pricePerMonth?
                                              Text("${upcomingBookingModelObject.data![index].carsPlans![0].pricePerMonth}",
                                                  style: TextStyle(color: borderColor, fontSize: 16, fontFamily: poppinSemiBold),
                                                  textAlign: TextAlign.left):
                                              Text("${upcomingBookingModelObject.data![index].carsPlans![0].pricePerSlot}",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                    color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                              // Text("/ Month",  textAlign: TextAlign.left, style: TextStyle(
                                              //     color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                                              SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                              Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
                                              SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                              upcomingBookingModelObject.data![index].carsDetails!.rating == null?
                                              Text("0.0",
                                                  style: TextStyle(color: kBlack, fontSize: 12, fontFamily: poppinRegular,),
                                                  textAlign: TextAlign.left):
                                              Text("${upcomingBookingModelObject.data![index].carsDetails!.rating}",
                                                  style: TextStyle(color: kBlack, fontSize: 12, fontFamily: poppinRegular,),
                                                  textAlign: TextAlign.left),
                                            ],
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                          Row(
                                            children: [
                                              Image.asset("assets/car_bookings_images/promoted.png"),
                                              const SizedBox(width: 5),
                                              Text("Verified Dealer",  textAlign: TextAlign.left,
                                                  style: TextStyle(color: textLabelColor,
                                                      fontSize: 10, fontFamily: poppinRegular)),
                                              const SizedBox(width: 05),
                                              Container(
                                                height: 15, width: 35,
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
                          child: Image.asset("assets/car_bookings_images/more_button.png")),


                      Positioned(
                        left: 20, right: 20,
                        child: upcomingBookingModelObject.data![index].carsDetails!.image1 == null ?
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset('assets/icon/fade_in_image.jpeg'))
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            placeholder: const AssetImage("assets/icon/fade_in_image.jpeg"),
                            width: 332, height: 120,
                            image: NetworkImage("$baseUrlImage${upcomingBookingModelObject.data![index].carsDetails!.image1}"),
                          ),
                        ),
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
                                Text("${upcomingBookingModelObject.data![index].carsDetails!.discountPercentage}",
                                    style: TextStyle(color: kWhite, fontSize: 13, fontFamily: poppinSemiBold)),
                                Text(" OFF ", textAlign: TextAlign.left,
                                    style: TextStyle(color: kWhite,
                                      fontSize: 8, fontFamily: poppinRegular,)),
                              ],
                            ),
                          )),
                      Positioned(
                        top: 10, right: 15,
                        child: Image.asset("assets/car_bookings_images/heart.png"),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

   showPrice(index){
    if(upcomingBookingModelObject.data![index].carsPlans![0].pricePerMonth == "1"){
      Text("0.0", style: TextStyle(color: borderColor, fontSize: 16, fontFamily: poppinSemiBold));
    }else if (upcomingBookingModelObject.data![index].carsPlans![0].pricePerMonth == "2"){
    Text("0.0", textAlign: TextAlign.left,
    style: TextStyle(color: borderColor, fontSize: 16, fontFamily: poppinSemiBold));
    }
    else if (upcomingBookingModelObject.data![index].carsPlans![0].pricePerMonth == "3"){
    Text("0.0", textAlign: TextAlign.left,
    style: TextStyle(color: borderColor, fontSize: 16, fontFamily: poppinSemiBold));
    }
  }

  myProductPriceText(myText){
    return Text("$myText",
        style: TextStyle(color: borderColor, fontSize: 16, fontFamily: poppinSemiBold,),
        textAlign: TextAlign.left);
  }
}
