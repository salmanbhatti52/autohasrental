// import 'package:auto_haus_rental_app/Widget/fontFamily.dart';
// import 'package:flutter/material.dart';
// import '../../../../Widget/colors.dart';
// import '../../tab_page.dart';
// import 'Settings/AboutUs/about_us.dart';
// import 'Settings/LiveChat/live_chat_page_1.dart';
// import 'Settings/settings_screen.dart';
//
// class DrawerScreen extends StatefulWidget {
//   const DrawerScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DrawerScreen> createState() => _DrawerScreenState();
// }
//
// class _DrawerScreenState extends State<DrawerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appBgColor,
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         color: appBgColor,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//               child: GestureDetector(
//                 onTap: (){
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   height: 50, width: 50,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.circular(50)
//                   ),
//                   child: Image.asset("assets/drawer_images/cancle.png",),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 40),
//               child: Row(
//                 children: [
//                   Column(children: [
//                     Image.asset("assets/home_page/user.png", height: 70, width: 70,),
//                   ],
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                     Text("Daniel Jefferson", textAlign: TextAlign.left, style: TextStyle(
//                       color: kWhite, fontSize: 20, fontFamily: poppinRegular,),),
//                     Row(
//                       children: [
//                         Image.asset("assets/drawer_images/location.png", color: borderColor,),
//                         Text("Dubai, UAE", textAlign: TextAlign.center,
//                           style: TextStyle(color: const Color(0xffB1A8B9),
//                             fontSize: 15, fontFamily: poppinRegular, ),),
//                       ],
//                     ),
//                   ],
//                   ),
//                 ],
//               ),
//               // ListTile(
//               //   leading:
//               //   Image.asset("assets/home_page/user.png", height: 80, width: 80,),
//               //   title: Text("Daniel Jefferson", textAlign: TextAlign.left, style: TextStyle(
//               //     color: kWhite, fontSize: 20, fontFamily: poppinRegular,),),
//               //
//               //   subtitle: Padding(
//               //     padding: const EdgeInsets.symmetric(vertical: 05),
//               //     child: Row(
//               //       children: [
//               //         Image.asset("assets/drawer_images/location.png", color: borderColor,),
//               //         Text("Dubai, UAE", textAlign: TextAlign.center,
//               //           style: TextStyle(color: const Color(0xffB1A8B9),
//               //           fontSize: 15, fontFamily: poppinRegular, ),),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//             ),
//
//             SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
//             GestureDetector(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
//                 // Get.to(const SettingsScreen());
//               },
//                 child: myListTile("assets/drawer_images/settings_icon.png", "Setting")),
//             GestureDetector(
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=> const LiveChatPage1()));
//                 },
//                 child: myListTile("assets/drawer_images/call_phone_icon.png", "Live Chat")),
//             GestureDetector(
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=> const AboutUsPage()));
//                 },
//                 child: myListTile("assets/drawer_images/customer_help_icon.png", "About Us")),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.25),
//             GestureDetector(
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=> const TabBarPage()));
//                 },
//                 child: myListTile("assets/drawer_images/logout_icon.png", "Logout")),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget myListTile(myImage, myTitle){
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30,),
//       child: ListTile(
//         leading: Image.asset(myImage),
//         title: Text(myTitle, textAlign: TextAlign.left, style: TextStyle(
//             color: kWhite, fontSize: 14, fontFamily: poppinRegular),),
//       ),
//     );
//
//   }
// }

import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/Drawer/Settings/AboutUs/about_us.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/Drawer/Settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Widget/colors.dart';
import 'Settings/LiveChat/live_chat_page_1.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: appBgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50)),
                  child: Image.asset(
                    "assets/drawer_images/cancle.png",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: Image.asset(
                  "assets/home_page/user.png",
                  height: 80,
                  width: 80,
                ),
                title: Text(
                  "Daniel Jefferson",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 20,
                    fontFamily: 'Poppins-Regular',
                  ),
                  textAlign: TextAlign.left,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 05),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/drawer_images/location.png",
                        color: borderColor,
                      ),
                      const Text(
                        "Dubai, UAE",
                        style: TextStyle(
                          color: Color(0xffB1A8B9),
                          fontSize: 15,
                          fontFamily: 'Poppins-Regular',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            GestureDetector(
                onTap: () {
                  Get.to(const SettingsScreen());
                },
                child: myListTile(
                    "assets/drawer_images/settings_icon.png", "Setting")),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LiveChatPage1()));
                },
                child: myListTile(
                    "assets/drawer_images/call_phone_icon.png", "Live Chat")),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUsPage()));
                },
                child: myListTile(
                    "assets/drawer_images/customer_help_icon.png", "About Us")),
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            myListTile("assets/drawer_images/logout_icon.png", "Logout"),
          ],
        ),
      ),
    );
  }

  Widget myListTile(myImage, myTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: ListTile(
        leading: Image.asset(myImage),
        title: Text(
          myTitle,
          style: TextStyle(
            color: kWhite,
            fontSize: 14,
            fontFamily: 'Poppins-Regular',
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
