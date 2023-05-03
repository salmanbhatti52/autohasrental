// import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../Utils/colors.dart';
//
// class ChooseSubscriptionPlan extends StatefulWidget {
//   ChooseSubscriptionPlan({Key? key}) : super(key: key);
//
//   @override
//   State<ChooseSubscriptionPlan> createState() => _ChooseSubscriptionPlanState();
// }
//
// class _ChooseSubscriptionPlanState extends State<ChooseSubscriptionPlan> {
//   List<SubscriptionRadioModel> sampleData = <SubscriptionRadioModel>[];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     sampleData.add(SubscriptionRadioModel(false, '12 Months'));
//     sampleData.add(SubscriptionRadioModel(false, '24 Months'));
//     sampleData.add(SubscriptionRadioModel(false, '36 Months'));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       height: 50,
//       child: ListView.builder(
//         itemCount: sampleData.length,
//         scrollDirection: Axis.horizontal,
//         physics: NeverScrollableScrollPhysics(),
//         itemBuilder: (BuildContext context, int index) {
//           return InkWell(
//             onTap: () {
//               setState(
//                 () {
//                   sampleData.forEach((element) => element.isSelected = false);
//                   sampleData[index].isSelected = true;
//                 },
//               );
//             },
//             child: SubscriptionRadioItem(sampleData[index]),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class SubscriptionRadioItem extends StatelessWidget {
//   final SubscriptionRadioModel _item;
//   SubscriptionRadioItem(this._item, {super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(5.0),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Container(
//             height: 30.0,
//             width: 97.0,
//             decoration: BoxDecoration(
//               color: _item.isSelected ? borderColor : kWhite,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Center(
//               child: Text(_item.buttonText,
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                       fontFamily: poppinRegular,
//                       fontSize: 12.0,
//                       color: _item.isSelected ? kWhite : textLabelColor)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class SubscriptionRadioModel {
//   bool isSelected;
//   final String buttonText;
//
//   SubscriptionRadioModel(
//     this.isSelected,
//     this.buttonText,
//   );
// }
