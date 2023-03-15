import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../../../../Model/BookingModels/Previous/Photo/photo_previous_model.dart';

class PhotoRatingDetails extends StatefulWidget {
  final DatumPhotoPrevious? datumP;
  const PhotoRatingDetails({super.key, this.datumP});

  @override
  State<PhotoRatingDetails> createState() => _PhotoRatingDetailsState();
}

class _PhotoRatingDetailsState extends State<PhotoRatingDetails> {

  String? userFirstName, userLastName, userImage;
  bool loading = true;
  sharedPrefs() async {
    loading = true;
    setState(() {});
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    userFirstName = (prefs!.getString('user_first_name'));
    userLastName = (prefs!.getString('user_last_name'));
    userImage = (prefs!.getString('profile_pic'));
    print("userId is = $userId");
    print("userName is = $userFirstName $userLastName");
    print("userImage is = $baseUrlImage$userImage");
    print("photoCarsRatingsLength ${widget.datumP!.carsRatings!.length}");
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPrefs();

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          allRatingList(),
        ],
      ),
    );
  }
  Widget allRatingList() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: widget.datumP!.carsRatings!.length,
        itemBuilder: (BuildContext context, int index) {
          print("carsRatingsLength ${widget.datumP!.carsRatings!.length}");
          return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: "$baseUrlImage${widget.datumP!.carsRatings![index].usersData![0].profilePic}",
                    height: 50, width: 50,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(strokeWidth: 2, value: downloadProgress.progress, color: borderColor,),
                    errorWidget: (context, url, error) => Image.asset("assets/icon/fade_in_image.jpeg"),

                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget.datumP!.carsRatings![index].usersData![0].firstName} ${widget.datumP!.carsRatings![index].usersData![0].lastName} ",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          )),

                      Row(
                        children: [
                          showRatingStars(double.parse("${widget.datumP!.carsRatings![index].rateStars}")),

                          const SizedBox(width: 05,),
                          Text("${widget.datumP!.carsRatings![index].rateStars}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "${widget.datumP!.carsRatings![index].comments}",
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}


List ratingItemsList = [
  RatingClass(
    "assets/car_description_images/user.png",
    'Josh Gibson',
    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
    "assets/car_description_images/rating.png",
  ),
  RatingClass(
    "assets/car_description_images/user.png",
    'Josh Gibson',
    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
    "assets/car_description_images/rating.png",
  ),
  RatingClass(
    "assets/car_description_images/user.png",
    'Josh Gibson',
    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
    "assets/car_description_images/rating.png",
  ),
  RatingClass(
    "assets/car_description_images/user.png",
    'Josh Gibson',
    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
    "assets/car_description_images/rating.png",
  ),
];

class RatingClass {
  final String image;
  final String name;
  final String description;
  final String image2;

  RatingClass(
      this.image,
      this.name,
      this.description,
      this.image2,
      );
}

