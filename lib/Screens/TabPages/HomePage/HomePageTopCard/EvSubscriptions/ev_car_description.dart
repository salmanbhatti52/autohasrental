import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../Utils/fontFamily.dart';
import '../../../../../Widget/button.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Widget/month_slot.dart';
import '../../../MessagePage/message_details_screen.dart';
import 'ev_description_details_page.dart';
import 'EvTaBBar/tabbar_description_page.dart';

class EVCarDescription extends StatefulWidget {
  final String? carName, carImage, carRating, carDescription, ownerImage, ownerName, ownerId;
  final int? carYear;

  const EVCarDescription({super.key, this.carName, this.ownerImage, this.ownerName,
    this.ownerId, this.carYear, this.carImage, this.carRating, this.carDescription});

  @override
  State<EVCarDescription> createState() => _EVCarDescriptionState();
}

class _EVCarDescriptionState extends State<EVCarDescription> {

  mySelectedData(){
    print("myCarRating ${widget.carRating}");
    print("myCarOwnerName ${widget.ownerName}");
    print("myCarOwnerImage ${widget.ownerImage}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySelectedData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
          Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness:
          Brightness.dark, //<-- For iOS SEE HERE (dark icons)
        ),
        actions: [
          GestureDetector(
            onTap: () {
              print("clicked");
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MessageDetailsScreen(
                    senderName: widget.ownerName,
                    senderImage: widget.ownerImage,
                  )));
              },
            child: Padding(
              padding: const EdgeInsets.only(top: 30, right: 20),
              child: Image.asset("assets/car_description_images/chat.png",
                height: 25, width: 25,
              ),
            ),
          ),
        ],
        backgroundColor: appBgColor, elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            print("clicked");
            Navigator.pop(context);
            },
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Image.asset("assets/live_chat_images/back_arrow.png",
              color: kWhite, height: 25, width: 25,
            ),
          ),
        ),
          title: Padding(
            padding: const EdgeInsets.only(top: 30, right: 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("${widget.carName}, ", style: TextStyle(fontSize: 16, fontFamily: poppinBold, color: kWhite),),
                    Text("${widget.carYear}", style: TextStyle(fontSize: 16, fontFamily: poppinRegular, color: kWhite),),
                  ]),
              ]),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.37,
              decoration: const BoxDecoration(
                color: Color(0xff0f172a),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/home_page/9004787_star_favorite_award_like_icon.png',),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),

                      // widget.carRating == null?
                      Text('0.0', style: TextStyle(fontSize: 16,
                          color: kWhite, fontFamily: poppinSemiBold)),
                          // : Text('${widget.carRating}', style: TextStyle(fontSize: 16,
                          // color: kWhite, fontFamily: poppinSemiBold)),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Image.asset('assets/car_description_images/tesla.png', width: 41, height: 41),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Image.asset('assets/car_description_images/heart.png',
                            width: 24, height: 20),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Positioned(
                        child: Image.network("${widget.carImage}", height: 190, width: 310),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Image.asset('assets/car_description_images/circle.png'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.092,
                child: const MonthSlotContainer(),
              ),
            ),
            const TabbarCarDescription(),
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                          builder: (context) => EvDescriptionDetailsPage(
                            carName: widget.carName,
                            carYear: widget.carYear,
                          )));
                },
                child: loginButton('Book Now', context)),
          ],
        ),
      ),
    );
  }
}
