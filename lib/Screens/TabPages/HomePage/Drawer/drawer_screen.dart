import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Model/SettingsModel/ProfileModels/get_user_profile_model.dart';
import '../../../../Utils/colors.dart';
import '../../../Authentication/LoginPage/login_page.dart';
import 'Settings/AboutUs/about_us.dart';
import 'Settings/LiveChat/live_chat_page_1.dart';
import 'Settings/settings_screen.dart';
import 'package:http/http.dart'as http;

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  GetUserProfileModel getUserProfileModelObject = GetUserProfileModel();
  bool loadingP = true;
  getUserProfileWidget() async {
    loadingP = true;
    setState(() {});
    try {
      String apiUrl = getUserProfileApiUrl;
      print("getUserProfileApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id" : userId,
          },
          headers: {
            'Accept': 'application/json'
          });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("getUserProfileResponse: ${responseString.toString()}");
        getUserProfileModelObject = getUserProfileModelFromJson(responseString);
        print("getUserName: ${getUserProfileModelObject.data!.lastName}");
        // setData();
        print("getUserProfileImage: $baseUrlImage${getUserProfileModelObject.data!.profilePic}");
      }
    } catch (e) {
      print('Error in getUserProfileWidget: ${e.toString()}');
    }
    loadingP = false;
    setState(() {
      // setData();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfileWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body:
      // loadingP? Center(child: CircularProgressIndicator(color: borderColor)):
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: appBgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50, width: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Image.asset("assets/drawer_images/cancle.png",),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  Column(
                    children: [
                    // CachedNetworkImage(
                    //   imageUrl: "$baseUrlImage${getUserProfileModelObject.data!.profilePic}",
                    //   height: 75,
                    //   width: 75,
                    //   fit: BoxFit.fill,
                    // ),
                    //   getUserProfileModelObject.data!.profilePic == null? ClipRRect(
                    //       borderRadius: BorderRadius.circular(80),
                    //       child: Image.asset('assets/icons/fade_in_image.jpeg')):
                    //   CachedNetworkImage(
                    //     imageUrl: "$baseUrlImage${getUserProfileModelObject.data!.profilePic}",
                    //     height: 75,
                    //     width: 75,
                    //     // placeholder: Image.asset('assets/icon/fade_in_image.jpeg'),
                    //     fit: BoxFit.fill,
                    //   ),

                      Image.asset("assets/home_page/user.png", height: 70, width: 70,),

                      // Image.network(
                      //   '$baseUrlImage${getUserProfileModelObject.data!.profilePic}',
                      //   loadingBuilder: (ctx, i, k) => Container(
                      //       alignment: Alignment.center,
                      //       width: 75,
                      //       height: 75,
                      //       child: const Center(child: CircularProgressIndicator())),
                      //     errorBuilder: (ctx, o, n) {
                      //     print("image error $o");
                      //     // return const Icon(Icons.error);
                      //     return ClipRRect(
                      //         borderRadius: BorderRadius.circular(80),
                      //         child: Image.asset('assets/icon/fade_in_image.jpeg', height: 70, width: 70,));
                      //     }),

                  ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Daniel Jefferson", textAlign: TextAlign.left, style: TextStyle(
                      color: kWhite, fontSize: 20, fontFamily: poppinRegular,),),
                    Row(
                      children: [
                        Image.asset("assets/drawer_images/location.png", color: borderColor,),
                        Text("Dubai, UAE", textAlign: TextAlign.center,
                          style: TextStyle(color: const Color(0xffB1A8B9),
                            fontSize: 15, fontFamily: poppinRegular, ),),
                      ],
                    ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                // Get.to(const SettingsScreen());
              },
                child: myListTile("assets/drawer_images/settings_icon.png", "Setting")),
            GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LiveChatPage1()));
                },
                child: myListTile("assets/drawer_images/call_phone_icon.png", "Live Chat")),
            GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const AboutUsPage()));
                },
                child: myListTile("assets/drawer_images/customer_help_icon.png", "About Us")),
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            GestureDetector(
                onTap: (){
                  showLogoutAlertDialog(context);
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const TabBarPage()));
                },
                child: myListTile("assets/drawer_images/logout_icon.png", "Logout")),

          ],
        ),
      ),
    );
  }
  showLogoutAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: const Text('Cancel'),
    );
    Widget continueButton = TextButton(
      child: const Text('Yes, Continue'),
      onPressed: () {
        removeDataFormSharedPreferences();
        setState(() {});
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      title: const Text("Sign Out"),
      content: const Text("Are you sure you want to Sign Out ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  removeDataFormSharedPreferences() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {});
  }

  Widget myListTile(myImage, myTitle){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,),
      child: ListTile(
        leading: Image.asset(myImage),
        title: Text(myTitle, textAlign: TextAlign.left, style: TextStyle(
            color: kWhite, fontSize: 14, fontFamily: poppinRegular),),
      ),
    );

  }
}
