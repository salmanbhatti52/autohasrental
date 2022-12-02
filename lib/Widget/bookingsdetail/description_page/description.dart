import 'package:flutter/material.dart';
import '../../button.dart';
import '../../colors.dart';

class DescriptionBookingsDetails extends StatelessWidget {
  const DescriptionBookingsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Padding(
          padding:
          const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Booked for',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                '12 Months',
                style: TextStyle(
                    fontSize: 15,
                    color: borderColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.It has",
            style: TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Text(
            "Owner’s Details",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 6),
          child: Text(
            "About",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xffa87b5d)),
            textAlign: TextAlign.left,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 6),
          child: Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
            style: TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 6),
          child: Text(
            "Location",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xffa87b5d)),
            textAlign: TextAlign.left,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 6),
          child: Text(
            "Los Angeles, CA 90015",
            style: TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        GestureDetector(
            onTap: () {
              ratingsdialogbox(context);
            },
            child: loginButton('Give Ratings', context)),
      ],
    );
  }

  void ratingsdialogbox(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xffb0b0b0),
            child: Container(
              color: const Color(0xff0f172a).withOpacity(0.5),
              child: AlertDialog(
                backgroundColor: homeBgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child:
                        Image.asset('assets/car_bookings_images/close.png'),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      "Ratings",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: borderColor),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    const Text(
                      "Give your Ratings \n   and Feedback",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffb0b0b0),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Image.asset(
                      "assets/car_bookings_images/rating.png",
                      height: 30,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Add your feedback",
                        hintStyle: const TextStyle(
                            fontSize: 16, color: Color(0xffb0b0b0)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: Color(0xffd4dce1)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 90),
                      child: Text(
                        "*Maximum 150 characters",
                        style: TextStyle(
                          fontSize: 12,
                          color: borderColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Container(
                            height: 44,
                            width: 202,
                            decoration: BoxDecoration(
                                color: borderColor,
                                borderRadius: BorderRadius.circular(30)),
                            child: const Center(
                              child: Text('Okay',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 16)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
