import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../Model/HomePageModels/top_rented_cars_model.dart';
import '../../../../Utils/colors.dart';
import '../../../../Utils/constants.dart';

class HomeCardTopRented extends StatefulWidget {
  const HomeCardTopRented({Key? key}) : super(key: key);

  @override
  State<HomeCardTopRented> createState() => _HomeCardTopRentedState();
}

class _HomeCardTopRentedState extends State<HomeCardTopRented> {
  TopRentedCarsModel topRentedCarsModelObject = TopRentedCarsModel();

  @override
  void initState() {
    super.initState();
    getTopRentedCarsWidget();
  }
  bool loadingP = true;

  getTopRentedCarsWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    print('in topRenterCarModelApi');
    try {
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
        print("topRenterCarName: ${topRentedCarsModelObject.data![0].vehicalName}");
        print("topRenterCarPrice: ${topRentedCarsModelObject.data![0].carsPlans![0].pricePerMonth}");
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
          : topRentedCarsModelObject.status != "success" ? const Center(
          child: Text('no data found...',
              style: TextStyle(fontWeight: FontWeight.bold))) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      color: Colors.transparent,
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.42,
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
                                        height: MediaQuery.of(context).size.height * 0.24,
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
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        color: Colors.transparent,
                                                        width: MediaQuery.of(context).size.width * 0.2,
                                                        child: Text("${topRentedCarsModelObject.data![index].vehicalName} ",
                                                          style: TextStyle(color: kBlack,
                                                            fontSize: 7, fontFamily: poppinBold)),
                                                      ),
                                                      Text("${topRentedCarsModelObject.data![index].year}",
                                                          style: TextStyle(color: kBlack,
                                                            fontSize: 10, fontFamily: poppinRegular)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
                                                      SizedBox(
                                                        width: MediaQuery.of(context).size.height * 0.005,
                                                      ),
                                                      topRentedCarsModelObject.data![index].rating == null
                                                          ? Text("0.0", style: TextStyle(
                                                                  color: kBlack, fontSize: 10, fontFamily: poppinMedium))
                                                          : Text("${topRentedCarsModelObject.data![index].rating}",
                                                              style: TextStyle(color: kBlack, fontSize: 10, fontFamily: poppinMedium))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Divider(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 04),
                                                        child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                                                            color: kRed, fontSize: 5, fontFamily: poppinLight)),
                                                      ),
                                                      topRentedCarsModelObject.data![index].carsPlans![0].pricePerMonth == null
                                                          ? Text("0.0", style: TextStyle(color: kBlack,
                                                                  fontSize: 10, fontFamily: poppinMedium)) :
                                                      Text("${topRentedCarsModelObject.data![index].carsPlans![0].pricePerMonth}",
                                                              textAlign: TextAlign.left, style: TextStyle(
                                                                color: kRed, decoration: TextDecoration.lineThrough,
                                                                fontSize: 10, fontFamily: poppinLight)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 06),
                                                        child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                                                            color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                                                      ),
                                                      topRentedCarsModelObject.data![index].carsPlans![0].discountedPricePerMonth == null
                                                          ? Text("0.0", style: TextStyle(color: kBlack,
                                                          fontSize: 10, fontFamily: poppinMedium)) :
                                                      Text("${topRentedCarsModelObject.data![index].carsPlans![0].discountedPricePerMonth}",
                                                          textAlign: TextAlign.left, style: TextStyle(
                                                              color: borderColor, fontSize: 14, fontFamily: poppinSemiBold)),
                                                      Text("/ Month", textAlign: TextAlign.left, style: TextStyle(
                                                          color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                                                    ],
                                                  ),
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
                                                    height: 15,
                                                    width: 35,
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
                                              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                              GestureDetector(
                                                onTap: () {
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             HomePageDetails(
                                                  //               vehicalName:
                                                  //                   topRentedCarsModelObject
                                                  //                       .data![
                                                  //                           index]
                                                  //                       .vehicalName,
                                                  //               oldRent: topRentedCarsModelObject
                                                  //                   .data![
                                                  //                       index]
                                                  //                   .carsPlans![
                                                  //                       0]
                                                  //                   .pricePerMonth,
                                                  //               rentCostMonth:
                                                  //                   topRentedCarsModelObject
                                                  //                       .data![
                                                  //                           index]
                                                  //                       .carsPlans![
                                                  //                           0]
                                                  //                       .pricePerMonth,
                                                  //               carRating:
                                                  //                   topRentedCarsModelObject
                                                  //                       .data![
                                                  //                           index]
                                                  //                       .rating,
                                                  //               modelYear:
                                                  //                   topRentedCarsModelObject
                                                  //                       .data![
                                                  //                           index]
                                                  //                       .year,
                                                  //               discount: topRentedCarsModelObject
                                                  //                   .data![
                                                  //                       index]
                                                  //                   .discountPercentage,
                                                  //             )));
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
                                      top: 03,
                                      left: 05,
                                      child: Container(
                                        height: MediaQuery.of(context).size.width * 0.06,
                                        width: MediaQuery.of(context).size.width * 0.18,
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
