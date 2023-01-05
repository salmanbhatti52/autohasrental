import 'package:flutter/material.dart';

import '../../../../../../../Utils/colors.dart';
import '../../../../../../../Utils/fontFamily.dart';

// Widget allRatingList() {
//   return ListView.builder(
//     physics: const BouncingScrollPhysics(),
//       shrinkWrap: true,
//       scrollDirection: Axis.vertical,
//       itemCount: ratingItemsList.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
//           child: Container(
//             decoration: BoxDecoration(
//               color: kWhite,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: ListTile(
//               leading: ClipRRect(
//                 borderRadius: BorderRadius.circular(18),
//                 child: Image.asset(
//                   ratingItemsList[index].image,
//                   height: 60,
//                   width: 60,
//                 ),
//               ),
//               title: Padding(
//                 padding: const EdgeInsets.only(top: 5, bottom: 2),
//                 child: Text(ratingItemsList[index].name,
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontFamily: poppinMedium,
//                     )),
//               ),
//               subtitle: Padding(
//                 padding: const EdgeInsets.only(bottom: 5),
//                 child: Text(
//                   ratingItemsList[index].description,
//                   style: TextStyle(
//                     fontSize: 10,
//                     fontFamily: poppinRegular,
//                   ),
//                 ),
//               ),
//               trailing: Image.asset(
//                 ratingItemsList[index].image2,
//                 width: 75,
//                 height: 12,
//               ),
//             ),
//           ),
//         );
//       });
// }
//
// List ratingItemsList = [
//   RatingClass(
//     "assets/car_description_images/user.png",
//     'Josh Gibson',
//     "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
//     "assets/car_description_images/rating.png",
//   ),
//   RatingClass(
//     "assets/car_description_images/user.png",
//     'Josh Gibson',
//     "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
//     "assets/car_description_images/rating.png",
//   ),
//   RatingClass(
//     "assets/car_description_images/user.png",
//     'Josh Gibson',
//     "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
//     "assets/car_description_images/rating.png",
//   ),
//   RatingClass(
//     "assets/car_description_images/user.png",
//     'Josh Gibson',
//     "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
//     "assets/car_description_images/rating.png",
//   ),
//   RatingClass(
//     "assets/car_description_images/user.png",
//     'Josh Gibson',
//     "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
//     "assets/car_description_images/rating.png",
//   ),
//   RatingClass("assets/car_description_images/user.png",
//     'Josh Gibson',
//     "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod",
//     "assets/car_description_images/rating.png",
//   ),
// ];
//
// class RatingClass {
//   final String image;
//   final String name;
//   final String description;
//   final String image2;
//
//   RatingClass(
//       this.image,
//       this.name,
//       this.description,
//       this.image2,
//       );
// }
