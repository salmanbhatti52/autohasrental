import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../../Utils/colors.dart';
import '../../../../../../../Utils/fontFamily.dart';
import '../Model/HomePageModels/HomeTopWidgetModels/ev_cars_model.dart';
import '../Model/custom_subscription_model.dart';
import '../Utils/api_urls.dart';
import '../Utils/constants.dart';
import 'package:http/http.dart'as http;

class MonthSlotContainer extends StatefulWidget {
  MonthSlotContainer({super.key});

  @override
  State<MonthSlotContainer> createState() => _MonthSlotContainerState();
}

class _MonthSlotContainerState extends State<MonthSlotContainer> with TickerProviderStateMixin {
  EvCarsModel evSubscriptionCarsModelObject = EvCarsModel();
  bool loadingP = true;
  int selectedIndex = 0;
  String? tabSelectMonth, tabSelectedPrice;
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
        evSubscriptionCarsModelObject = evCarsModelFromJson(responseString);
        print("evSubscriptionObjectLength: ${evSubscriptionCarsModelObject.data!.length}");
        monthList();
      }
    } catch (e) {
      print('Error in evSubscription: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  List<CustomSubscriptionModel> monthNumber = [];
  monthList(){
    for (int i = 0; i< evSubscriptionCarsModelObject.data!.length; i++) {
      print("OuterLoop:$i");
      for (int j = 0; j < evSubscriptionCarsModelObject.data![i].carsPlans!.length; j++) {
        if(evSubscriptionCarsModelObject.data![i].carsPlans![j].carsId == carID) {
          monthNumber.add(CustomSubscriptionModel(
              months: evSubscriptionCarsModelObject.data![i].carsPlans![j].months!.toString(),
              price_per_months: evSubscriptionCarsModelObject.data![i].carsPlans![j].pricePerMonth!,
              dis_price_per_months: evSubscriptionCarsModelObject.data![i].carsPlans![j].discountedPricePerMonth!.toString()));
          print("monthNumber123 ${monthNumber[0].months}");
          print("InnerLoop:$j");
        }
      }
    }
  }

  // List<MonthSlotRadioModel> monthSlotData = <MonthSlotRadioModel>[];

  @override
  void initState() {
    super.initState();
    getEvSubscriptionCarsWidget();
    // monthSlotData.add(MonthSlotRadioModel(true, '48 Months', 'RM 6,365'));
    // monthSlotData.add(MonthSlotRadioModel(false, '60 Months', 'RM 5,225'));
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: monthNumber.length, vsync: this);
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor)):
    Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
                color: homeBgColor,
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: TabBar(
                controller: tabController,
                indicator: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                onTap: (index){
                  selectedIndex = index;
                  tabSelectMonth = monthNumber[selectedIndex].months;
                  tabSelectedPrice = monthNumber[selectedIndex].dis_price_per_months;
                  print('selectedIndex: $selectedIndex');
                  print('selectedTabMonth123: $tabSelectMonth');
                  print('selectedTabMonthPrice: $tabSelectedPrice');

                },
                tabs: List<Widget>.generate(
                  monthNumber.length, (int index) {
                  print("monthsTabBarLength ${monthNumber.length}");
                  print("monthsTabBarClicked ");
                  return Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: Tab(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            monthNumber[index].months == "1" ? Text("${monthNumber[index].months} month", style: TextStyle(
                              color: kBlack, fontSize: 17, fontFamily: poppinMedium,)):
                            Text("${monthNumber[index].months} months", style: TextStyle(
                              color: kBlack, fontSize: 17, fontFamily: poppinMedium)),

                            Text("RM ${monthNumber[index].dis_price_per_months}",
                                textAlign: TextAlign.right, style: TextStyle(
                                    fontSize: 14, fontFamily: poppinRegular, color: kBlack,)),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                indicatorColor: kWhite,
                isScrollable: true,
                labelColor: kWhite,
                labelStyle: TextStyle(fontSize: 12, fontFamily: poppinRegular),
                unselectedLabelColor: kBlack,
              ),
            )),

      ],
    );

    //   ListView.builder(
    //   itemCount: monthSlotData.length,
    //   scrollDirection: Axis.horizontal,
    //   physics: BouncingScrollPhysics(),
    //   itemBuilder: (BuildContext context, int index) {
    //     return InkWell(
    //       onTap: () {
    //         setState(() {
    //           monthSlotData
    //               .forEach((element) => element.isSelectedMonthSlot = false);
    //           monthSlotData[index].isSelectedMonthSlot = true;
    //         });
    //       },
    //       child: MonthSlotRadioItem(monthSlotData[index]),
    //     );
    //   },
    // );

  }
}

// class MonthSlotRadioItem extends StatelessWidget {
//   final MonthSlotRadioModel _item;
//   MonthSlotRadioItem(this._item, {super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(2.0),
//       child: Container(
//         height: 70,
//         width: 185,
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         decoration: BoxDecoration(
//             color: _item.isSelectedMonthSlot ? borderColor : kWhite,
//             borderRadius: BorderRadius.circular(15)),
//         child: Row(
//           children: [
//             Icon(Icons.check_circle, size: 22,
//               color: _item.isSelectedMonthSlot ? kWhite : Color(0xffd4dce1)),
//             SizedBox(width: 15),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.6),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.3,
//                     child: Text(_item.title, style: TextStyle(
//                         fontSize: 17, fontFamily: poppinMedium,
//                         color: _item.isSelectedMonthSlot ? kWhite : kBlack,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.3,
//                     child: Text(_item.subtitle, style: TextStyle(
//                         fontSize: 14, fontFamily: poppinRegular,
//                         color: _item.isSelectedMonthSlot ? kWhite : Color(0xffd4dce1),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MonthSlotRadioModel {
//   bool isSelectedMonthSlot;
//   final String title;
//   final String subtitle;
//
//   MonthSlotRadioModel(
//     this.isSelectedMonthSlot,
//     this.title,
//     this.subtitle,
//   );
// }
