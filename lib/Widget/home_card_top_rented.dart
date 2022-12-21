import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/HomePageModels/top_rented_cars_model.dart';
import '../Screens/TabPages/HomePage/Home/home_page_details.dart';
import '../Utils/colors.dart';
import 'package:http/http.dart'as http;

class HomeCardTopRented extends StatefulWidget {
  const HomeCardTopRented({Key? key}) : super(key: key);

  @override
  State<HomeCardTopRented> createState() => _HomeCardTopRentedState();
}

class _HomeCardTopRentedState extends State<HomeCardTopRented> {

  TopRentedCarsModel topRentedCarsModelObject = TopRentedCarsModel();

  bool loadingP = true;
  SharedPreferences? prefs;


  @override
  void initState() {
    super.initState();
    getTopRentedCarsWidget();
  }

  getTopRentedCarsWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    print('in topRenterCarModelApi');

    try {
      String apiUrl = topRentedCarsApiUrl;
      print("topRenterCarModelApi: $apiUrl");
      final response = await http.get(Uri.parse(apiUrl),
          headers: {
            'Accept': 'application/json'
          });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("topRenterCarResponse : ${responseString.toString()}");
        topRentedCarsModelObject = topRentedCarsModelFromJson(responseString);
        print("topRenterCarModelApiStatus is: ${topRentedCarsModelObject.status}");
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
      child: loadingP ? Center(child: CircularProgressIndicator(color: borderColor,)):
      topRentedCarsModelObject.status != "success"? const Center(
        child: Text('no data found...',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ):
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height* 0.55,
            color: Colors.transparent,
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1/1.37,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                ),
                // itemCount: topRentedItemsList.length,
                itemCount: topRentedCarsModelObject.data!.length,
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>const HomePageDetails()));
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          top: 50,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.26,
                              width: MediaQuery.of(context).size.width*0.47,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(20)
                              ),
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
                                            Text("${topRentedCarsModelObject.data![index].vehicalName} ", style: TextStyle(color: kBlack,
                                              fontSize: 14, fontFamily: poppinBold,),),
                                            Text("${topRentedCarsModelObject.data![index].year}", style: TextStyle(color: kBlack,
                                              fontSize: 10, fontFamily: poppinRegular,)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
                                            SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                            Text("${topRentedCarsModelObject.data![index].rating}", style: TextStyle(color: kBlack,
                                              fontSize: 10, fontFamily: 'Poppins-Medium',),),
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
                                              child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(color: kRed,
                                                fontSize: 5, fontFamily: poppinLight,),),
                                            ),
                                            Text("${topRentedCarsModelObject.data![index].oldRentCostDay}", textAlign: TextAlign.left, style: TextStyle(color: kRed,
                                              decoration: TextDecoration.lineThrough,
                                              fontSize: 10, fontFamily: poppinLight,),),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 06),
                                              child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(color: borderColor,
                                                fontSize: 7, fontFamily: poppinSemiBold,),),
                                            ),
                                            Text("${topRentedCarsModelObject.data![index].rentCostMonth}", textAlign: TextAlign.left, style: TextStyle(color: borderColor,
                                              fontSize: 14, fontFamily: poppinSemiBold,),),
                                            Text("/ Month", textAlign: TextAlign.left, style: TextStyle(color: kBlack,
                                              fontSize: 8, fontFamily: poppinRegular,),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        Row(
                                          children: [
                                            Image.asset("assets/home_page/Promoted.png"),
                                            const SizedBox(width: 05,),
                                            Text("Verified Dealer", textAlign: TextAlign.left,
                                              style: TextStyle(color: textLabelColor,
                                              fontSize: 10, fontFamily: poppinRegular,),),
                                          ],
                                        ),
                                        Container(
                                          height: 20, width: 40,
                                          decoration: BoxDecoration(
                                              color: kBlack,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Center(
                                            child: Text("New", textAlign: TextAlign.left, style: TextStyle(color: kWhite,
                                              fontSize: 8, fontFamily: poppinRegular,),),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.width * 0.02,),
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.035,
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      decoration: BoxDecoration(
                                      color: borderColor,
                                      borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text("Click to see Details", textAlign: TextAlign.left,
                                            style: TextStyle(color: Colors.white, fontFamily: 'Poppins-Medium', fontSize: 10)),
                                        const SizedBox(width: 10,),
                                        Image.asset("assets/home_page/more_buttons_home.png")
                                      ],
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
                          top: 10, left: 10, right: 10,
                          child: Image.asset(topRentedItemsList[index].carImage,
                          // height: 100,
                          ),
                        ),
                        Positioned(
                            top: 05, left: 10,
                            child: Container(
                              height: MediaQuery.of(context).size.width* 0.06,
                              width: MediaQuery.of(context).size.width* 0.15,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(topRentedItemsList[index].discountText, textAlign: TextAlign.left,
                                    style: TextStyle(color: kWhite, fontSize: 13, fontFamily: poppinSemiBold,),),
                                  Text(" OFF", textAlign: TextAlign.left, style: TextStyle(color: kWhite, fontSize: 8, fontFamily: poppinRegular,)),
                                ],
                              ),
                            )
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

List topRentedItemsList = [
  ToRentedItemsClass( "assets/home_page/Rounded Rectangle 1 copy.png", "5%",'TESLA', "2022" ," 9,000", "8,500"),
  ToRentedItemsClass( "assets/home_page/Rounded Rectangle 3 copy.png", "5%",'TESLA', "2022" ," 9,000", "8,500"),
  ToRentedItemsClass( "assets/home_page/Rounded Rectangle 3 copy.png", "5%",'TESLA', "2022" ," 9,000", "8,500"),
  ToRentedItemsClass( "assets/home_page/Rounded Rectangle 4 copy.png", "5%",'TESLA', "2022" ," 9,000", "8,500"),
  ToRentedItemsClass( "assets/home_page/Rounded Rectangle 4 copy.png", "5%",'TESLA', "2022" ," 9,000", "8,500"),
  ToRentedItemsClass( "assets/home_page/Rounded Rectangle 4 copy.png", "5%",'TESLA', "2022" ," 9,000", "8,500"),
];

class ToRentedItemsClass {
  final String carImage;
  final String discountText;
  final String carCompanyName;
  final String carModelYear;
  final String oldPrice;
  final String newPrice;

  ToRentedItemsClass(this.carImage, this.discountText, this.carCompanyName, this.carModelYear, this.oldPrice, this.newPrice);
}