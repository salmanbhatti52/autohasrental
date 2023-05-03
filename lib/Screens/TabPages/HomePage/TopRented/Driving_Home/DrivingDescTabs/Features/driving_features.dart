
import 'package:flutter/cupertino.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/top_rented_cars_model.dart';

class DrivingFeatures extends StatefulWidget {
  final DatumTopRented? datumTopRented;
  DrivingFeatures({super.key, this.datumTopRented});

  @override
  State<DrivingFeatures> createState() => _DrivingFeaturesState();
}

class _DrivingFeaturesState extends State<DrivingFeatures> {

  String? featureSuv, featuresSeats, featuresSpeed, featuresAutomatic, featuresDoors,
      featuresElectric, featuresEngineCapacity, featuresFuelCapacity, featuresMeterReading, featuresNewCars;

  getData(){
    featureSuv = widget.datumTopRented!.featuresSuv;
    featuresSeats = widget.datumTopRented!.featuresSeats;
    featuresSpeed = widget.datumTopRented!.featuresSpeed;
    featuresAutomatic = widget.datumTopRented!.featuresAutomatic;
    featuresDoors = widget.datumTopRented!.featuresDoors;
    featuresElectric = widget.datumTopRented!.featuresElectric;
    featuresEngineCapacity = widget.datumTopRented!.featuresEngineCapacity;
    featuresFuelCapacity = widget.datumTopRented!.featuresFuelCapacity;
    featuresMeterReading = widget.datumTopRented!.featuresMeterReading;
    featuresNewCars = widget.datumTopRented!.featuresNewCars;

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
    // TODO: implement initState
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

                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget carFeaturesData(String featureImage, String featureName){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2),
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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(text1, style: TextStyle(fontSize: 30, fontFamily: poppinRegular, height: 0.8)), //bullet text
          SizedBox(width: 10), //space between bullet and text
          Expanded(
            child: Text(text2, style: TextStyle(fontSize: 12,
              fontFamily: poppinRegular, color: kBlack, height: 0.8)),
          ),
        ],
      ),
    );
  }
}
