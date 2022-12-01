import 'package:flutter/material.dart';

import '../../button.dart';
import 'rating_image_widget.dart';

class RatingBookingsDetails extends StatefulWidget {
  const RatingBookingsDetails({super.key});

  @override
  State<RatingBookingsDetails> createState() => _RatingBookingsDetailsState();
}

class _RatingBookingsDetailsState extends State<RatingBookingsDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        allRatingList(),
        const SizedBox(height: 30),
        loginButton('Book Me', context)
      ],
    );
  }
}
