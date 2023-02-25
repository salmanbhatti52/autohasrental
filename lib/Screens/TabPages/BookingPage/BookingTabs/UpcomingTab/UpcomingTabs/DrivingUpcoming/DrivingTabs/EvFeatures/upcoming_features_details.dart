import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/cupertino.dart';

class UpComingFeaturesDetails extends StatelessWidget {
  const UpComingFeaturesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          featuretext("\u2022", "Drive this car up to 1,250 KM/month", context),
          featuretext("\u2022", "Comprehensive insurance", context),
          featuretext("\u2022", "Road tax", context),
          featuretext("\u2022", "Regularly scheduled maintenance", context),
          featuretext("\u2022", "Concierge service", context),
          featuretext("\u2022", "24/7 nationwide roadside assistance", context),
          featuretext("\u2022", "Ability to swap a car", context),
          featuretext("\u2022", "Anti-theft system", context),
          featuretext("\u2022", "Independently rated car inspection", context),
          const SizedBox(height: 10),
          myHorizontalCard3(context),
        ],
      ),
    );
  }
  Widget featuretext(text1, text2, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            text1,
            style: const TextStyle(fontSize: 30, height: 0.8),
          ), //bullet text
          const SizedBox(width: 10), //space between bullet and text
          Expanded(
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 12,
                color: kBlack,
                height: 0.8,
              ),
            ), //text
          ),
        ],
      ),
    );
  }

  Widget myHorizontalCard3(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.33,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
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
