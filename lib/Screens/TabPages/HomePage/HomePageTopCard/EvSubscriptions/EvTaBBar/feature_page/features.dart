
import 'package:flutter/cupertino.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';

class Features extends StatefulWidget {

  final String? featureSuv, featuresSeats, featuresSpeed, featuresDoors,
      featuresAutomatic,  featuresElectric, featuresEngine_capacity,
      featuresFuelCapacity, featuresMeterReading, featuresNewCars;

  Features({super.key, this.featureSuv, this.featuresSeats, this.featuresSpeed,
    this.featuresAutomatic, this.featuresDoors, this.featuresElectric, this.featuresEngine_capacity,
    this.featuresFuelCapacity, this.featuresMeterReading, this.featuresNewCars});

  @override
  State<Features> createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {

  String? featureSuv, featuresSeats, featuresSpeed, featuresAutomatic,
      featuresDoors, featuresElectric, featuresEngineCapacity,
      featuresFuelCapacity, featuresMeterReading, featuresNewCars;

  getData(){
    featureSuv = widget.featureSuv;
    featuresSeats = widget.featuresSeats;
    featuresSpeed = widget.featuresSpeed;
    featuresAutomatic = widget.featuresAutomatic;
    featuresDoors = widget.featuresDoors;
    featuresElectric = widget.featuresElectric;
    featuresEngineCapacity = widget.featuresEngine_capacity;
    featuresFuelCapacity = widget.featuresFuelCapacity;
    featuresMeterReading = widget.featuresMeterReading;
    featuresNewCars = widget.featuresNewCars;

    print("featureSuv ${featureSuv}");
    print("featuresSeats ${featuresSeats}");
    print("featuresSpeed ${featuresSpeed}");
    print("featuresAutomatic ${featuresAutomatic}");
    print("featuresDoors ${featuresDoors}");
    print("featuresElectric ${featuresElectric}");
    print("featuresEngine_capacity ${featuresEngineCapacity}");
    print("featuresFuelCapacity ${featuresFuelCapacity}");
    print("featuresMeterReading ${featuresMeterReading}");
    print("featuresNewCars ${featuresNewCars}");
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          featureTextWidget("\u2022", "Drive this car up to 1,250 KM/month", context),
          featureTextWidget("\u2022", "Comprehensive insurance", context),
          featureTextWidget("\u2022", "Road tax", context),
          featureTextWidget("\u2022", "Regularly scheduled maintenance", context),
          featureTextWidget("\u2022", "Concierge service", context),
          featureTextWidget("\u2022", "24/7 nationwide roadside assistance", context),
          featureTextWidget("\u2022", "Ability to swap a car", context),
          featureTextWidget("\u2022", "Anti-theft system", context),
          featureTextWidget("\u2022", "Independently rated car inspection", context),
           SizedBox(height: 10),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    carFeaturesData('assets/car_description_images/jeep.png', featureSuv == 'Yes'? 'SUV': 'PWD' ),
                    carFeaturesData('assets/car_description_images/car_door.png', '$featuresDoors' ),
                    carFeaturesData('assets/car_description_images/car_seat.png', '$featuresSeats' ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    carFeaturesData('assets/car_description_images/car_gear.png', '$featuresAutomatic' ),
                    carFeaturesData('assets/car_description_images/car_down_view.png', 'ADW' ),
                    carFeaturesData('assets/car_description_images/car_speedometer.png', '$featuresSpeed' ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    carFeaturesData('assets/car_description_images/car_battery.png', '$featuresElectric' ),
                    carFeaturesData('assets/car_description_images/car_engine.png', '$featuresEngineCapacity' ),
                    carFeaturesData('assets/car_description_images/car_wheel.png', '$featuresMeterReading' ),
                  ],
                ),
                // SizedBox(height: 15),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     carFeaturesData('assets/car_description_images/car_oil.png', 'TBD' ),
                //     carFeaturesData('assets/car_description_images/car_front_view.png', '5,000 KM' ),
                //     carFeaturesData('assets/car_description_images/star.png', 'New Car' ),
                //   ],
                // ),
                SizedBox(height: 10),
              ],
            ),
          ),
          // myHorizontalCard3(context),
        ],
      ),
    );
  }

  Widget carFeaturesData(String featureImage, String featureName){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.only(top: 2),
          child: Image.asset(featureImage,
              height: 20, width: 34),
        ),
        SizedBox(width: 6),
        Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(featureName,
            textAlign: TextAlign.left, style: TextStyle(
                fontSize: 13, fontFamily: poppinMedium, color: kBlack),
          ),
        )
      ],
    );
  }

  Widget featureTextWidget(text1, text2, context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(text1,
            style: TextStyle(
                fontSize: 30, fontFamily: poppinRegular, height: 0.8),
          ), //bullet text
           SizedBox(width: 10), //space between bullet and text
          Expanded(
            child: Text(text2, style: TextStyle(
                fontSize: 12, fontFamily: poppinRegular,
                color: kBlack, height: 0.8,
              ),
            ), //text
          ),
        ],
      ),
    );
  }

  Widget myHorizontalCard3(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      width: double.infinity,
      padding:  EdgeInsets.only(left: 20, right: 20),
      child: GridView.builder(
          physics:  NeverScrollableScrollPhysics(),
          gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
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
                      padding:  EdgeInsets.only(top: 2),
                      child: Image.asset(cardItemsList[index].imageUrl,
                        height: 20, width: 34),
                    ),
                    SizedBox(width: 6),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(cardItemsList[index].title,
                        textAlign: TextAlign.left, style: TextStyle(
                            fontSize: 13, fontFamily: poppinMedium, color: kBlack),
                      ),
                    )
                  ],
                ),
              ],
            );
          }),
    );
  }
}

List cardItemsList = [
  _CardItems('assets/car_description_images/jeep.png', 'SUV'),
  _CardItems('assets/car_description_images/car_door.png', '2 Doors'),
  _CardItems('assets/car_description_images/car_seat.png', '5 Seats'),
  _CardItems('assets/car_description_images/car_gear.png', 'Auto'),
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
  final String imageUrl, title;

  _CardItems(this.imageUrl, this.title);
}
