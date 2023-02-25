import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../../Model/BookingModels/Previous/booking_previous_model.dart';
import '../../../../../../../Utils/colors.dart';
import 'package:http/http.dart'as http;

class DescriptionBookingsDetails extends StatefulWidget {
  final String? carDescription, carMonth;
  const DescriptionBookingsDetails({super.key, this.carDescription, this.carMonth});

  @override
  State<DescriptionBookingsDetails> createState() => _DescriptionBookingsDetailsState();
}

class _DescriptionBookingsDetailsState extends State<DescriptionBookingsDetails> {

  PreviousBookingModel previousBookingModelObject = PreviousBookingModel();
  bool loadingP = true;

  getPreviousBookingCarWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print('in previousBookingCarApi');

    // try {
    String apiUrl = bookingPreviousCarsApiUrl;
    print("upcomingBookingCarModelApi: $apiUrl");
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      "users_customers_id": userId
    });
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("responsePreviousBookingCar: ${responseString.toString()}");
      loadingP = false;
      setState(() {});
      previousBookingModelObject = previousBookingModelFromJson(responseString);
      print("previousBookingLength: ${previousBookingModelObject.data?.length}");
    }
    // } catch (e) {
    //   print('Error in upcomingBookingCar: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreviousBookingCarWidget();
  }
  @override
  Widget build(BuildContext context) {
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor)):
      Column(
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
              Text('${widget.carMonth} Month ',
                style: TextStyle(
                    fontSize: 15,
                    color: borderColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Text(
            // "${widget.datumPrevious!.carsDetails!.description}",
            "${widget.carDescription}",
            style: const TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
        // const Padding(
        //   padding: EdgeInsets.only(left: 20, top: 10),
        //   child: Text(
        //     "Owner’s Details",
        //     style: TextStyle(
        //         fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        //     textAlign: TextAlign.left,
        //   ),
        // ),
        // const Padding(
        //   padding: EdgeInsets.only(left: 20, top: 6),
        //   child: Text(
        //     "About",
        //     style: TextStyle(
        //         fontSize: 12,
        //         fontWeight: FontWeight.w700,
        //         color: Color(0xffa87b5d)),
        //     textAlign: TextAlign.left,
        //   ),
        // ),
        // const Padding(
        //   padding: EdgeInsets.only(left: 20, top: 6),
        //   child: Text(
        //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
        //     style: TextStyle(fontSize: 12, color: Colors.black),
        //     textAlign: TextAlign.left,
        //   ),
        // ),
        // const Padding(
        //   padding: EdgeInsets.only(left: 20, top: 6),
        //   child: Text(
        //     "Location",
        //     style: TextStyle(
        //         fontSize: 12,
        //         fontWeight: FontWeight.w700,
        //         color: Color(0xffa87b5d)),
        //     textAlign: TextAlign.left,
        //   ),
        // ),
        // const Padding(
        //   padding: EdgeInsets.only(left: 20, top: 6),
        //   child: Text(
        //     "Los Angeles, CA 90015",
        //     style: TextStyle(fontSize: 12, color: Colors.black),
        //     textAlign: TextAlign.left,
        //   ),
        // ),
      ],
    );
  }
}
