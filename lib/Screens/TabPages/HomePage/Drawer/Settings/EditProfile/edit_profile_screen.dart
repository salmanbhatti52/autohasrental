import 'dart:io';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../Widget/colors.dart';
import '../../../../../Authentication/ForgetPassword/myTextWidget.dart';
import '../../../../MyAppBarHeader/app_bar_header.dart';
import '../settings_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  File? image;

  Future pickCoverImage() async {
    try {
      final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (selectedImage == null) return;
      final imageTemporary = File(selectedImage.path);
      setState(() {
        image = imageTemporary;
        print("newImage $image");
        // onUploadImage();
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarSingleImage(
        title: "Edit Profile", backImage: "assets/messages_images/Back.png",),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
            //
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
            //       Text("Edit Profile",
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kBlack),),
            //
            //       Container(),
            //     ],
            //   ),
            // ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: kWhite,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: kWhite, width: 3)),
                      child: CircleAvatar(
                        radius: (screenWidth > 600) ? 90 : 70,
                        backgroundColor: Colors.transparent,
                        backgroundImage: image == null?
                        const AssetImage("assets/home_page/user.png",)
                        // const AssetImage("assets/payment_card_images/edit_profile_icon.png")
                            : Image.file(image!, height: 50, width: 50, fit: BoxFit.contain,).image,
                      ),
                    ),

                    Positioned(
                      right: 0,
                      bottom: 18,
                      child: GestureDetector(
                          onTap: (){
                            pickCoverImage();
                          },
                          child: Image.asset("assets/payment_card_images/edit_profile_icon.png")),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            buildTextFields(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.0,),

            GestureDetector(
              onTap:(){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
              },
                child: loginButton("Update", context)),
          ],
        ),
      ),
    );
  }

  Widget buildTextFields() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        changePasswordTextWidget("First Name"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            cursorColor: borderColor,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                  top: 15, left: 20, bottom: 15),
                              // focusedBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(30.0),
                              //     borderSide: BorderSide(color: borderColor)
                              // ),
                              hintText: 'John',
                              hintStyle: TextStyle(color: textLabelColor, fontFamily: 'Poppins-Regular',),
                              // labelStyle: TextStyle(color: textLabelColor),
                              focusColor: borderColor,
                            ),
                            style: TextStyle(color: textLabelColor, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("Last Name"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            cursorColor: borderColor,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                  top: 15, left: 20, bottom: 15),
                              // focusedBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(30.0),
                              //     borderSide: BorderSide(color: borderColor)
                              // ),
                              hintText: 'Doe',
                              hintStyle: TextStyle(color: textLabelColor, fontFamily: 'Poppins-Regular',),
                              // labelStyle: TextStyle(color: textLabelColor),
                              focusColor: borderColor,
                            ),
                            style: TextStyle(color: textLabelColor, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("About"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            cursorColor: borderColor,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                  top: 15, left: 20, bottom: 15),
                              // focusedBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(30.0),
                              //     borderSide: BorderSide(color: borderColor)
                              // ),
                              hintText: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam.',
                              hintStyle: TextStyle(color: textLabelColor, fontFamily: 'Poppins-Regular',),
                              // labelStyle: TextStyle(color: textLabelColor),
                              focusColor: borderColor,
                            ),
                            style: TextStyle(color: textLabelColor, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("Email"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            cursorColor: borderColor,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                  top: 15, left: 20, bottom: 15),
                              hintText: 'rose.matthews@mail.com',
                              hintStyle: TextStyle(color: textLabelColor, fontFamily: 'Poppins-Regular',),
                              // labelStyle: TextStyle(color: textLabelColor),
                              focusColor: borderColor,
                            ),
                            style: TextStyle(color: textLabelColor, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("Location"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            cursorColor: borderColor,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                  top: 15, left: 20, bottom: 15),
                              // focusedBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(30.0),
                              //     borderSide: BorderSide(color: borderColor)
                              // ),
                              hintText: 'Enter your location here',
                              hintStyle: TextStyle(color: textLabelColor, fontFamily: 'Poppins-Regular',),
                              // labelStyle: TextStyle(color: textLabelColor),
                              focusColor: borderColor,
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
