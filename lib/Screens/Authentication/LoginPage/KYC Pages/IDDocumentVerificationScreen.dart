import 'package:flutter/material.dart';

import '../../../../Utils/colors.dart';
import 'package:get/get.dart';

import '../../../../Utils/fontFamily.dart';
import '../../../../Widget/button.dart';

class IDDocumentVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        title: Text('Document Verification'),
        centerTitle: true,
        backgroundColor: borderColor,
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.15,),
            Text(
              'Please Complete Document Verification',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: poppinRegular,
              ),
            ),
            SizedBox(height: Get.height * 0.07,),
            Icon(
              Icons.file_copy,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: Get.height * 0.07,),
            loginButton("Start ID Verification", context),
          ],
        ),
      ),
    );
  }
}