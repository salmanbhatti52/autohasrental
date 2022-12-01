import 'package:flutter/material.dart';
import '../../../../../Widget/colors.dart';
import 'Tabs/driving_tabbar.dart';

class DrivingDetailsPage extends StatefulWidget {
  const DrivingDetailsPage({Key? key}) : super(key: key);

  @override
  State<DrivingDetailsPage> createState() => _DrivingDetailsPageState();
}

class _DrivingDetailsPageState extends State<DrivingDetailsPage> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                Container(
                  height: 800,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
                   Positioned(
                     bottom: 0,
                       right: 0,
                       left: 0,
                       child: Image.asset("assets/images/SVG 03.png",
                         width: MediaQuery.of(context).size.width* 0.9,
                         height: MediaQuery.of(context).size.height*0.5,)),
                  Positioned(
                    bottom: 375,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Driving Experiences",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kWhite),),
                         SizedBox(width: MediaQuery.of(context).size.width *0.3,),
                          Text("250",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kWhite),),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                      right: 20,
                      left: 20, bottom: 230,
                      child: Image.asset("assets/images/crown_image.png")),

                  Positioned(
                    right: 40,
                    left: 40, bottom: 130,
                    child: Text('Track Day Session \nGet driven around by \n"Alex Yoong" at \nSepang Circuit for \nRMx,xxx',
                      maxLines: 5, textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kWhite),),
                  ),

                  Positioned(
                      right: 20,
                      left: 20, bottom: 10,
                      child: Image.asset("assets/images/crown_images_two.png")),
                  Positioned(
                    top: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width*1,
                      decoration: BoxDecoration(
                          color: appBgColor,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)
                          )
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.arrow_back_ios_new_outlined, color: kWhite,),),

                                Text("Tesla S series, 2022",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kWhite),),

                                GestureDetector(
                                    onTap: (){
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
                                    },
                                    child:
                                    Image.asset("assets/images/chat.png"
                                      // Image.asset("assets/images/heart_transparent.png"
                                      // Image.asset("assets/images/tesla.png"
                                    )),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/home_page/rating_stars.png"),
                              SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
                              Text("4.0", style: TextStyle(color: kWhite,
                                fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Poppins',),),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Stack(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.3,
                                color: Colors.transparent,
                              ),
                              Positioned(
                                  right: 20, top: 120, left: 20,
                                  child: Image.asset("assets/images/plate_image.png")),
                              Positioned(
                                left: 20,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: borderColor,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: borderColor, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset("assets/filter_images/tesla.png", width: 35, height: 35, color: kWhite,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 20,
                                  child: Image.asset("assets/home_page/heart_transparent.png")),
                              Positioned(
                                  top: 15, left: 50, right: 50,
                                  child: Image.asset("assets/home_page/tesla.png")),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              const DrivingTabBar(),

              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
