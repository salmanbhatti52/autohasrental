// import 'package:flutter/material.dart';
//
// import '../Utils/colors.dart';
//
// class CustomRangeSlider extends StatefulWidget {
//   CustomRangeSlider({super.key});
//
//   @override
//   State<CustomRangeSlider> createState() => _CustomRangeSliderState();
// }
//
// class _CustomRangeSliderState extends State<CustomRangeSlider> {
//   RangeValues values = RangeValues(1000, 1500);
//
//   @override
//   Widget build(BuildContext context) {
//     return SliderTheme(
//       data: SliderThemeData(
//         valueIndicatorColor: Colors.white,
//         valueIndicatorTextStyle:
//             TextStyle(fontSize: 12, color: Colors.black),
//         trackHeight: 4,
//         rangeThumbShape:
//             RoundRangeSliderThumbShape(enabledThumbRadius: 8),
//         overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
//         overlayColor: borderColor.withOpacity(0.3),
//         thumbColor: borderColor,
//         activeTrackColor: borderColor,
//         inactiveTrackColor: Color(0xffd4dce1),
//         activeTickMarkColor: Colors.transparent,
//         inactiveTickMarkColor: Colors.transparent,
//       ),
//       child: RangeSlider(
//         values: values,
//         min: 500,
//         max: 2000,
//         divisions: 20,
//         labels: RangeLabels(
//           'RM ${values.start.round().toString()}',
//           'RM ${values.end.round().toString()}',
//         ),
//         onChanged: (value) {
//           setState(() {
//             this.values = value;
//             print("rangeValue $values");
//           });
//         },
//       ),
//     );
//   }
// }
//
// class CustomRangeSlider2 extends StatefulWidget {
//   CustomRangeSlider2({super.key});
//
//   @override
//   State<CustomRangeSlider2> createState() => _CustomRangeSlider2State();
// }
//
// class _CustomRangeSlider2State extends State<CustomRangeSlider2> {
//   RangeValues values2 = RangeValues(400, 800);
//
//   @override
//   Widget build(BuildContext context) {
//     return SliderTheme(
//       data: SliderThemeData(
//         valueIndicatorColor: Colors.white,
//         valueIndicatorTextStyle:
//             TextStyle(fontSize: 12, color: Colors.black),
//         trackHeight: 4,
//         rangeThumbShape:
//             RoundRangeSliderThumbShape(enabledThumbRadius: 8),
//         overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
//         overlayColor: borderColor.withOpacity(0.3),
//         thumbColor: borderColor,
//         activeTrackColor: borderColor,
//         inactiveTrackColor: Color(0xffd4dce1),
//         activeTickMarkColor: Colors.transparent,
//         inactiveTickMarkColor: Colors.transparent,
//       ),
//       child: RangeSlider(
//         values: values2,
//         min: 100,
//         max: 1100,
//         divisions: 20,
//         labels: RangeLabels(
//           'KM ${values2.start.round().toString()}',
//           'KM ${values2.end.round().toString()}',
//         ),
//         onChanged: (values) {
//           setState(() {
//             values2 = values;
//           });
//         },
//       ),
//     );
//   }
// }
