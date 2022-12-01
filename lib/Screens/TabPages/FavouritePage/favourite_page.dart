import 'package:flutter/material.dart';
import '../../../Widget/colors.dart';
import '../HomePage/Drawer/drawer_screen.dart';
import '../HomePage/Notifications/notification_screen.dart';
import '../MyAppBarHeader/app_bar_header.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
     body: Column(
       children: [
         SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
         myHeaderDrawer(context, "assets/home_page/Side_Menu.png", "Favorite", "assets/home_page/notification_image.png" ),

         // Padding(
         //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
         //   child: Row(
         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
         //     children: [
         //       GestureDetector(
         //         onTap:(){
         //           print("clicked");
         //           Navigator.push(context, MaterialPageRoute(builder: (context) => const DrawerScreen()));
         //         },
         //         child: Image.asset(
         //           "assets/home_page/Side_Menu.png", height: 25, width: 25,),),
         //
         //       Text("Favorite",
         //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kBlack),),
         //
         //       GestureDetector(
         //           onTap: (){
         //             Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
         //           },
         //           child: Image.asset("assets/home_page/notification_image.png")),
         //     ],
         //   ),
         // ),
         allFavItem(),
         // Padding(
         //   padding: const EdgeInsets.symmetric(horizontal: 20),
         //   child: Container(
         //     height: MediaQuery.of(context).size.height* 0.81,
         //     color: Colors.green,
         //     // decoration: BoxDecoration(
         //     //   color: kWhite,
         //     //   borderRadius: const BorderRadius.only(
         //     //       topRight: Radius.circular(20),
         //     //       topLeft: Radius.circular(20)),
         //     // ),
         //     // child: allChatList(),
         //     child: allFavItem(),
         //   ),
         // ),
       ],
     ),
    );
  }

  Widget allFavItem(){
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.77,
      child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: favoriteItemsList.length,
            itemBuilder: (BuildContext context, int index){
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Colors.transparent,
                  ),
                  Positioned(
                    top: 85,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.23,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height* 0.1,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${favoriteItemsList[index].carCompanyName} | ", style: TextStyle(color: kBlack,
                                          fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Poppins',),),
                                        Text(favoriteItemsList[index].textModel, style: TextStyle(color: kBlack,
                                          fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Poppins',),),
                                        Text(favoriteItemsList[index].range, style: TextStyle(color: kBlack,
                                          fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Poppins',)),
                                        Text(favoriteItemsList[index].carModelYear, style: TextStyle(color: kBlack,
                                          fontSize: 10, fontWeight: FontWeight.w400, fontFamily: 'Poppins',)),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Row(
                                      children: [
                                        Text(favoriteItemsList[index].oldPrice, style: TextStyle(color: kRed, decoration: TextDecoration.lineThrough,
                                          fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Poppins',),),
                                        Text(favoriteItemsList[index].newPrice, style: TextStyle(color: borderColor,
                                          fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Poppins',),),
                                        Text("/ Month", style: TextStyle(color: kBlack,
                                          fontSize: 8, fontWeight: FontWeight.w400, fontFamily: 'Poppins',),),
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
                                        Image.asset("assets/home_page/rating_stars.png"),
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
                                        Text("4.0", style: TextStyle(color: kBlack,
                                          fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Poppins',),),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    Row(
                                      children:  [
                                        Image.asset("assets/home_page/Promoted.png"),
                                        const SizedBox(width: 05,),
                                        Text("Verified Dealer", style: TextStyle(color: textLabelColor,
                                          fontSize: 10, fontWeight: FontWeight.w400, fontFamily: 'Poppins',),),
                                        const SizedBox(width: 05,),
                                        Container(
                                          height: 20, width: 40,
                                          decoration: BoxDecoration(
                                              color: kBlack,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Center(
                                            child: Text("New", style: TextStyle(color: kWhite,
                                              fontSize: 10, fontWeight: FontWeight.w400, fontFamily: 'Poppins',),),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset("assets/home_page/more-button.png"),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),

                  Positioned(
                      top: 10, left: 10,
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
                            Text(favoriteItemsList[index].discountText, style: TextStyle(color: kWhite,
                              fontSize: 13, fontWeight: FontWeight.w300, fontFamily: 'Poppins',),),
                            Text("OFF ", style: TextStyle(color: kWhite, fontSize: 8, fontWeight: FontWeight.w300, fontFamily: 'Poppins',)),
                          ],
                        ),
                      )

                  ),

                  Positioned(
                    top: 0,
                    child: Image.asset(favoriteItemsList[index].carImage,),
                  ),
                  Positioned(
                      top: 10, right: 10,
                      child: Image.asset("assets/home_page/heart.png",)),
                ],
              );
            }),
    );


    //   Stack(
    //   children: [
    //     Container(
    //       height: MediaQuery.of(context).size.height * 0.4,
    //       color: Colors.transparent,
    //       // child: Container(
    //       //   height: MediaQuery.of(context).size.height * 0.2,
    //       //   width: double.infinity,
    //       //   decoration: BoxDecoration(
    //       //     color: kWhite,
    //       //     borderRadius: BorderRadius.circular(20)
    //       //   ),
    //       //   child: Column(
    //       //     children: [
    //       //       Container(
    //       //         height: MediaQuery.of(context).size.height* 0.15,
    //       //       ),
    //       //       Row(
    //       //         children: const [
    //       //           Text("TESLA"),
    //       //           Text("MODEL"),
    //       //           Text("Y LONG RANGE"),
    //       //           Text("2022"),
    //       //         ],
    //       //       ),
    //       //       Row(
    //       //         children: const [
    //       //           Text("RM 9,000"),
    //       //           Text("RM8,500"),
    //       //           Text("4.0"),
    //       //           Text("*****"),
    //       //         ],
    //       //       ),
    //       //       Row(
    //       //         children: const [
    //       //           Text("Verified Dealer"),
    //       //           Text("RM8,500"),
    //       //           Text("4.0"),
    //       //           Text("*****"),
    //       //         ],
    //       //       ),
    //       //     ],
    //       //   ),
    //       // ),
    //     ),
    //     Positioned(
    //       top: 90,
    //       child: Container(
    //         height: MediaQuery.of(context).size.height * 0.2,
    //         width: MediaQuery.of(context).size.width,
    //         decoration: BoxDecoration(
    //             color: kWhite,
    //             borderRadius: BorderRadius.circular(20)
    //         ),
    //         child: Column(
    //           children: [
    //             Container(
    //               height: MediaQuery.of(context).size.height* 0.1,
    //             ),
    //             Row(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 15),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           Text("TESLA | ", style: TextStyle(color: kBlack,
    //                             fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Poppins',),),
    //                           Text("MODEL", style: TextStyle(color: kBlack,
    //                             fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Poppins',),),
    //                           Text("Y LONG RANGE ", style: TextStyle(color: kBlack,
    //                             fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Poppins',)),
    //                           Text("2022", style: TextStyle(color: kBlack,
    //                             fontSize: 10, fontWeight: FontWeight.w400, fontFamily: 'Poppins',)),
    //                         ],
    //                       ),
    //                       SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
    //                       Row(
    //                         children: [
    //                           Text("RM 9,000 ", style: TextStyle(color: kRed, decoration: TextDecoration.lineThrough,
    //                             fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Poppins',),),
    //                           Text("RM8,500", style: TextStyle(color: borderColor,
    //                             fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Poppins',),),
    //                           Text("/ Month", style: TextStyle(color: kBlack,
    //                             fontSize: 8, fontWeight: FontWeight.w400, fontFamily: 'Poppins',),),
    //                           SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
    //                           Image.asset("assets/home_page/rating_stars.png"),
    //                           SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
    //                           Text("4.0", style: TextStyle(color: kBlack,
    //                             fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Poppins',),),
    //                         ],
    //                       ),
    //                       SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
    //                       Row(
    //                         children:  [
    //                           Image.asset("assets/home_page/Promoted.png"),
    //                           SizedBox(width: 05,),
    //                           Text("Verified Dealer", style: TextStyle(color: textLabelColor,
    //                             fontSize: 10, fontWeight: FontWeight.w400, fontFamily: 'Poppins',),),
    //                           SizedBox(width: 05,),
    //                           Container(
    //                             height: 20, width: 40,
    //                             decoration: BoxDecoration(
    //                                 color: kBlack,
    //                                 borderRadius: BorderRadius.circular(10)
    //                             ),
    //                             child: Center(
    //                               child: Text("New", style: TextStyle(color: kWhite,
    //                                 fontSize: 10, fontWeight: FontWeight.w400, fontFamily: 'Poppins',),),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   crossAxisAlignment: CrossAxisAlignment.end,
    //                   children: [
    //                     Image.asset("assets/home_page/more-button.png"),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //
    //           ],
    //         ),
    //       ),
    //     ),
    //
    //     Positioned(
    //         top: 10, left: 10,
    //         child: Container(
    //           height: MediaQuery.of(context).size.width* 0.07,
    //           width: MediaQuery.of(context).size.width* 0.16,
    //           decoration: const BoxDecoration(
    //             color: Colors.red,
    //             borderRadius: BorderRadius.only(
    //               topRight: Radius.circular(15),
    //               bottomLeft: Radius.circular(15)
    //             ),
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text("5%", style: TextStyle(color: kWhite,
    //                 fontSize: 13, fontWeight: FontWeight.w300, fontFamily: 'Poppins',),),
    //               Text("OFF ", style: TextStyle(color: kWhite, fontSize: 8, fontWeight: FontWeight.w300, fontFamily: 'Poppins',)),
    //             ],
    //           ),
    //         )
    //
    //     ),
    //
    //     Positioned(
    //       top: 0,
    //       child: Image.asset("assets/home_page/tesla_car_image.png",),
    //     ),
    //     Positioned(
    //         top: 10, right: 10,
    //         child: Image.asset("assets/home_page/heart.png",)),
    //   ],
    // );
  }

}


List favoriteItemsList = [
  FavoriteItemsClass( "assets/home_page/tesla_car_image.png", "5%",'TESLA', "MODEL", "Y LONG RANGE ", "2022" ,"RM 9,000", "RM8,500"),
  FavoriteItemsClass( "assets/home_page/bmw_car_image.png", "5%",'TESLA', "MODEL", "Y LONG RANGE ", "2022" ,"RM 9,000", "RM8,500"),
  FavoriteItemsClass( "assets/home_page/tesla_car_image.png", "5%",'TESLA', "MODEL", "Y LONG RANGE ", "2022" ,"RM 9,000", "RM8,500"),
];

class FavoriteItemsClass {
  final String carImage;
  final String discountText;
  final String carCompanyName;
  final String textModel;
  final String range;
  final String carModelYear;
  final String oldPrice;
  final String newPrice;

  FavoriteItemsClass(this.carImage, this.discountText, this.carCompanyName, this.textModel, this.carModelYear, this.range, this.oldPrice, this.newPrice);
}
