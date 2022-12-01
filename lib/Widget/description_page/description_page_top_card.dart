import 'package:flutter/material.dart';

import '../colors.dart';

Widget myHorizontalCard2(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.12,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: cardItemsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 70,
              width: 165,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: cardItemsList[index].color,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Image.asset(
                    cardItemsList[index].imageurl,
                    width: 22,
                    height: 22,
                  ),
                  const SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.6),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            cardItemsList[index].title,
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Poppins-Medium',
                                color: kWhite),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            cardItemsList[index].subtitle,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins-Regular',
                                color: kWhite),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}

List cardItemsList = [
  _CardItems('assets/car_description_images/white_tick.png', '48 Months',
      'RM 6,365', borderColor),
  _CardItems('assets/car_description_images/grey_tick.png', '60 Months',
      'RM 5,225', kBlack),
];

class _CardItems {
  final String imageurl;
  final String title;
  final String subtitle;
  final Color color;

  _CardItems(
      this.imageurl,
      this.title,
      this.subtitle,
      this.color,
      );
}
