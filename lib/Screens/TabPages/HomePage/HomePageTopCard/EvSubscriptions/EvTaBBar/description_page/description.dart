import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.It has",
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins-Regular',
                color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Text(
            "Owner’s Details",
            style: TextStyle(
                fontSize: 14, fontFamily: 'Poppins-Bold', color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 6),
          child: Text(
            "About",
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins-SemiBold',
                color: Color(0xffa87b5d)),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 6),
          child: Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins-Regular',
                color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 6),
          child: Text(
            "Location",
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins-SemiBold',
                color: Color(0xffa87b5d)),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 6),
          child: Text(
            "Los Angeles, CA 90015",
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins-Regular',
                color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
