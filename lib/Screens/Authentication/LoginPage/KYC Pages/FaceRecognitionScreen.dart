import 'package:flutter/material.dart';

import '../../../../Utils/colors.dart';
import '../../../../Utils/fontFamily.dart';
import 'package:get/get.dart';

import '../../../../Widget/button.dart';

class FaceRecognitionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        title: Text('Face Recognition'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Add navigation logic to go back to the previous screen.
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        backgroundColor: borderColor,
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.15,),
            Text(
              'Please Complete Face Recognition',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: poppinRegular,
              ),
            ),
            SizedBox(height: Get.height * 0.07,),
            Icon(
              Icons.camera_alt,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: Get.height * 0.07,),
            loginButton("Start Face Recognition", context),
          ],
        ),
      ),
    );
  }
}