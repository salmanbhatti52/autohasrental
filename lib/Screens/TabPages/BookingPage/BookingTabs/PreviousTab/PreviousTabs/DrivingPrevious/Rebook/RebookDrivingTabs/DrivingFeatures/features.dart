// import 'package:auto_haus_rental_app/Utils/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'feature_image_widget.dart';
//
// class DrivingFeaturesDetails extends StatelessWidget {
//   const DrivingFeaturesDetails({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Column(
//         children: [
//           SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//           featuretext("\u2022", "Drive this car up to 1,250 KM/month", context),
//           featuretext("\u2022", "Comprehensive insurance", context),
//           featuretext("\u2022", "Road tax", context),
//           featuretext("\u2022", "Regularly scheduled maintenance", context),
//           featuretext("\u2022", "Concierge service", context),
//           featuretext("\u2022", "24/7 nationwide roadside assistance", context),
//           featuretext("\u2022", "Ability to swap a car", context),
//           featuretext("\u2022", "Anti-theft system", context),
//           featuretext("\u2022", "Independently rated car inspection", context),
//           const SizedBox(height: 10),
//           myHorizontalCard3(context),
//         ],
//       ),
//     );
//   }
//
//   Widget featuretext(text1, text2, context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           Text(
//             text1,
//             style: const TextStyle(fontSize: 30, height: 0.8),
//           ), //bullet text
//           const SizedBox(width: 10), //space between bullet and text
//           Expanded(
//             child: Text(
//               text2,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: kBlack,
//                 height: 0.8,
//               ),
//             ), //text
//           ),
//         ],
//       ),
//     );
//   }
// }
