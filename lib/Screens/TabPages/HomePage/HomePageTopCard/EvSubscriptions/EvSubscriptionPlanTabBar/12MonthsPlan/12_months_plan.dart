import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../../../../../../Model/HomePageModels/HomeTopWidgetModels/ev_cars_model.dart';

class TwelveMonthsPlan extends StatefulWidget {
  final String months, pricePerMonths, discountPricePerMonths;

   const TwelveMonthsPlan({super.key, required this.months,
     required this.pricePerMonths, required this.discountPricePerMonths});

  @override
  State<TwelveMonthsPlan> createState() => _TwelveMonthsPlanState();
}

class _TwelveMonthsPlanState extends State<TwelveMonthsPlan> {
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
        myTotalAmount();
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
    evSelectedMonth = int.parse(widget.months);
    evSelectedMonthDiscountedPrice = widget.discountPricePerMonths;
    print(widget.pricePerMonths);
    print(widget.discountPricePerMonths);
    myTotalAmount();
  }

  myTotalAmount(){
    count +=1;
    if(count ==1){
      tabNewValue = evSelectedMonth;
      print("count $count");
    }
    print("count11 $count");

    print('selectedTabMonth: $evSelectedMonth');
    print('tabNewValue: $tabNewValue');
    print('selectedTabMonthPrice $evSelectedMonthDiscountedPrice');
    evSelectedMonthTotalPrice = double.parse("$evSelectedMonthDiscountedPrice") + serviceFee;
    print('selectedTabMonthTotalPrice $evSelectedMonthTotalPrice');
    selectedMonthDays = evSelectedMonth! * 30;
    print("selectedMonthDays: $selectedMonthDays");
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${widget.months} month Plan", textAlign: TextAlign.left, style: TextStyle(
                fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor)),
            Text("RM ${widget.discountPricePerMonths}",
                textAlign: TextAlign.right, style: TextStyle(
                fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor)),
          ],
        ),
        SizedBox(height: screenHeight * 0.015),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Service Fee (6%)", textAlign: TextAlign.left, style: TextStyle(
                fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor)),
            Text("RM $serviceFee", textAlign: TextAlign.right, style: TextStyle(
                fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor)),
          ],
        ),
        SizedBox(height: screenHeight * 0.015),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total Amount", textAlign: TextAlign.left, style: TextStyle(
                fontSize: 16, fontFamily: poppinSemiBold, color: kBlack)),
            Text("RM $evSelectedMonthTotalPrice", textAlign: TextAlign.left, style: TextStyle(
                fontSize: 16, fontFamily: poppinSemiBold, color: kBlack)),
          ],
        ),
      ],
    );
  }
}
