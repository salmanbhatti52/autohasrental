import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/fontFamily.dart';
import '../../../../Widget/button.dart';
import '../../../TabPages/MyAppBarHeader/app_bar_header.dart';
import 'FaceRecognitionScreen.dart';
import 'IDDocumentVerificationScreen.dart';

class KYCSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: MyAppBarSignUp(title: "KYC Verification"),
      // appBar: AppBar(
      //   title: Text('KYC Verification'),
      //   centerTitle: true,
      //   backgroundColor: borderColor,
      // ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: Get.height * 0.07,),
            Image.asset("assets/intro_images/KYC.png", width: 350,),
            Text(
              'Choose Your Verification Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: poppinRegular,
              ),
            ),
            SizedBox(height: Get.height * 0.03,),
            GestureDetector(onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FaceRecognitionScreen()));
            },child: loginButton("Face Recognition", context, )),
            GestureDetector(onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => IDDocumentVerificationScreen()));
            },child: loginButton("Document Verification", context)),
          ],
        ),
      ),
    );
  }
}