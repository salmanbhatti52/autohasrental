import 'package:flutter/material.dart';
import '../../../../../Model/HomePageModels/HomePageTopWidgetModels/driving_experience_cars_model.dart';
import '../../../../../Utils/api_urls.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/constants.dart';
import '../../../../../Utils/fontFamily.dart';
import 'package:http/http.dart' as http;

import 'driving_details_page.dart';

class TopExperienceWidget extends StatefulWidget {
  const TopExperienceWidget({Key? key}) : super(key: key);

  @override
  State<TopExperienceWidget> createState() => _TopExperienceWidgetState();
}

class _TopExperienceWidgetState extends State<TopExperienceWidget> {
  DrivingExperienceCarsModel drivingExperienceCarsModelObject = DrivingExperienceCarsModel();
  bool loadingP = true;
  @override
  void initState() {
    super.initState();
    getDrivingExperienceCarsWidget();
  }

  getDrivingExperienceCarsWidget() async {
    loadingP = true;
    setState(() {});
    try {
      String apiUrl = carDrivingExperienceApiUrl;
      print("drivingExperienceCarsApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id" : userId
          },
          headers: {'Accept': 'application/json'});
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("drivingExperienceCarsResponse: ${responseString.toString()}");
        drivingExperienceCarsModelObject =
            drivingExperienceCarsModelFromJson(responseString);
        print(
            "drivingExperienceCarsLength: ${drivingExperienceCarsModelObject.data!.length}");
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
        : drivingExperienceCarsModelObject.status != "success"
            ? const Center(child: Text('no data found...',
      style: TextStyle(fontWeight: FontWeight.bold),)) :
    Container(
      height: 210,
      width: double.infinity,
      color: Colors.transparent,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: drivingExperienceCarsModelObject.data!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                color: Colors.transparent,
                height: 250,
                width: 180,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.23,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 05),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              color: Colors.transparent,
                                              child: Text("${drivingExperienceCarsModelObject.data![index].vehicalName} | ",
                                                  style: TextStyle(color: kBlack,
                                                      fontSize: 14, fontFamily: poppinBold),
                                                  textAlign: TextAlign.left),
                                            ),
                                            Text("${drivingExperienceCarsModelObject.data![index].year}",
                                                style: TextStyle(color: kBlack,
                                                    fontSize: 10, fontFamily: poppinRegular),
                                                textAlign: TextAlign.left),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.height * 0.01,),
                                            drivingExperienceCarsModelObject.data![index].rating == null
                                                ? Text("0.0", style: TextStyle(color: kBlack,
                                                fontSize: 10, fontFamily: poppinMedium),
                                              textAlign: TextAlign.left,)
                                                : Text("${drivingExperienceCarsModelObject.data![index].rating}",
                                              style: TextStyle(color: kBlack,
                                                fontSize: 10, fontFamily: poppinMedium),
                                              textAlign: TextAlign.left,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 04),
                                        child: Text("RM",
                                          style: TextStyle(color: kRed,
                                            fontSize: 5, fontFamily: poppinLight,),
                                          textAlign: TextAlign.left),
                                      ),
                                      Text("${drivingExperienceCarsModelObject.data![index].carsPlans![0].discountedPricePerSlot}",
                                        style: TextStyle(
                                          color: kRed,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: kRed,
                                          decorationThickness: 3,
                                          fontSize: 10,
                                          fontFamily: poppinLight,
                                          height: 2),
                                        textAlign: TextAlign.left,),
                                      const Spacer(),
                                      Text("/ Month",
                                        style: TextStyle(color: kBlack,
                                          fontSize: 8, fontFamily: poppinRegular,),
                                        textAlign: TextAlign.left,),
                                      SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => DrivingDetailsPage(
                                            carName: "${drivingExperienceCarsModelObject.data![index].vehicalName}",
                                            carYear: "${drivingExperienceCarsModelObject.data![index].year}",
                                            carImage: "$baseUrlImage${drivingExperienceCarsModelObject.data![index].image1}",
                                          )));
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height * 0.04,
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      decoration: BoxDecoration(
                                          color: borderColor,
                                          borderRadius: BorderRadius.circular(30)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Click to see Details",
                                              style: TextStyle(color: Colors.white,
                                                  fontFamily: poppinMedium, fontSize: 10),
                                              textAlign: TextAlign.left),
                                          const SizedBox(width: 10,),
                                          Image.asset("assets/home_page/more_buttons_home.png")
                                        ],
                                      ),
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
                      left: 1,
                      right: 16,
                      child: drivingExperienceCarsModelObject.data![index].image1 == null
                          ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/icon/fade_in_image.jpeg'))
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          placeholder: const AssetImage("assets/icon/fade_in_image.jpeg"),
                          width: 350,
                          height: 70,
                          image: NetworkImage("$baseUrlImage${drivingExperienceCarsModelObject.data![index].image1}"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
