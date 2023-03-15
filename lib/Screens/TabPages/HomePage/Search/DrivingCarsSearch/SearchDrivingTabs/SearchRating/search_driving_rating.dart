import 'package:auto_haus_rental_app/Model/search_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchDrivingRating extends StatefulWidget {
  final SearchDatum? searchDatum;
  const SearchDrivingRating({super.key, this.searchDatum});

  @override
  State<SearchDrivingRating> createState() => _SearchDrivingRatingState();
}

class _SearchDrivingRatingState extends State<SearchDrivingRating> {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: CachedNetworkImage(
                    imageUrl: "$baseUrlImage$userImage",
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
                      Text("$userFirstName $userLastName",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          )),

                      Row(
                        children: [
                          showRatingStars(double.parse("${widget.searchDatum!.rating}")),

                          const SizedBox(width: 05,),
                          Text("${widget.searchDatum!.rating}",
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
                    "${widget.searchDatum!.carsRatings![0].comments}",
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
