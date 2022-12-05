import 'package:flutter/material.dart';
import '../../../Widget/colors.dart';
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          myHeaderDrawer(context, "assets/home_page/Side_Menu.png", "Favorite",
              "assets/home_page/notification_image.png"),
          allFavItem(),
        ],
      ),
    );
  }

  Widget allFavItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.75,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: favoriteItemsList.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
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
                        height: MediaQuery.of(context).size.height * 0.24,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${favoriteItemsList[index].carCompanyName} | ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 14,
                                              fontFamily: 'Poppins-Bold',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "${favoriteItemsList[index].textModel} ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 12,
                                              fontFamily: 'Poppins-Regular',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "${favoriteItemsList[index].carModelYear} ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 14,
                                              fontFamily: 'Poppins-Medium',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            favoriteItemsList[index].range,
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 10,
                                              fontFamily: 'Poppins-Regular',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.01,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 04),
                                            child: Text(
                                              "RM",
                                              style: TextStyle(
                                                color: kRed,
                                                fontSize: 5,
                                                fontFamily: 'Poppins-Regular',
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                            favoriteItemsList[index].oldPrice,
                                            style: TextStyle(
                                              color: kRed,
                                              decoration:
                                              TextDecoration.lineThrough,
                                              decorationColor: kRed,
                                              decorationThickness: 3,
                                              fontSize: 10,
                                              fontFamily: 'Poppins-Light',
                                              height: 2,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(width: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 06),
                                            child: Text(
                                              "RM",
                                              style: TextStyle(
                                                color: borderColor,
                                                fontSize: 7,
                                                fontFamily: 'Poppins-SemiBold',
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                            favoriteItemsList[index].newPrice,
                                            style: TextStyle(
                                              color: borderColor,
                                              fontSize: 20,
                                              fontFamily: 'Poppins-SemiBold',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "/ Month",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 8,
                                              fontFamily: 'Poppins-Regular',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                          ),
                                          Image.asset(
                                              "assets/car_bookings_images/rating_stars.png"),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                          ),
                                          Text(
                                            "4.0",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 12,
                                              fontFamily: 'Poppins-Regular',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.01),
                                      Row(
                                        children: [
                                          Image.asset(
                                              "assets/car_bookings_images/promoted.png"),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Verified Dealer",
                                            style: TextStyle(
                                              color: textLabelColor,
                                              fontSize: 10,
                                              fontFamily: 'Poppins-Regular',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(
                                            width: 05,
                                          ),
                                          Container(
                                            height: 20,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: kBlack,
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                "New",
                                                style: TextStyle(
                                                  color: kWhite,
                                                  fontSize: 8,
                                                  fontFamily: 'Poppins-Regular',
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
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
                                    Image.asset(
                                        "assets/car_bookings_images/more_button.png"),
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
                              favoriteItemsList[index].discountText,
                              style: TextStyle(
                                color: kWhite,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(" OFF ",
                                style: TextStyle(
                                  color: kWhite,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Poppins',
                                )),
                          ],
                        ),
                      )),
                  Positioned(
                    child: Image.asset(
                      favoriteItemsList[index].carImage,
                    ),
                  ),
                  Positioned(
                      top: 10,
                      right: 15,
                      child: Image.asset(
                        "assets/home_page/heart.png",
                      )),
                ],
              );
            }),
      ),
    );
  }
}

List favoriteItemsList = [
  FavoriteItemsClass("assets/home_page/tesla_car_image.png", "5%", 'TESLA',
      "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  FavoriteItemsClass("assets/home_page/bmw_car_image.png", "5%", 'TESLA',
      "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  FavoriteItemsClass("assets/home_page/tesla_car_image.png", "5%", 'TESLA',
      "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
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

  FavoriteItemsClass(
      this.carImage,
      this.discountText,
      this.carCompanyName,
      this.textModel,
      this.carModelYear,
      this.range,
      this.oldPrice,
      this.newPrice);
}
