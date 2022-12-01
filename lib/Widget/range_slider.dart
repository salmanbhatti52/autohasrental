import 'package:flutter/material.dart';

import 'colors.dart';

class CustomRangeSlider extends StatefulWidget {
  const CustomRangeSlider({super.key});

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  RangeValues values = const RangeValues(1000, 1500);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        valueIndicatorColor: Colors.white,
        valueIndicatorTextStyle:
            const TextStyle(fontSize: 12, color: Colors.black),
        trackHeight: 4,
        rangeThumbShape:
            const RoundRangeSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        overlayColor: borderColor.withOpacity(0.3),
        thumbColor: borderColor,
        activeTrackColor: borderColor,
        inactiveTrackColor: const Color(0xffd4dce1),
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
      ),
      child: RangeSlider(
        values: values,
        min: 500,
        max: 2000,
        divisions: 20,
        labels: RangeLabels(
          'RM ${values.start.round().toString()}',
          'RM ${values.end.round().toString()}',
        ),
        onChanged: (values) {
          setState(() {
            this.values = values;
          });
        },
      ),
    );
  }
}

class CustomRangeSlider2 extends StatefulWidget {
  const CustomRangeSlider2({super.key});

  @override
  State<CustomRangeSlider2> createState() => _CustomRangeSlider2State();
}

class _CustomRangeSlider2State extends State<CustomRangeSlider2> {
  RangeValues values2 = const RangeValues(400, 800);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        valueIndicatorColor: Colors.white,
        valueIndicatorTextStyle:
            const TextStyle(fontSize: 12, color: Colors.black),
        trackHeight: 4,
        rangeThumbShape:
            const RoundRangeSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        overlayColor: borderColor.withOpacity(0.3),
        thumbColor: borderColor,
        activeTrackColor: borderColor,
        inactiveTrackColor: const Color(0xffd4dce1),
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
      ),
      child: RangeSlider(
        values: values2,
        min: 100,
        max: 1100,
        divisions: 20,
        labels: RangeLabels(
          'KM ${values2.start.round().toString()}',
          'KM ${values2.end.round().toString()}',
        ),
        onChanged: (values) {
          setState(() {
            values2 = values;
          });
        },
      ),
    );
  }
}
