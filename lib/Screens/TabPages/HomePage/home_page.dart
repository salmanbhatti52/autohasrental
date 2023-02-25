import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/SettingsModel/ProfileModels/get_user_profile_model.dart';
import 'Drawer/Settings/EditProfile/edit_profile_screen.dart';
import 'TopRented/home_card_top_rented.dart';
import 'HomePageTopCard/home_top_card.dart';
import 'Drawer/drawer_screen.dart';
import 'Filter/filter_screen.dart';
import 'Notifications/notification_screen.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GetUserProfileModel getUserProfileModelObject = GetUserProfileModel();
  bool loadingP = true;
  getUserProfileWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in HomePagePrefs is= $userId");
    loadingP = true;
    setState(() {});
    try {
      String apiUrl = getUserProfileApiUrl;
      print("getUserProfileApi: $apiUrl");
      print("getUserId: $userId");
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
        print("getUserProfileResponseHomePage: ${responseString.toString()}");
        getUserProfileModelObject = getUserProfileModelFromJson(responseString);
        print("getUserProfileImageHomePage: $baseUrlImage${getUserProfileModelObject.data!.profilePic}");
      }
    } catch (e) {
      print('Error in getUserProfileHomePage: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // sharedPrefs();
    getUserProfileWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: homeBgColor,
      body: loadingP? Center(child: CircularProgressIndicator(color: borderColor)):
      SingleChildScrollView(
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
                      child: Image.asset("assets/home_page/Side_Menu.png", height: 25, width: 25)),
                  Text("Home",
                    style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kBlack)),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
                        },
                        child: Image.asset("assets/home_page/notification_image.png"),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      GestureDetector(
                        onTap: (){
                          Get.to(() => const EditProfileScreen());
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: "$baseUrlImage${getUserProfileModelObject.data?.profilePic}",
                            height: 30, width: 30,
                            fit: BoxFit.fill,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(strokeWidth: 2, value: downloadProgress.progress, color: borderColor,),
                            errorWidget: (context, url, error) => Image.asset("assets/icon/fade_in_image.jpeg"),
                                // Icon(Icons.error),
                          ),
                        ),
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
                          hintStyle: TextStyle(color: const Color(0xffD4DCE1),
                              fontSize: 14, fontFamily: poppinLight),
                          focusColor: borderColor,
                          suffixIcon: const Icon(Icons.search_outlined, color: Color(0xffD4DCE1)),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myHorizontalCard(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Top Rented",
                      style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kBlack),),
                  ),
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
