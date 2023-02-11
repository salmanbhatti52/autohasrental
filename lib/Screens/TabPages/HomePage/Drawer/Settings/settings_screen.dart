import 'dart:core';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Model/SettingsModel/delete_account_model.dart';
import '../../../../../Utils/api_urls.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/constants.dart';
import '../../../../../Widget/toast_message.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';
import 'ChangePassword/change_password_screen.dart';
import 'EditProfile/edit_profile_screen.dart';
import 'Payment/payment_screen.dart';
import 'package:http/http.dart' as http;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool loading = true;

  sharedPrefs() async {
    loading = true;
    setState(() {});
    print('in settings sharedPrefs');
    prefs = await SharedPreferences.getInstance();
    userEmail = (prefs!.getString('user_email'));
    print("userEmail in sharedPrefs $userEmail");
  }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarSettingsPage(
        backImage: "assets/home_page/Side_Menu.png",
        title: "Settings",
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight*0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 05),
            child: Container(
              height: screenHeight*0.08,
              decoration: BoxDecoration(
                  color: kWhite, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Notifications",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14,
                              fontFamily: poppinBold, color: kBlack)),
                        Text("Enable your notifications",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 10,
                              fontFamily: poppinRegular, color: kBlack),),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlutterSwitch(
                          height: 25,
                          width: 40,
                          padding: 2,
                          toggleSize: 20,
                          activeColor: borderColor,
                          inactiveToggleColor: kWhite,
                          value: isSwitched,
                          onToggle: (value) {
                            setState(() {
                              isSwitched = value;
                              // userDetail.covidVaccine=covid?"True":"False";
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => const PaymentScreen()));
              },
              child: settingWidget("Payment Details", kBlack,
                  "Add your cards for quick payments",
                  Icons.arrow_forward_ios_rounded, kBlack)),
          GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen()));
              },
              child: settingWidget("Change Password", kBlack,
                  "Update your password", Icons.arrow_forward_ios_rounded, kBlack)),
          GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()));
              },
              child: settingWidget("Profile", kBlack, "Update your profile",
                  Icons.arrow_forward_ios_rounded, const Color(0xffD4DCE1))),
          GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color: const Color(0xffb0b0b0),
                        child: Container(
                          color: const Color(0xff0f172a).withOpacity(0.5),
                          child: Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)), //this right here
                            child: Container(
                              decoration: BoxDecoration(
                                  color: homeBgColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(context, MaterialPageRoute(
                                                    builder: (context) => const SettingsScreen()));
                                          },
                                          child: Image.asset("assets/payment_card_images/cancle.png",),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                                    Text("Delete Account", textAlign: TextAlign.center,
                                      style: TextStyle(color: kRed,
                                        fontSize: 24, fontFamily: poppinSemiBold)),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Text("Are you sure you want to delete your account?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: kBlack,
                                        fontSize: 20, fontFamily: poppinMedium)),
                                    GestureDetector(
                                        onTap: () async {
                                          await deleteAccountWidget();
                                          if (deleteAccountModel.status == "success") {
                                            Fluttertoast.showToast(
                                                msg: "${deleteAccountModel.message}",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: colorGreen,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            Navigator.pop(context);
                                          }
                                          if (deleteAccountModel.status != "success") {
                                            toastFailedMessage(deleteAccountModel.message, kRed);
                                          }
                                        },
                                        child: yesButton()),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: noButton()),
                                    SizedBox(height: screenHeight * 0.03),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: settingWidget("Delete Account", introColor, "Delete your account",
                  Icons.arrow_forward_ios_rounded, const Color(0xffD4DCE1))),
        ],
      ),
    );
  }

  DeleteAccountModel deleteAccountModel = DeleteAccountModel();
  deleteAccountWidget() async {
    try {
      String apiUrl = deleteAccountApiUrl;
      print("api: $apiUrl");
      print("deleteEmail: $userEmail");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Accept': 'application/json'},
        body: {
          'user_email': userEmail,
          'delete_reason': "test delete",
          'comments': "Hello",
        },
      );
      final responseString = response.body;
      print("deleteAccountModelResponse: $responseString");

      print("status Code deleteAccountModel: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("in 200 signUp");
        // print("resS $responseString");
        // if (responseString != 'false') {
          deleteAccountModel = deleteAccountModelFromJson(responseString);
          setState(() {});
          print('deleteAccountModel status: ${deleteAccountModel.status}');
        // }
      }
    } catch (e) {
      print('deleteAccountModel error in catch = ${e.toString()}');
      return null;
    }
  }

  bool isSwitched = false;
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  Widget settingWidget(
      titleText, textColor, subTitleText, iconData, iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 05),
      child: Container(
        decoration: BoxDecoration(
            color: kWhite, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(titleText, textAlign: TextAlign.left, style: TextStyle(
                fontSize: 14, fontFamily: poppinBold, color: textColor)),
          subtitle: Text(subTitleText, textAlign: TextAlign.left, style: TextStyle(
                fontSize: 10, fontFamily: poppinRegular, color: kBlack),
          ),
          trailing: Icon(iconData, color: iconColor, size: 20),
        ),
      ),
    );
  }

  Widget yesButton() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      child: Container(
        height: screenHeight * 0.05,
        width: screenWidth * 0.6,
        decoration: BoxDecoration(
          color: introColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text("Yes", textAlign: TextAlign.center, style: TextStyle(
              color: kWhite, fontFamily: poppinRegular, fontSize: 16)),
        ),
      ),
    );
  }

  Widget noButton() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Container(
        height: screenHeight * 0.05,
        width: screenWidth,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 2)),
        child: Center(
          child: Text("No", textAlign: TextAlign.center, style: TextStyle(
              color: borderColor, fontFamily: poppinRegular, fontSize: 16)),
        ),
      ),
    );
  }
}
