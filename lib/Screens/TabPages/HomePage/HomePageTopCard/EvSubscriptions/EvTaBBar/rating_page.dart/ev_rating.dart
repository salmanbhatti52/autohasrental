import 'package:auto_haus_rental_app/Model/get_cars_rating_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class EvRating extends StatefulWidget {


  const EvRating({super.key});

  @override
  State<EvRating> createState() => _EvRatingState();
}

class _EvRatingState extends State<EvRating> {

  GetCarsRatingById getCarsRatingByIdObject = GetCarsRatingById();
  bool loadingP = true;
  getCarRatingWidget() async {
    loadingP = true;
    setState(() {});
    print('in getCarRatingByIdApi');

    // try {
    String apiUrl = getCarRatingByIdApiUrl;
    print("getCarRatingByIdApi: $apiUrl");
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      "cars_id": "$carID",
    });
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("responseGetCarRating: ${responseString.toString()}");
      loadingP = false;
      setState(() {});
      getCarsRatingByIdObject = getCarsRatingByIdFromJson(responseString);
      print("getCarRatingLength: ${getCarsRatingByIdObject.data?.length}");
    }
    // } catch (e) {
    //   print('Error in upcomingBookingCar: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCarRatingWidget();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          allRatingList(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: kWhite,
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: ListTile(
          //       leading: ClipRRect(
          //         borderRadius: BorderRadius.circular(18),
          //         child: CachedNetworkImage(
          //           imageUrl: "$baseUrlImage$userImage",
          //           height: 50, width: 50,
          //           fit: BoxFit.fill,
          //           progressIndicatorBuilder: (context, url, downloadProgress) =>
          //               CircularProgressIndicator(strokeWidth: 2, value: downloadProgress.progress, color: borderColor,),
          //           errorWidget: (context, url, error) => Image.asset("assets/icon/fade_in_image.jpeg"),
          //
          //         ),
          //       ),
          //       title: Padding(
          //         padding: const EdgeInsets.only(top: 5, bottom: 2),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text("$userFirstName $userLastName",
          //                 style: const TextStyle(
          //                   fontSize: 15,
          //                   fontWeight: FontWeight.w500,
          //                   fontFamily: 'Poppins',
          //                 )),
          //
          //             Row(
          //               children: [
          //                 showRatingStars(double.parse("${widget.carRating}")),
          //
          //                 const SizedBox(width: 05,),
          //                 Text("${widget.carRating}",
          //                     style: const TextStyle(
          //                       fontSize: 15,
          //                       fontWeight: FontWeight.w500,
          //                       fontFamily: 'Poppins',
          //                     )),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //       subtitle: Padding(
          //         padding: const EdgeInsets.only(bottom: 5),
          //         child: widget.carComment == null?
          //         const Text(
          //           "no comment" ?? "",
          //           style: TextStyle(
          //             fontSize: 10,
          //             fontFamily: 'Poppins',
          //           ),
          //         ):
          //         Text(
          //           "${widget.carComment}" ?? "",
          //           style: const TextStyle(
          //             fontSize: 10,
          //             fontFamily: 'Poppins',
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget allRatingList() {
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor)) :
      getCarsRatingByIdObject.status != "success" ?  Center(
          child: Text('no data found...', style: TextStyle(fontWeight: FontWeight.bold))):
      ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: getCarsRatingByIdObject.data?.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: "$baseUrlImage${getCarsRatingByIdObject.data![index].usersData![0].profilePic}",
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
                      Text("${getCarsRatingByIdObject.data![index].usersData![0].firstName} ${getCarsRatingByIdObject.data![index].usersData![0].lastName} ",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          )),

                      Row(
                        children: [
                          showRatingStars(double.parse("${getCarsRatingByIdObject.data![index].rateStars}")),

                          const SizedBox(width: 05,),
                          Text("${getCarsRatingByIdObject.data![index].rateStars}",
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
                    "${getCarsRatingByIdObject.data![index].comments}",
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
