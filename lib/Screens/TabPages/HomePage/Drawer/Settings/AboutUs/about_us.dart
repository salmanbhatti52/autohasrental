import 'package:auto_haus_rental_app/Model/about_us_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../MyAppBarHeader/app_bar_header.dart';

class AboutUsPage extends StatefulWidget {
  AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  AboutUsModel aboutUsModelObject = AboutUsModel();
  bool loadingP = true;
  aboutUsApiWidget() async {
    loadingP = true;
    setState(() {});
    print('in aboutUsApi');

    try {
      String apiUrl = aboutUsApiUrl;
      print("privacyPolicyApi: $apiUrl");
      final response = await http.get(Uri.parse(apiUrl));
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("responseAboutUs: ${responseString.toString()}");
        aboutUsModelObject = aboutUsModelFromJson(responseString);
        print("aboutUsDataLength: ${aboutUsModelObject.data!.length}");
      }
    } catch (e) {
      print('Error in aboutUs: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    aboutUsApiWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: MyAppBarAboutUsPage(
        backImage: "assets/home_page/Side_Menu.png", title: "About Us"),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 20),
                child: loadingP? Center(child: CircularProgressIndicator(color: borderColor)):
                aboutUsModelObject.data == null? Container():
                aboutUsModelObject.data!.isEmpty ? Center(
                  child: Text('Nothing to show...',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ):
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Center(
                    child: Text(aboutUsModelObject.data![0].description.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16,
                          fontFamily: poppinRegular, color: kWhite),
                ),
                  ),
                ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
