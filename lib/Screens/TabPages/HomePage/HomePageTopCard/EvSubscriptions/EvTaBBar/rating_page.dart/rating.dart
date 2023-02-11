import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../../../../Model/HomePageModels/HomeTopWidgetModels/ev_cars_model.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {

  EvCarsModel evSubscriptionCarsModelObject = EvCarsModel();
  bool loadingP = true;

  getEvSubscriptionCarsWidget() async {
    loadingP = true;
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");
    try {
      String apiUrl = carsEvSubscriptionApiUrl;
      print("evSubscriptionApi: $apiUrl");
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "users_customers_id" : userId
        },
        headers: {'Accept': 'application/json'},
      );
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("evSubscriptionResponse: ${responseString.toString()}");
        evSubscriptionCarsModelObject = evSubscriptionCarsModelFromJson(responseString);
        print("evSubscriptionObjectLength: ${evSubscriptionCarsModelObject.data!.length}");
      }
    } catch (e) {
      print('Error in evSubscription: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEvSubscriptionCarsWidget();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          allRatingList(),
        ],
      ),
    );
  }

  Widget allRatingList() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: ratingItemsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    ratingItemsList[index].image,
                    height: 60,
                    width: 60,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 2),
                  child: Text(ratingItemsList[index].name,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: poppinMedium,
                      )),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    ratingItemsList[index].description,
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: poppinRegular,
                    ),
                  ),
                ),
                trailing: Image.asset(
                  ratingItemsList[index].image2,
                  width: 75,
                  height: 12,
                ),
              ),
            ),
          );
        });
  }
}

  List ratingItemsList = [
    RatingClass(
      "assets/car_description_images/user.png",
      'Josh Gibson',
      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
      "assets/car_description_images/rating.png",
    ),
    RatingClass(
      "assets/car_description_images/user.png",
      'Josh Gibson',
      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
      "assets/car_description_images/rating.png",
    ),
    RatingClass(
      "assets/car_description_images/user.png",
      'Josh Gibson',
      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
      "assets/car_description_images/rating.png",
    ),
    RatingClass(
      "assets/car_description_images/user.png",
      'Josh Gibson',
      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
      "assets/car_description_images/rating.png",
    ),
    RatingClass(
      "assets/car_description_images/user.png",
      'Josh Gibson',
      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
      "assets/car_description_images/rating.png",
    ),
    RatingClass("assets/car_description_images/user.png",
      'Josh Gibson',
      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
      "assets/car_description_images/rating.png",
    ),
  ];

  class RatingClass {
  final String image;
  final String name;
  final String description;
  final String image2;

  RatingClass(
  this.image, this.name,
  this.description, this.image2);
  }

