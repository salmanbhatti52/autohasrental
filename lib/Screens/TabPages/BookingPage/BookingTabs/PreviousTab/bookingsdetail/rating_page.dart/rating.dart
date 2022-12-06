import 'package:flutter/material.dart';
import 'rating_image_widget.dart';

class RatingBookingsDetails extends StatefulWidget {
  const RatingBookingsDetails({super.key});

  @override
  State<RatingBookingsDetails> createState() => _RatingBookingsDetailsState();
}

class _RatingBookingsDetailsState extends State<RatingBookingsDetails> {
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
}
