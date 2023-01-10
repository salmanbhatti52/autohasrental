import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../Model/HomePageModels/HomePageTopWidgetModels/ev_subscription_cars_model.dart';
import '12MonthsPlan/12_months_plan.dart';
import '24MonthsPlan/24_months_plan.dart';
import '36MonthsPlan/36_months_plan.dart';
import 'package:http/http.dart'as http;

class EvSubscriptionTabbarPage extends StatefulWidget {
  const EvSubscriptionTabbarPage({super.key});

  @override
  State<EvSubscriptionTabbarPage> createState() => _EvSubscriptionTabbarPageState();
}

abstract class TickerProvider {}

class _EvSubscriptionTabbarPageState extends State<EvSubscriptionTabbarPage>
    with TickerProviderStateMixin {

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
        // myTotal();
      }
    } catch (e) {
      print('Error in evSubscription: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  List<String> tabs = ["12 Months", "24 Months", "36 Months" ];

  // for(array){
  //   obj = obj[i].month + "Month"
  // }
  //
  // [{},{}]
  //
  // List<String> tabs = ["${evSubscriptionCarsModelObject.data![0].carsPlans!.length}"];

  int selectedIndex = 0;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // monthList();
  }
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
              width: 344,
              height: 48,
              decoration: BoxDecoration(
                  color: homeBgColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 09, horizontal: 0),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  indicatorColor: kWhite,
                  // isScrollable: true,
                  labelColor: kWhite,
                  labelStyle: TextStyle(fontSize: 12, fontFamily: poppinRegular),
                  unselectedLabelColor: kBlack,
                  tabs: const [
                    Tab(text: "12 Months"),
                    Tab(text: "24 Months"),
                    Tab(text: "36 Months"),
                  ],
                ),
              )),
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.14,
          child: TabBarView(
            controller: tabController,
            children: const [
              TwelveMonthsPlan(),
              TwentyFourMonthsPlan(),
              ThirtySixMonthsPlan(),
            ]
          ),
        ),
      ],
    );
  }
}
