import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/Drawer/Settings/settings_screen.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Widget/colors.dart';
import 'package:flutter/material.dart';

import '../../../../../Authentication/ForgetPassword/myTextWidget.dart';
import '../../../../MyAppBarHeader/app_bar_header.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool obscureOldPass  = true;
  bool obscureNewPass  = true;
  bool obscureConfirmPass  = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const myAppBarSingleImage(
        title: "Change Password", backImage: "assets/messages_images/Back.png",),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.07,),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       GestureDetector(
            //         onTap:(){
            //           Navigator.pop(context);
            //         },
            //         child: Image.asset("assets/messages_images/Back.png", height: 25, width: 25,),),
            //
            //       Text("Change Password",
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kBlack),),
            //
            //       Container(),
            //     ],
            //   ),
            // ),

            // SizedBox(height: MediaQuery.of(context).size.height * 0.1,),

            buildTextFields(),

            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),

            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                },
                child: loginButton("Reset", context)),
          ],
        ),
      ),
    );
  }

  Widget buildTextFields() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Form(
                // key: loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("Enter Old Password"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(20),
                              // focusedBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(30.0),
                              //     borderSide: BorderSide(color: borderColor)
                              // ),
                              hintText: '*********',
                              hintStyle: TextStyle(color: textLabelColor),
                              // labelStyle: TextStyle(color: textLabelColor),
                              focusColor: borderColor,
                              suffixIcon: Padding(
                                padding: const EdgeInsetsDirectional.only(end: 12.0),
                                child: IconButton(
                                  icon: Icon(
                                      obscureOldPass ?  Icons.visibility :Icons.visibility_off,
                                      color: textLabelColor),
                                  onPressed: () {
                                    setState(() {
                                      obscureOldPass = !obscureOldPass;
                                    });
                                  },
                                ),
                              ),
                            ),
                            style: TextStyle(color: textLabelColor, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("Enter New Password"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(20),
                              // focusedBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(30.0),
                              //     borderSide: BorderSide(color: borderColor)
                              // ),
                              hintText: '*********',
                              hintStyle: TextStyle(color: textLabelColor),
                              // labelStyle: TextStyle(color: textLabelColor),
                              focusColor: borderColor,
                              suffixIcon: Padding(
                                padding: const EdgeInsetsDirectional.only(end: 12.0),
                                child: IconButton(
                                  icon: Icon(
                                      obscureNewPass ?  Icons.visibility :Icons.visibility_off,
                                      color: textLabelColor),
                                  onPressed: () {
                                    setState(() {
                                      obscureNewPass = !obscureNewPass;
                                    });
                                  },
                                ),
                              ),
                            ),
                            style: TextStyle(color: textLabelColor, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("Enter Confirm Password"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(20),
                              // focusedBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(30.0),
                              //     borderSide: BorderSide(color: borderColor)
                              // ),
                              hintText: '*********',
                              hintStyle: TextStyle(color: textLabelColor),
                              // labelStyle: TextStyle(color: textLabelColor),
                              focusColor: borderColor,
                              suffixIcon: Padding(
                                padding: const EdgeInsetsDirectional.only(end: 12.0),
                                child: IconButton(
                                  icon: Icon(
                                      obscureConfirmPass ?  Icons.visibility_off: Icons.visibility,
                                      color: textLabelColor),
                                  onPressed: () {
                                    setState(() {
                                      obscureConfirmPass = !obscureConfirmPass;
                                    });
                                  },
                                ),
                              ),
                            ),
                            style: TextStyle(color: textLabelColor, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
