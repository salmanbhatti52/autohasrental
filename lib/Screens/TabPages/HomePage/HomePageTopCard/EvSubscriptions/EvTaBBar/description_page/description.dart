import 'package:auto_haus_rental_app/Model/HomePageModels/HomePageTopWidgetModels/ev_subscription_cars_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

class Description extends StatefulWidget {
  const Description({super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  EvSubscriptionCarsModel evSubscriptionCarsModelObject = EvSubscriptionCarsModel();
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
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
          : evSubscriptionCarsModelObject.status != "success" ?
      const Center(child: Text('no data found...',
          style: TextStyle(fontWeight: FontWeight.bold))) :
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Text(
            "${evSubscriptionCarsModelObject.data![0].description}",
            style: TextStyle(
                fontSize: 12,
                fontFamily: poppinRegular,
                color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
