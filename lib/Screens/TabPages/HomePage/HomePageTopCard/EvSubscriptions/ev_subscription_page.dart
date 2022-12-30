import 'package:flutter/material.dart';
import '../../../../../Model/HomePageModels/HomePageTopWidgetModels/ev_subscription_cars_model.dart';
import '../../../../../Utils/api_urls.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/fontFamily.dart';
import '../../Filter/filter_screen.dart';
import '../../Notifications/notification_screen.dart';
import 'car_description.dart';
import 'package:http/http.dart'as http;

class EvSubscriptionPage extends StatefulWidget {
  const EvSubscriptionPage({Key? key}) : super(key: key);

  @override
  State<EvSubscriptionPage> createState() => _EvSubscriptionPageState();
}

class _EvSubscriptionPageState extends State<EvSubscriptionPage> {

  EvSubscriptionCarsModel evSubscriptionCarsModelObject = EvSubscriptionCarsModel();

  bool loadingP = true;

  @override
  void initState() {
    super.initState();
    getEvSubscriptionCarsWidget();
  }

  getEvSubscriptionCarsWidget() async {
    loadingP = true;
    setState(() {});
    try {
      String apiUrl = carsEvSubscriptionApiUrl;
      print("browseCarsApi: $apiUrl");
      final response = await http.get(Uri.parse(apiUrl),
          headers: {
            'Accept': 'application/json'
          });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("browseCarsResponse: ${responseString.toString()}");
        evSubscriptionCarsModelObject = evSubscriptionCarsModelFromJson(responseString);
        print("browseCarsModelObjectLength: ${evSubscriptionCarsModelObject.data!.length}");
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 30,
                        width: 30,
                        color: Colors.transparent,
                        child: Image.asset("assets/home_page/back_arrow.png"))),
                Text("EV Subscription", style: TextStyle(
                    fontSize: 20, fontFamily: poppinBold, color: kBlack,),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const NotificationsScreen()));
                    },
                    child: Image.asset("assets/home_page/notification_image.png")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.fromLTRB(20, 12, 10, 0),
                        hintText: 'Search for Cars',
                        hintStyle: TextStyle(
                            color: const Color(0xffD4DCE1),
                            fontSize: 14, fontFamily: poppinLight),
                        focusColor: borderColor,
                        suffixIcon: const Icon(
                          Icons.search_outlined,
                          color: Color(0xffD4DCE1),
                        ),
                      ),
                      style: TextStyle(color: borderColor, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const FilterScreen()));
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(30)),
                      child: Image.asset("assets/home_page/filter.png")),
                ),
              ],
            ),
          ),
          allEvSubscriptionItemsList(),
        ],
      ),
    );
  }

  Widget allEvSubscriptionItemsList() {
    return SingleChildScrollView(
      child: loadingP ? Center(child: CircularProgressIndicator(color: borderColor,)):
      evSubscriptionCarsModelObject.status != "success"? const Center(
        child: Text('no data found...',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ):
      Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.79,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: evSubscriptionCarsModelObject.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (() {
                  Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const CarDescription()));
                }),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.33,
                      ),
                    ),
                    Positioned(
                      top: 90,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 9),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.23,
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
                              Container(
                                height: MediaQuery.of(context).size.height * 0.1,
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
                                            Container(
                                              width: MediaQuery.of(context).size.width* 0.33,
                                              color: Colors.transparent,
                                              child: Text("${evSubscriptionCarsModelObject.data![index].vehicalName} | ",
                                                style: TextStyle(color: kBlack,
                                                  fontSize: 14, fontFamily: poppinBold,),
                                                textAlign: TextAlign.left,),
                                            ),
                                            Text("MODEL ",
                                              style: TextStyle(color: kBlack,
                                                fontSize: 12, fontFamily: poppinRegular,),
                                              textAlign: TextAlign.left,),
                                            Text(
                                              "${evSubscriptionCarsModelObject.data![index].year} ",
                                              style: TextStyle(color: kBlack,
                                                fontSize: 14, fontFamily: poppinMedium,),
                                              textAlign: TextAlign.left,),
                                            Text(
                                             "${evSubscriptionCarsModelObject.data![index].year}",
                                              style: TextStyle(color: kBlack,
                                                fontSize: 10, fontFamily: poppinRegular,),
                                              textAlign: TextAlign.left),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 04),
                                              child: Text("RM",
                                                style: TextStyle(color: kRed,
                                                  fontSize: 5, fontFamily: poppinRegular),
                                                textAlign: TextAlign.left),
                                            ),
                                            Text("${evSubscriptionCarsModelObject.data![index].carsPlans![0].pricePerMonth}",
                                              style: TextStyle(
                                                color: kRed,
                                                decoration: TextDecoration.lineThrough,
                                                decorationColor: kRed,
                                                decorationThickness: 3,
                                                fontSize: 10,
                                                fontFamily: poppinLight,
                                                height: 2,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            const SizedBox(width: 5),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 06),
                                              child: Text("RM",
                                                style: TextStyle(color: borderColor,
                                                  fontSize: 7, fontFamily: poppinSemiBold),
                                                textAlign: TextAlign.left),
                                            ),
                                            Text("${evSubscriptionCarsModelObject.data![index].carsPlans![0].pricePerMonth}",
                                              style: TextStyle(color: borderColor,
                                                fontSize: 16, fontFamily: poppinSemiBold,),
                                              textAlign: TextAlign.left),
                                            Text("/ Month",
                                              style: TextStyle(color: kBlack,
                                                fontSize: 8, fontFamily: poppinRegular,),
                                              textAlign: TextAlign.left),
                                            SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
                                            Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
                                            SizedBox(width: MediaQuery.of(context).size.height * 0.01,),

                                            evSubscriptionCarsModelObject.data![index].rating == null?
                                            Text("0.0",
                                                style: TextStyle(color: kBlack,
                                                    fontSize: 12, fontFamily: poppinRegular),
                                                textAlign: TextAlign.left):
                                            Text("${evSubscriptionCarsModelObject.data![index].rating}",
                                              style: TextStyle(color: kBlack,
                                                fontSize: 12, fontFamily: poppinRegular),
                                              textAlign: TextAlign.left),
                                          ],
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                        Row(
                                          children: [
                                            Image.asset(
                                                "assets/car_bookings_images/promoted.png"),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text("Verified Dealer",
                                              style: TextStyle(color: textLabelColor,
                                                fontSize: 10, fontFamily: poppinRegular),
                                              textAlign: TextAlign.left),
                                            const SizedBox(width: 05),
                                            Container(
                                              height: 20,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: kBlack,
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Center(
                                                child: Text("New",
                                                  style: TextStyle(color: kWhite,
                                                    fontSize: 8, fontFamily: poppinRegular),
                                                  textAlign: TextAlign.left),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Image.asset("assets/car_bookings_images/more_button.png"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 10,
                        left: 15,
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
                              Text(
                               "${evSubscriptionCarsModelObject.data![index].discountPercentage}",
                                style: TextStyle(color: kWhite,
                                  fontSize: 13, fontFamily: poppinSemiBold),
                                textAlign: TextAlign.left),
                              Text(" OFF ",
                                style: TextStyle(color: kWhite,
                                  fontSize: 8, fontFamily: poppinRegular,),
                                textAlign: TextAlign.left),
                            ],
                          ),
                        )),
                    Positioned(
                      child: evSubscriptionCarsModelObject.data![index].image1 == null? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/icon/fade_in_image.jpeg')):
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          placeholder: const AssetImage("assets/icon/fade_in_image.jpeg"),
                          // fit: BoxFit.fill,
                          width: 350,
                          height: 150,
                          image: NetworkImage("$baseUrlImage${evSubscriptionCarsModelObject.data![index].image1}"),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 10, right: 15,
                        child: Image.asset("assets/car_bookings_images/heart.png"),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

List browseCarItemsList = [
  BrowseRentCarItemsClass("assets/home_page/tesla_car_image.png", "5%", 'TESLA',
      "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  BrowseRentCarItemsClass("assets/home_page/bmw_car_image.png", "5%", 'TESLA',
      "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  BrowseRentCarItemsClass("assets/home_page/tesla_car_image.png", "5%", 'TESLA',
      "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
];

class BrowseRentCarItemsClass {
  final String carImage;
  final String discountText;
  final String carCompanyName;
  final String textModel;
  final String range;
  final String carModelYear;
  final String oldPrice;
  final String newPrice;

  BrowseRentCarItemsClass(
      this.carImage,
      this.discountText,
      this.carCompanyName,
      this.textModel,
      this.carModelYear,
      this.range,
      this.oldPrice,
      this.newPrice);
}
