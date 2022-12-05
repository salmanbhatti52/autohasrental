import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Widget/colors.dart';
import '../../../Widget/home_card.dart';
import 'Drawer/Settings/EditProfile/edit_profile_screen.dart';
import 'HomePageTopCard/home_top_card.dart';
import 'Drawer/drawer_screen.dart';
import 'Filter/filter_screen.dart';
import 'Notifications/notification_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: homeBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      print("clicked");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const DrawerScreen()));
                    },
                      child: Image.asset(
                        "assets/home_page/Side_Menu.png", height: 25, width: 25,),),

                  Text("Home",
                    style: TextStyle(fontSize: 20, fontFamily: "Poppins-Bold", color: kBlack),),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
                        },
                        child: Image.asset("assets/home_page/notification_image.png"),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                      GestureDetector(
                        onTap: (){
                          Get.to(() => const EditProfileScreen());
                        },
                        child: Image.asset(
                          "assets/home_page/user.png", height: 30, width: 30,),
                      ),

                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                          const EdgeInsets.fromLTRB(20, 12, 10, 0),
                          hintText: 'Search for Cars',
                          hintStyle: const TextStyle(
                              color: Color(0xffD4DCE1),
                              fontSize: 14,
                              fontFamily: 'Poppins-Light'),
                          focusColor: borderColor,
                          suffixIcon: const Icon(
                            Icons.search_outlined,
                            color: Color(0xffD4DCE1),
                          ),
                        ),
                        style: TextStyle(color: borderColor, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FilterScreen()));
                    },
                    child: Container(
                      height: 50, width: 50,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Image.asset("assets/home_page/filter.png")),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 05, vertical: 0),
              child: Column(
                children: [
                  myHorizontalCard(context),
                  const HomeCardTopRented(),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
