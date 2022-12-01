import 'package:auto_haus_rental_app/Widget/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import '../../../../../Widget/colors.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';
import 'ChangePassword/change_password_screen.dart';
import 'EditProfile/edit_profile_screen.dart';
import 'Payment/payment_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const myAppBarSettingsPage(backImage: "assets/home_page/Side_Menu.png", title: "Settings", ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       GestureDetector(
          //         onTap:(){
          //           print("clicked");
          //           Navigator.push(context, MaterialPageRoute(builder: (context) => const DrawerScreen()));
          //         },
          //         child: Image.asset(
          //           "assets/home_page/Side_Menu.png", height: 25, width: 25,),),
          //
          //       Text("Settings",
          //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kBlack),),
          //
          //       Container(),
          //     ],
          //   ),
          // ),

          // SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 05),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.075,
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text("Notifications", style: TextStyle(fontSize: 14,
                          fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: kBlack),),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.007,),
                      Text("Enable your notifications", style: TextStyle(fontSize: 10,
                          fontWeight: FontWeight.w400, fontFamily: 'Poppins', color: kBlack),),
                    ],),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      FlutterSwitch(
                        height: 25,
                        width: 45,
                        padding: 1,
                        toggleSize: 24,
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
                    ],),
                  ],
                ),
              ),
            ),
          ),
          
          GestureDetector(
            onTap: (){
              Get.to(()=> const PaymentScreen());
            },
              child: settingWidget("Payment Details", kBlack, "Add your cards for quick payments", Icons.arrow_forward_ios_rounded, kBlack)),
          GestureDetector(
              onTap: (){
                Get.to(()=>const ChangePasswordScreen());
              },
              child: settingWidget("Change Password", kBlack,"Update your password", Icons.arrow_forward_ios_rounded, kBlack)),
          GestureDetector(
              onTap: (){
                Get.to(() => const EditProfileScreen());
              },
              child: settingWidget("Profile", kBlack, "Update your profile", Icons.arrow_forward_ios_rounded, const Color(0xffD4DCE1) )),
          GestureDetector(
              onTap: (){
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
                              // height: 300,
                              // color: homeBgColor,
                              // color: Colors.green,
                              decoration: BoxDecoration(
                                  color: homeBgColor,
                                  borderRadius: BorderRadius.circular(20)
                              ),
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
                                          onTap: (){
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                                          },
                                          child: Image.asset("assets/payment_card_images/cancle.png",),),
                                      ],
                                    ),

                                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                                    Text("Delete Account", textAlign: TextAlign.center, style: TextStyle(color: kRed,
                                      fontSize: 24, fontFamily: poppinSemiBold,),),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Text("Are you sure you want to delete your account?",
                                      textAlign: TextAlign.center, style: TextStyle(color: kBlack,
                                        fontSize: 20, fontFamily: poppinMedium,),),
                                    // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                    GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: yesButton()),
                                    GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: noButton()),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const DeleteAccountPage()));
              },
              child: settingWidget("Delete Account", kRed, "Delete your account",  Icons.arrow_forward_ios_rounded, const Color(0xffD4DCE1))),

        ],
      ),
    );
  }
  bool isSwitched = false;
  void toggleSwitch(bool value) {
    if(isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    }
    else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  Widget settingWidget(titleText, textColor, subTitleText, iconData, iconColor){
    return
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 05),
          child: Container(
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10)
            ),
            child: ListTile(
                title: Text(titleText, textAlign: TextAlign.left, style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: textColor),),
                subtitle: Text(subTitleText, textAlign: TextAlign.left, style: TextStyle(fontSize: 10,
                    fontWeight: FontWeight.w400, fontFamily: 'Poppins', color: kBlack),),
                trailing: Icon(iconData, color: iconColor, size: 20,),
            ),
          ),
      );

  }


  Widget yesButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width* 0.6,
        decoration: BoxDecoration(
          color: kRed,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text("Yes",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,
                  fontFamily: poppinRegular, fontSize: 16)
          ),
        ),
      ),
    );
  }

  Widget noButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 2)
        ),
        child: Center(
          child: Text("No", textAlign: TextAlign.center,
              style: TextStyle(color: borderColor,
                  fontFamily: poppinRegular, fontSize: 16)
          ),
        ),
      ),
    );
  }
}
