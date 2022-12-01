import 'package:flutter/material.dart';
import '../../../../Widget/button.dart';
import '../../../../Widget/colors.dart';
import '../../../../Widget/fontFamily.dart';
import '../../MyAppBarHeader/app_bar_header.dart';
import 'Address/delivery_address.dart';
import 'choose_mileage_plan.dart';
import 'choose_subscription_plan.dart';

class HomePageDetails extends StatefulWidget {
  const HomePageDetails({Key? key}) : super(key: key);

  @override
  State<HomePageDetails> createState() => _HomePageDetailsState();
}

class _HomePageDetailsState extends State<HomePageDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const myAppBarSingleImage(
        title: "BMW 2 series, 2022", backImage: "assets/messages_images/Back.png",),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: MediaQuery.of(context).size.height * 0.07,),

            // myHeaderNotification(context, "assets/messages_images/Back.png", "BMW 2 series, 2022", "" ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       GestureDetector(
            //         onTap:(){
            //           Navigator.pop(context);
            //         },
            //         child: Image.asset("assets/messages_images/Back.png", height: 25, width: 25,),),
            //
            //       Text("BMW 2 series, 2022",
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kBlack),),
            //
            //       Container(),
            //     ],
            //   ),
            // ),

            SingleChildScrollView(

                child: Column(
                  children: [
                    card(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Choose Subscription plan", textAlign: TextAlign.left, style: TextStyle(color: kBlack,
                            fontSize: 14, fontFamily: poppinSemiBold,),),

                          const ChooseSubscriptionPlan(),

                          Text("Choose Mileage Package", textAlign: TextAlign.left, style: TextStyle(color: kBlack,
                            fontSize: 14, fontFamily: poppinSemiBold,),),

                          const ChooseMileagePlan(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Start Fee", textAlign: TextAlign.left, style: TextStyle(
                                  fontSize: 14, fontFamily: 'Poppins-Medium', color: kBlack),),
                              Text("RM 8,471.94", textAlign: TextAlign.right, style: TextStyle(
                                  fontSize: 14, fontFamily: 'Poppins-Medium', color: kBlack),),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("12 Months Plan", textAlign: TextAlign.left, style: TextStyle(
                                  fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor),),
                              Text("RM 8,120.00", textAlign: TextAlign.right, style: TextStyle(
                                  fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor),),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Lite Package - 1,250KM", textAlign: TextAlign.left, style: TextStyle(
                                  fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor),),
                              Text("RM 0.00", textAlign: TextAlign.right, style: TextStyle(
                                  fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor),),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Service Fee (6%)", textAlign: TextAlign.left, style: TextStyle(
                                  fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor),),
                              Text("RM 487.20", textAlign: TextAlign.right, style: TextStyle(
                                  fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor),),
                            ],
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Monthly Total Fee", textAlign: TextAlign.left, style: TextStyle(
                                  fontSize: 16, fontFamily: poppinSemiBold, color: kBlack),),
                              Text("RM 8,607.20", textAlign: TextAlign.left, style: TextStyle(
                                  fontSize: 16, fontFamily: poppinSemiBold, color: kBlack),),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                          Text("*A security deposit may be applicable, depending on your eligibility assessment.",
                            maxLines: 2, textAlign: TextAlign.left, style: TextStyle(
                                fontSize: 14, fontFamily: poppinRegular, color: borderColor),),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                          // Container(
                          //   height: MediaQuery.of(context).size.height *0.1,
                          //   width: MediaQuery.of(context).size.height ,
                          //   decoration: BoxDecoration(
                          //     color: kBlack,
                          //     borderRadius: BorderRadius.circular(25)
                          //   ),
                          //   child: Center(
                          //     child: ListTile(
                          //       leading: Image.asset("assets/home_page/business-investment.png"),
                          //       title: Text("Monthly Total Fee", style: TextStyle(fontSize: 16,
                          //           fontWeight: FontWeight.w600, fontFamily: 'Poppins', color: kWhite),),
                          //       subtitle: Text("in your first year with AutoHaus Rental",
                          //           style: TextStyle(color: kWhite,
                          //             fontSize: 10, fontWeight: FontWeight.w400, fontFamily: 'Poppins',)),
                          //       trailing: Container(
                          //         height: 25, width: MediaQuery.of(context).size.width * 0.22,
                          //         decoration: BoxDecoration(
                          //             color: borderColor,
                          //             borderRadius: BorderRadius.circular(20)
                          //         ),
                          //         child: Center(
                          //           child: Text("Learn more", style: TextStyle(fontSize: 12,
                          //               fontWeight: FontWeight.w400, fontFamily: 'Poppins', color: kWhite),),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          //
                          //
                          // ),
                          Container(
                            height: MediaQuery.of(context).size.height *0.1,
                            width: MediaQuery.of(context).size.height ,
                            decoration: BoxDecoration(
                                color: kBlack,
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child:Row(
                              children: [
                                Image.asset("assets/home_page/business-investment.png"),
                                SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Save RM 37,538", textAlign: TextAlign.left, style: TextStyle(
                                            fontSize: 16, fontFamily: poppinSemiBold, color: kWhite),),
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.03),
                                        Container(
                                          height: 25, width: MediaQuery.of(context).size.width * 0.22,
                                          decoration: BoxDecoration(
                                              color: borderColor,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Center(
                                            child: Text("Learn more", textAlign: TextAlign.left, style: TextStyle(
                                                fontSize: 12, fontFamily: poppinRegular, color: kWhite),),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text("in your first year with AutoHaus Rental",textAlign: TextAlign.left,
                                        style: TextStyle(color: kWhite, fontSize: 10, fontFamily: poppinSemiBold,)),
                                  ],
                                ),

                              ],
                            ),

                          ),


                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Text("What's Included", textAlign: TextAlign.left, style: TextStyle(
                              fontSize: 14, fontFamily: poppinSemiBold, color: kBlack),),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                          myList("assets/home_page/Path 2582.png", "Periodic maintenance package (including pick up and delivery)"),
                          myList("assets/home_page/Path 2582.png", "Wear & tear (including tyres, wipers, and brake pads replacement)"),
                          myList("assets/home_page/Path 2582.png", "Comprehensive insurance coverage"),
                          myList("assets/home_page/Path 2582.png", "Personal accident coverage for driver and passengers"),
                          myList("assets/home_page/Path 2582.png", "24-hour roadside assistance (with unlimited towing and minor roadside repairs)"),
                          myList("assets/home_page/Path 2582.png", "Road tax"),
                          myList("assets/home_page/Path 2582.png", "Flux Concierge Service"),
                          myList("assets/home_page/Path 2582.png", "Theft recovery services"),
                          myList("assets/home_page/Path 2582.png", "Emergency dispatch services"),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const DeliveryAddress()));
                              },
                              child: loginButton("Next", context)),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  myList(myImage, myText){
    return Row(
      children: [
        Image.asset(myImage),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 07),
          width: MediaQuery.of(context).size.width*0.8,
          color: Colors.transparent,
          child: Text(myText, textAlign: TextAlign.left, maxLines: 2, style: TextStyle(
              fontSize: 10, fontFamily: poppinRegular, color: detailsTextColor),),
        )
      ],
    );
  }

  Widget card(){
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.42,
            decoration: BoxDecoration(
                color: kWhite,
              borderRadius: BorderRadius.circular(20)
            ),
          ),
        ),

        Positioned(
          top: 90,
          left: 10,
          child: Container(
            color: Colors.transparent,
            // height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //     color: kWhite,
            //     borderRadius: BorderRadius.circular(20)
            // ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height* 0.1,
                  ),
                  Row(
                    children: [
                      Text("TESLA | ", textAlign: TextAlign.left, style: TextStyle(color: kBlack,
                        fontSize: 14, fontFamily: 'Poppins-Bold',),),
                      Text("MODEL", textAlign: TextAlign.left, style: TextStyle(color: kBlack,
                        fontSize: 12, fontFamily: poppinRegular,),),
                      Text("Y LONG RANGE ", textAlign: TextAlign.left, style: TextStyle(color: kBlack,
                        fontSize: 14, fontFamily: 'Poppins-Medium',)),
                      Text("2022", textAlign: TextAlign.left, style: TextStyle(color: kBlack,
                        fontSize: 10, fontFamily: poppinRegular,)),
                    ],
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  Row(
                    children: [
                      Text("RM", textAlign: TextAlign.left, style: TextStyle(color: kRed,
                        fontSize: 5, fontFamily: 'Poppins-Light',),),
                      Text(" 9,000", textAlign: TextAlign.left, style: TextStyle(color: kRed, decoration: TextDecoration.lineThrough,
                        fontSize: 10,  fontFamily: 'Poppins-Light',),),
                      SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
                      Text("RM ", textAlign: TextAlign.left, style: TextStyle(color: borderColor,
                        fontSize: 7, fontFamily: poppinSemiBold,),),
                      Text("8,500", textAlign: TextAlign.left, style: TextStyle(color: borderColor,
                        fontSize: 20, fontFamily: poppinSemiBold,),),
                      Text("/ Month", textAlign: TextAlign.left, style: TextStyle(color: kBlack,
                        fontSize: 8, fontFamily: poppinRegular,),),
                      // SizedBox(width: MediaQuery.of(context).size.height * 0.01,),

                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Row(
                    children:  [
                      Image.asset("assets/home_page/Promoted.png"),
                      const SizedBox(width: 05,),
                      Text("Verified Dealer", textAlign: TextAlign.left, style: TextStyle(
                        color: textLabelColor, fontSize: 10, fontFamily: poppinRegular,),),
                      const SizedBox(width: 05,),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children:  [
                          Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
                          SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
                          Text("4.0", textAlign: TextAlign.left, style: TextStyle(
                            color: kBlack, fontSize: 14, fontFamily: poppinRegular,),),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.height * 0.1,),
                      Container(
                        height: 25, width: 60,
                        decoration: BoxDecoration(
                            color: kBlack,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Pre book", textAlign: TextAlign.left, style: TextStyle(color: kWhite,
                            fontSize: 12, fontFamily: 'Poppins-Medium',),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Text("PRE-BOOK LISTING ", textAlign: TextAlign.left, style: TextStyle(
                    color: kBlack, fontSize: 14, fontFamily: poppinSemiBold,),),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Text("This vehicle may take more than 7 days to deliver, based on vehicle’s availability",
                      textAlign: TextAlign.left, style: TextStyle(
                        color: kBlack, fontSize: 10, fontFamily: poppinRegular,)),
                ],
              ),
            ),
          ),
        ),

        Positioned(
            top: 23, left: 27,
            child: Container(
              height: MediaQuery.of(context).size.width* 0.07,
              width: MediaQuery.of(context).size.width* 0.16,
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
                  Text("5%", textAlign: TextAlign.left, style: TextStyle(color: kWhite,
                    fontSize: 13, fontFamily: poppinSemiBold,),),
                  Text("OFF", textAlign: TextAlign.left, style: TextStyle(color: kWhite, fontSize: 8, fontFamily: poppinRegular,)),
                ],
              ),
            )

        ),

        Positioned(
          top: 0,
          child: Image.asset("assets/home_page/tesla_car_image.png"),
        ),
        Positioned(
            top: 23, right: 27,
            child: Image.asset("assets/home_page/heart_transparent.png", color: kBlack,)),

      ],
    );
  }
}
