import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/material.dart';
import '../../../../../Model/HomePageModels/FavoritesModel/car_favorite_like_unlike_model.dart';
import '../../../../../Model/HomePageModels/HomeTopWidgetModels/photography_model.dart';
import '../../Filter/filter_screen.dart';
import 'book_for_wedding_car_description.dart';
import 'book_for_wedding_car_logo_container.dart';
import 'package:http/http.dart' as http;

class BookForWeddingPage extends StatefulWidget {
  const BookForWeddingPage({Key? key}) : super(key: key);

  @override
  State<BookForWeddingPage> createState() => _BookForWeddingPageState();
}

class _BookForWeddingPageState extends State<BookForWeddingPage> {
  PhotoGraphyModel carsPhotoGraphyModelObject = PhotoGraphyModel();
  CarLikeUnlikeModel carLikeUnlikeModelObject = CarLikeUnlikeModel();
  String? myCurrentCarIndex;
  bool loadingP = true;

  @override
  void initState() {
    super.initState();
    getCarsPhotoGraphyWidget();
  }

  getCarsPhotoGraphyWidget() async {
    loadingP = true;
    setState(() {});
    // try {
      String apiUrl = carsPhotoGraphyApiUrl;
      print("carsPhotographyApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id" : userId
          },
          headers: {
        'Accept': 'application/json'
      });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("carsPhotoGraphyResponse: ${responseString.toString()}");
        carsPhotoGraphyModelObject = photoGraphyModelFromJson(responseString);
        print("carsPhotoGraphyObjectLength: ${carsPhotoGraphyModelObject.status}");
      }
    // } catch (e) {
    //   print('Error: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

  getLikeUnlikeCarWidget() async {
    loadingP = true;
    setState(() {});
    try {
      String apiUrl = likeUnlikeFavoriteCarsApiUrl;
      print("carLikeUnlikeModelApi: $apiUrl");
      print("carLikeUnlikeUserId: $userId");
      print("carId: $myCurrentCarIndex");
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "users_customers_id": userId,
          "cars_id": myCurrentCarIndex,
        },
        headers: {'Accept': 'application/json'},
      );
      print('statusCodeLikeUnlike ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseString = response.body;
        print("carLikeUnlikeModelResponse: ${responseString.toString()}");
        carLikeUnlikeModelObject = carLikeUnlikeModelFromJson(responseString);
        print("carLikeUnlikeModelMessage: ${carLikeUnlikeModelObject.message}");
      }
    } catch (e) {
      print('Error in carLikeUnlike: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarDoubleImage(
          frontImage: "assets/home_page/back_arrow.png",
          title: "Book for Wedding",
          backImage: "assets/home_page/notification_image.png"),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 12, 10, 0),
                          hintText: 'Search for Cars',
                          hintStyle: const TextStyle(color: Color(0xffD4DCE1)),
                          focusColor: borderColor,
                          suffixIcon: const Icon(
                            Icons.search_outlined,
                            color: Color(0xffD4DCE1),
                          ),
                        ),
                        style: TextStyle(color: borderColor,
                          fontSize: 14, fontFamily: poppinLight)),
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const FilterScreen()));
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30)),
                        child: Image.asset("assets/home_page/filter.png")),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: const BookForWeddingCarLogoContainer()),
            ),
            photographyCarsListWidget(),
          ],
        ),
      ),
    );
  }

  Widget photographyCarsListWidget() {
    return SingleChildScrollView(
      child: loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
          : carsPhotoGraphyModelObject.status != "success" ?
      const Center(child: Text('no data found...',
          style: TextStyle(fontWeight: FontWeight.bold))) :
      Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.70,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: carsPhotoGraphyModelObject.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.33,),
                  ),
                  Positioned(
                    top: 90,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.26,
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
                            Container(height: MediaQuery.of(context).size.height * 0.1),
                            Row(
                              children: [
                                const SizedBox(height: 93.6),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("${carsPhotoGraphyModelObject.data![index].vehicalName} ",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                color: kBlack, fontSize: 14, fontFamily: poppinBold)),

                                          Text("${carsPhotoGraphyModelObject.data![index].carsColors!.name} ",
                                              textAlign: TextAlign.left, style: TextStyle(
                                                  color: kBlack, fontSize: 14, fontFamily: poppinRegular)),
                                        ],
                                      ),
                                      Row(
                                        children: [

                                          Text("${carsPhotoGraphyModelObject.data![index].carsMakes!.name}, ",
                                              textAlign: TextAlign.left, style: TextStyle(
                                                  color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                          Text("${carsPhotoGraphyModelObject.data![index].carsModels!.name}, ",
                                              textAlign: TextAlign.left, style: TextStyle(
                                                  color: kBlack, fontSize: 12, fontFamily: poppinSemiBold)),
                                          Text("${carsPhotoGraphyModelObject.data![index].year} ",
                                              textAlign: TextAlign.left, style: TextStyle(
                                                  color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 04),
                                            child: Text("RM", textAlign: TextAlign.left,
                                                style: TextStyle(color: kRed,
                                                  fontSize: 5, fontFamily: poppinRegular)),
                                          ),
                                          Text("${carsPhotoGraphyModelObject.data![index].carsPlans![0].pricePerHour}",
                                            textAlign: TextAlign.left, style: TextStyle(
                                              color: kRed, decoration: TextDecoration.lineThrough,
                                              decorationColor: kRed, decorationThickness: 3,
                                              fontSize: 10, fontFamily: poppinLight, height: 2)),
                                          const SizedBox(width: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 06),
                                            child: Text("RM", textAlign: TextAlign.left,
                                                style: TextStyle(color: borderColor,
                                                  fontSize: 7, fontFamily: poppinSemiBold)),
                                          ),
                                          Text("${carsPhotoGraphyModelObject.data![index].carsPlans![0].discountedPricePerHour}",
                                            textAlign: TextAlign.left, style: TextStyle(
                                              color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                          Text("/Hour", textAlign: TextAlign.left,
                                            style: TextStyle(color: kBlack, fontSize: 8,
                                              fontFamily: poppinRegular)),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.height * 0.01),
                                          showRatingStars(double.parse("${carsPhotoGraphyModelObject.data![index].rating}")),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.01),
                                          carsPhotoGraphyModelObject.data![index].rating == null
                                              ? Text("0.0", style: TextStyle(
                                                color: kBlack, fontSize: 10,
                                                fontFamily: poppinMedium))
                                              : Text("${carsPhotoGraphyModelObject.data![index].rating}",
                                              textAlign: TextAlign.left, style: TextStyle(
                                                  color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                      Row(
                                        children: [
                                          Image.asset("assets/car_bookings_images/promoted.png"),
                                          const SizedBox(width: 5,),
                                          Text("Verified Dealer", textAlign: TextAlign.left,
                                            style: TextStyle(color: textLabelColor,
                                              fontSize: 10, fontFamily: poppinRegular)),
                                          const SizedBox(width: 05),
                                          Container(
                                            height: 15,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                color: kBlack,
                                                borderRadius: BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text("New", textAlign: TextAlign.left,
                                                  style: TextStyle(color: kWhite,
                                                      fontSize: 8, fontFamily: poppinRegular)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    bottom: 35,
                    child: GestureDetector(
                      onTap: () {
                        carID = carsPhotoGraphyModelObject.data![index].carsId;
                        print("myCarId $carID");
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => BookForWeddingCarDescription(
                              carName: carsPhotoGraphyModelObject.data![index].vehicalName,
                              carYear: "${carsPhotoGraphyModelObject.data![index].year}",
                              carId: carsPhotoGraphyModelObject.data![index].carsId,
                              carRating: carsPhotoGraphyModelObject.data![index].rating,
                              carColorName: carsPhotoGraphyModelObject.data![index].carsColors!.name,
                              carMakesName: carsPhotoGraphyModelObject.data![index].carsMakes!.name,
                              carModelName: carsPhotoGraphyModelObject.data![index].carsModels!.name,
                              carImage: "$baseUrlImage${carsPhotoGraphyModelObject.data![index].image1}",
                              carMakesImage: "$baseUrlImage${carsPhotoGraphyModelObject.data![index].carsMakes!.image}",
                              favouriteStatus: carsPhotoGraphyModelObject.data![index].favouriteStatus,
                              discountPercentage: carsPhotoGraphyModelObject.data![index].discountPercentage,
                              carDiscountPrice: carsPhotoGraphyModelObject.data![index].carsPlans![0].discountedPricePerHour,
                              carPrice: carsPhotoGraphyModelObject.data![index].carsPlans![0].pricePerHour,
                              carOwnerImage: "$baseUrlImage${carsPhotoGraphyModelObject.data![index].usersCompanies!.companyLogo}",
                              carOwnerName: "${carsPhotoGraphyModelObject.data![index].usersCompanies!.companyName}",
                              carOwnerId: carsPhotoGraphyModelObject.data![index].usersCompanies!.usersCompaniesId,
                              myCarDescription: carsPhotoGraphyModelObject.data![index].description,
                              myCarRating: carsPhotoGraphyModelObject.data![index].carsRatings![0].rateStars,
                              myCarComment: carsPhotoGraphyModelObject.data![index].carsRatings![0].comments,
                              // datumPhotography: carsPhotoGraphyModelObject.data![index],
                            )));
                        print("evCarName ${carsPhotoGraphyModelObject.data![index].vehicalName}");
                        print("evCarYear ${carsPhotoGraphyModelObject.data![index].year}");
                        print("evCarPerHours ${carsPhotoGraphyModelObject.data![index].carsPlans![0].pricePerHour}");
                        print("evCarImage $baseUrlImage${carsPhotoGraphyModelObject.data![index].image1}");
                        print("evCarId ${carsPhotoGraphyModelObject.data![index].carsId}");
                        },
                      child: Image.asset("assets/car_bookings_images/more_button.png"),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    left: 10,
                    right: 10,
                    child: carsPhotoGraphyModelObject.data![index].image1 == null
                        ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                            'assets/icon/fade_in_image.jpeg'))
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        placeholder: const AssetImage("assets/icon/fade_in_image.jpeg"),
                        // width: 300,
                        height: 135,
                        image: NetworkImage(
                            "$baseUrlImage${carsPhotoGraphyModelObject.data![index].image1}"),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 10, left: 15,
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
                            Text("${carsPhotoGraphyModelObject.data![index].discountPercentage}",
                                textAlign: TextAlign.left, style: TextStyle(
                                    color: kWhite, fontSize: 13, fontFamily: poppinSemiBold)),
                            Text(" OFF ", textAlign: TextAlign.left,
                                style: TextStyle(color: kWhite,
                                    fontSize: 8, fontFamily: poppinRegular)),
                          ],
                        ),
                      )),
                  Positioned(
                    top: 10,
                    right: 15,
                    child: carsPhotoGraphyModelObject.data![index].favouriteStatus == "like"?
                    Image.asset("assets/home_page/heart.png"):
                    GestureDetector(
                      onTap: () async {
                        myCurrentCarIndex = "${carsPhotoGraphyModelObject.data![index].carsId}";
                        print("carsPhotoGraphyIds $myCurrentCarIndex");
                        await getLikeUnlikeCarWidget();
                        if (carLikeUnlikeModelObject.message == "Liked") {
                          print("isLiked");
                          toastSuccessMessage("${carLikeUnlikeModelObject.message}", colorGreen);
                        }
                        if (carLikeUnlikeModelObject.message == "Unliked") {
                          print("isUnLiked");
                          toastSuccessMessage("${carLikeUnlikeModelObject.message}", colorGreen);
                        }
                        },
                      child: carLikeUnlikeModelObject.message == "Liked"
                          ? Image.asset("assets/home_page/heart.png")
                          : Image.asset("assets/car_bookings_images/heart.png"),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
