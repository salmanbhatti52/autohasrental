import 'package:flutter/material.dart';

import '../button.dart';
import 'rating_image_widget.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
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
