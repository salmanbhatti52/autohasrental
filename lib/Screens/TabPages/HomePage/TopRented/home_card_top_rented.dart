import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../Model/HomePageModels/top_rented_cars_model.dart';
import '../HomePageTopCard/BookForWedding/book_for_wedding_car_description.dart';
import '../HomePageTopCard/EvSubscriptions/ev_car_description.dart';
import 'Driving_Home/home_driving_booking.dart';

class HomeCardTopRented extends StatefulWidget {
  const HomeCardTopRented({Key? key}) : super(key: key);

  @override
  State<HomeCardTopRented> createState() => _HomeCardTopRentedState();
}

class _HomeCardTopRentedState extends State<HomeCardTopRented> {
  TopRentedCarsModel topRentedCarsModelObject = TopRentedCarsModel();


  String? userFirstName, userLastName, userImage;
  sharedPrefs() async {
    loadingP = true;
    setState(() {});
    print('in shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    userFirstName = (prefs!.getString('user_first_name'));
    userLastName = (prefs!.getString('user_last_name'));
    userImage = (prefs!.getString('profile_pic'));
    print("userId in HomePage = $userId");
    print("userName in HomePage = $userFirstName $userLastName");
    print("userImage in HomePage = $baseUrlImage$userImage");
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    sharedPrefs();
    getTopRentedCarsWidget();
  }
  bool loadingP = true;

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
          headers: {'Accept': 'application/json'});
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("topRenterCarResponse : ${responseString.toString()}");
        topRentedCarsModelObject = topRentedCarsModelFromJson(responseString);
        print("topRentedCarsLength: ${topRentedCarsModelObject.data!.length}");
      }
    // } catch (e) {
    //   print('Error: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
          : topRentedCarsModelObject.status != "success" ? const Center(
          child: Text('no data found...', style: TextStyle(fontWeight: FontWeight.bold))) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            color: Colors.transparent,
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.5,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                ),
                itemCount: topRentedCarsModelObject.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 50,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.275,
                              width: MediaQuery.of(context).size.width * 0.47,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                                    Row(
                                      children: [
                                        Text("${topRentedCarsModelObject.data![index].vehicalName} ",
                                            style: TextStyle(color: kBlack,
                                                fontSize: 10, fontFamily: poppinBold)),
                                        Text("${topRentedCarsModelObject.data![index].carsColors!.name} ",
                                            style: TextStyle(color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Row(
                                      children: [
                                        Text("${topRentedCarsModelObject.data![index].carsMakes!.name}, ",
                                            style: TextStyle(color: kBlack, fontSize: 7, fontFamily: poppinRegular)),
                                        Text("${topRentedCarsModelObject.data![index].carsModels!.name}, ",
                                            style: TextStyle(color: kBlack, fontSize: 7, fontFamily: poppinSemiBold)),
                                        Text("${topRentedCarsModelObject.data![index].year} ",
                                            style: TextStyle(color: kBlack, fontSize: 7, fontFamily: poppinRegular)),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 04),
                                              child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                                                  color: kRed, fontSize: 5, fontFamily: poppinLight)),
                                            ),
                                            topRentedCarsModelObject.data![index].carsUsageType == "EV Subscriptions" ?
                                            Text("${topRentedCarsModelObject.data![index].carsPlans![0].pricePerMonth}",
                                                style: TextStyle(color: kRed, decoration: TextDecoration.lineThrough,
                                                    fontSize: 8, fontFamily: poppinMedium)) :
                                            topRentedCarsModelObject.data![index].carsUsageType == "Photography" ?
                                            Text("${topRentedCarsModelObject.data![index].carsPlans![0].pricePerHour}",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                    color: kRed, decoration: TextDecoration.lineThrough,
                                                    fontSize: 8, fontFamily: poppinLight)):
                                            Text("${topRentedCarsModelObject.data![index].carsPlans![0].pricePerSlot}",
                                                textAlign: TextAlign.left, style: TextStyle(
                                                    color: kRed, decoration: TextDecoration.lineThrough,
                                                    fontSize: 8, fontFamily: poppinLight)),
                                          ],
                                        ),
                                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 04),
                                              child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                                                  color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                                            ),
                                            topRentedCarsModelObject.data![index].carsUsageType == "EV Subscriptions" ?
                                            Row(
                                              children: [
                                                Text("${topRentedCarsModelObject.data![index].carsPlans![0].discountedPricePerMonth}/",
                                                    style: TextStyle(color: borderColor, fontSize: 12, fontFamily: poppinBold)),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5),
                                                  child: Text("Month ", textAlign: TextAlign.left, style: TextStyle(
                                                      color: borderColor, fontSize: 8, fontFamily: poppinSemiBold)),
                                                ),
                                              ],
                                            ) :
                                            topRentedCarsModelObject.data![index].carsUsageType == "Photography" ?
                                            Row(
                                              children: [
                                                Text("${topRentedCarsModelObject.data![index].carsPlans![0].discountedPricePerHour}/",
                                                    textAlign: TextAlign.left, style: TextStyle(
                                                        fontSize: 12, fontFamily: poppinBold, color: borderColor)),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5),
                                                  child: Text("Hour ", textAlign: TextAlign.left, style: TextStyle(
                                                      color: borderColor, fontSize: 8, fontFamily: poppinSemiBold)),
                                                ),
                                              ],
                                            ):
                                            Row(
                                              children: [
                                                Text("${topRentedCarsModelObject.data![index].carsPlans![0].discountedPricePerSlot}/",
                                                    textAlign: TextAlign.left, style: TextStyle(
                                                        color: borderColor, fontSize: 12, fontFamily: poppinBold)),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5),
                                                  child: Text("Slot ", textAlign: TextAlign.left, style: TextStyle(
                                                      color: borderColor, fontSize: 8, fontFamily: poppinSemiBold)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    // SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                                    Row(
                                      children: [
                                        showRatingStars(double.parse("${topRentedCarsModelObject.data![index].rating}")),
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.005),
                                        topRentedCarsModelObject.data![index].rating == null
                                            ? Text("0.0", style: TextStyle(
                                            color: kBlack, fontSize: 10, fontFamily: poppinMedium))
                                            : Text("${topRentedCarsModelObject.data![index].rating}",
                                            style: TextStyle(color: kBlack, fontSize: 10, fontFamily: poppinMedium)),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset("assets/home_page/Promoted.png"),
                                            const SizedBox(width: 05),
                                            Text("Verified Dealer", textAlign: TextAlign.left,
                                                style: TextStyle(color: textLabelColor,
                                                    fontSize: 10, fontFamily: poppinRegular)),
                                          ],
                                        ),
                                        Container(
                                          height: 17, width: 35,
                                          decoration: BoxDecoration(
                                              color: kBlack,
                                              borderRadius: BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text("New", textAlign: TextAlign.left, style: TextStyle(
                                                color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                                    GestureDetector(
                                      onTap: () {
                                        carID = topRentedCarsModelObject.data![index].carsId;
                                        print("cardId $carID");
                                        print("carsUsageType ${topRentedCarsModelObject.data![index].carsUsageType}");

                                        if(topRentedCarsModelObject.data![index].carsUsageType == "EV Subscriptions"){
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => EVCarDescription(
                                                carName: topRentedCarsModelObject.data![index].vehicalName,
                                                carPrice: topRentedCarsModelObject.data![index].carsPlans![0].pricePerMonth,
                                                carImage: "$baseUrlImage${topRentedCarsModelObject.data![index].image1}",
                                                carYear: "${topRentedCarsModelObject.data![index].year}",
                                                carId: topRentedCarsModelObject.data![index].carsId,
                                                carRating: topRentedCarsModelObject.data![index].rating,
                                                carColorName: topRentedCarsModelObject.data![index].carsColors!.name,
                                                carMakesName: topRentedCarsModelObject.data![index].carsMakes!.name,
                                                carModelName: topRentedCarsModelObject.data![index].carsModels!.name,
                                                carMakesImage: "$baseUrlImage${topRentedCarsModelObject.data![index].carsMakes!.image}",
                                                carStatus: topRentedCarsModelObject.data![index].favouriteStatus,
                                                discountPercentage: topRentedCarsModelObject.data![index].discountPercentage,
                                                carDiscountPrice: double.parse("${topRentedCarsModelObject.data![index].carsPlans![0].discountedPricePerMonth}"),
                                                carOwnerImage: "$baseUrlImage${topRentedCarsModelObject.data![index].usersCompanies!.companyLogo}",
                                                carOwnerName: "${topRentedCarsModelObject.data![index].usersCompanies!.companyName}",
                                                carOwnerId: topRentedCarsModelObject.data![index].usersCompanies!.usersCompaniesId,
                                                myCarDescription: topRentedCarsModelObject.data![index].description,
                                                myCarRating: topRentedCarsModelObject.data![index].carsRatings![0].rateStars,
                                                myCarComment: topRentedCarsModelObject.data![index].carsRatings![0].comments,
                                              )));
                                        }
                                        else if(topRentedCarsModelObject.data![index].carsUsageType == "Photography"){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => BookForWeddingCarDescription(
                                                carName: topRentedCarsModelObject.data![index].vehicalName,
                                                carYear: "${topRentedCarsModelObject.data![index].year}",
                                                carId: topRentedCarsModelObject.data![index].carsId,
                                                carRating: topRentedCarsModelObject.data![index].rating,
                                                carColorName: topRentedCarsModelObject.data![index].carsColors!.name,
                                                carMakesName: topRentedCarsModelObject.data![index].carsMakes!.name,
                                                carModelName: topRentedCarsModelObject.data![index].carsModels!.name,
                                                carImage: "$baseUrlImage${topRentedCarsModelObject.data![index].image1}",
                                                carMakesImage: "$baseUrlImage${topRentedCarsModelObject.data![index].carsMakes!.image}",
                                                favouriteStatus: topRentedCarsModelObject.data![index].favouriteStatus,
                                                discountPercentage: topRentedCarsModelObject.data![index].discountPercentage,
                                                carDiscountPrice: topRentedCarsModelObject.data![index].carsPlans![0].discountedPricePerHour,
                                                carPrice: topRentedCarsModelObject.data![index].carsPlans![0].pricePerHour,
                                                carOwnerImage: "$baseUrlImage${topRentedCarsModelObject.data![index].usersCompanies!.companyLogo}",
                                                carOwnerName: "${topRentedCarsModelObject.data![index].usersCompanies!.companyName}",
                                                carOwnerId: topRentedCarsModelObject.data![index].usersCompanies!.usersCompaniesId,
                                                myCarDescription: topRentedCarsModelObject.data![index].description,
                                                myCarRating: topRentedCarsModelObject.data![index].carsRatings![0].rateStars,
                                                myCarComment: topRentedCarsModelObject.data![index].carsRatings![0].comments,
                                                // datumPhotography: carsPhotoGraphyModelObject.data![index],
                                              )));
                                        }
                                        else if(topRentedCarsModelObject.data![index].carsUsageType == "Driving Experience"){
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => HomeDrivingBooking(
                                                datum: topRentedCarsModelObject.data![index],
                                              )));
                                        }
                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.035,
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        decoration: BoxDecoration(
                                            color: borderColor,
                                            borderRadius: BorderRadius.circular(30)),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Click to see Details", textAlign: TextAlign.left, style: TextStyle(
                                                  color: kWhite, fontFamily: poppinMedium, fontSize: 10)),
                                              const SizedBox(width: 10),
                                              Image.asset("assets/home_page/more_buttons_home.png")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30, left: 10, right: 10,
                          child: topRentedCarsModelObject.data![index].image1 == null ?
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset('assets/icon/fade_in_image.jpeg')) :
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage(
                              placeholder: const AssetImage("assets/icon/fade_in_image.jpeg"),
                              height: 65,
                              image: NetworkImage("$baseUrlImage${topRentedCarsModelObject.data![index].image1}"),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 03, left: 05,
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.065,
                            width: MediaQuery.of(context).size.width * 0.19,
                            decoration: BoxDecoration(
                              color: kRed.withOpacity(0.8),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${topRentedCarsModelObject.data![index].discountPercentage}% ",
                                      textAlign: TextAlign.left, style: TextStyle(
                                          color: kWhite, fontSize: 12, fontFamily: poppinSemiBold)),
                                  Text("OFF", textAlign: TextAlign.left, style: TextStyle(
                                      color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
