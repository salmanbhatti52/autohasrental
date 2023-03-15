import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'BookForWedding/book_for_wedding_car_page.dart';
import 'DrivingExperience/driving_experience_page.dart';
import 'EvSubscriptions/ev_subscription_page.dart';

String? myEvCar, myPhotoCar, myDrivingCar;
String carsUsageType = "EV Subscriptions";

Widget homeTopHorizontalCard(BuildContext context){
  return Container(
    height: MediaQuery.of(context).size.height * 0.14,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: cardItemsList.length,
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                  switch(index) {
                    case 0:
                      Navigator.push(context, MaterialPageRoute(
                            builder: (context) => EvSubscriptionPage()));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(
                            builder: (context) => BookForWeddingPage(
                        )));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DrivingExperiencePage()));
                      break;
                  }
                },
              child: Container(
                height: 70, width: 220,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: cardItemsList[index].color,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  children: [
                   Image.asset(cardItemsList[index].image),
                    const SizedBox(width: 05,),
                    Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width* 0.35,
                        child: Text(cardItemsList[index].title, textAlign: TextAlign.left,
                          style: TextStyle(color: kBlack, fontFamily: poppinRegular, fontSize: 14),)),
                  ],
                ),
              ),
            ),
          );
        }),
  );
}

List cardItemsList = [
  CardItems( "assets/home_page/pin.png", 'Get Ev Subscription', const Color(0xffF9E7EF)),
  CardItems( "assets/home_page/camera.png", 'Book for Wedding & Photography', const Color(0xffD2EEFF)),
  CardItems( "assets/home_page/steering.png", 'Get Driving Experiences', const Color(0xffFFE2DB)),
];

class CardItems {
  final String image, title;
  final Color color;
  CardItems(this.image, this.title, this.color);
}
