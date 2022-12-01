import 'package:flutter/material.dart';

import '../../colors.dart';

Widget myHorizontalCard3(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.33,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 3,
              crossAxisSpacing: 8.5,
              mainAxisSpacing: 30),
          itemCount: cardItemsList.length,
          itemBuilder: (BuildContext context, index) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Image.asset(
                        cardItemsList[index].imageurl,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        cardItemsList[index].title,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: kBlack),
                      ),
                    )
                  ],
                ),
              ],
            );
          }),
    ),
  );
}

List cardItemsList = [
  _CardItems('assets/car_description_images/jeep.png', 'SUV'),
  _CardItems('assets/car_description_images/car_door.png', '2 Doors'),
  _CardItems('assets/car_description_images/car_seat.png', '5 Seats'),
  _CardItems('assets/car_description_images/car_gear.png', 'Automatic'),
  _CardItems('assets/car_description_images/car_down_view.png', 'ADW'),
  _CardItems('assets/car_description_images/car_speedometer.png', '4.8 Sec'),
  _CardItems('assets/car_description_images/car_battery.png', 'Electric'),
  _CardItems('assets/car_description_images/car_engine.png', '175 KW/H'),
  _CardItems('assets/car_description_images/car_wheel.png', '533 KM'),
  _CardItems('assets/car_description_images/car_oil.png', 'TBD'),
  _CardItems('assets/car_description_images/car_front_view.png', '5,000 KM'),
  _CardItems('assets/car_description_images/star.png', 'New Car'),
];

class _CardItems {
  final String imageurl;
  final String title;

  _CardItems(
    this.imageurl,
    this.title,
  );
}
