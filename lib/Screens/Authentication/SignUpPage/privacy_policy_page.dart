import 'dart:core';

import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import '../../../Model/privacy_policy_model.dart';
import '../../../Widget/button.dart';
import '../LoginPage/login_page.dart';
import 'package:http/http.dart'as http;

class PrivacyPolicyPage extends StatefulWidget {
  PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {

  PrivacyPolicyModel privacyPolicyModelObject = PrivacyPolicyModel();
  bool loadingP = true;
  privacyPolicyWidget() async {
    loadingP = true;
    setState(() {});
    print('in privacyPolicyApi');

    try {
      String apiUrl = privacyPolicyApiUrl;
      print("privacyPolicyApi: $apiUrl");
      final response = await http.get(Uri.parse(apiUrl));
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("response String: ${responseString.toString()}");
        privacyPolicyModelObject = privacyPolicyModelFromJson(responseString);
        print("privacyPolicyLength: ${privacyPolicyModelObject.data!.length}");
      }
    } catch (e) {
      print('Error in privacyPolicy: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    privacyPolicyWidget();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset('assets/live_chat_images/back_arrow.png', color: kWhite,),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Text("Review Terms of \nService & Privacy Policy",
                  maxLines: 2, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kWhite),),
              ],
            ),
          ),

          loadingP? Center(child: CircularProgressIndicator(color: borderColor)):
          privacyPolicyModelObject == null? Container():
          privacyPolicyModelObject.data!.isEmpty ? Center(
            child: Text('Nothing to show...',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ):

          Container(
            // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.74,
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Text(privacyPolicyModelObject.data![0].description.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14,
                    fontFamily: poppinLight, color: kWhite),),
            ),
          ),
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
              },
              child: loginButton("Accept", context)),
        ],
      ),
    );
  }
}
