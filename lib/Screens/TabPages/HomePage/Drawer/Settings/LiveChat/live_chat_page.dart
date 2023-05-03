import 'dart:convert';
import 'package:auto_haus_rental_app/Model/LiveChat/get_admin_list_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:flutter/material.dart';
import 'live_chat_details_page.dart';
import 'package:http/http.dart'as http;

class LiveChatPage extends StatefulWidget {
  LiveChatPage({super.key});

  @override
  State<LiveChatPage> createState() => _LiveChatPageState();
}

class _LiveChatPageState extends State<LiveChatPage> {
  GetAdminListModel getAdminListModelObject = GetAdminListModel();
  bool loadingP = true;

  getAdminListWidget() async {
    loadingP = true;
    setState(() {});
    print('in getAdminListAPI');
    try {
      String apiUrl = getAdminListApiUrl;
      print("getAdminListApi: $apiUrl");
     final response = await http.get(Uri.parse(apiUrl));
      print('${response.statusCode}');
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("getAdminResponse: ${responseString.toString()}");
        getAdminListModelObject = getAdminListModelFromJson(responseString);
        print("getAdminEmail: ${getAdminListModelObject.data![0].email}");
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdminListWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: MyAppBarSettingsPage(
        backImage: "assets/home_page/Side_Menu.png", title: "Live Chat", ),
      body: loadingP ? Center(
          child: CircularProgressIndicator(backgroundColor: borderColor)) :
      Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

          Image.asset('assets/live_chat_images/service _24_7.png'),
          SizedBox(height: 10),
          RichText(
            text: TextSpan(
              text: "Need Help? ",
              style: TextStyle(
                  fontSize: 20, fontFamily: poppinBold, color: appBgColor),
              children: [
                TextSpan(text: "We're here", style: TextStyle(
                    fontSize: 20, fontFamily: poppinBold, color: borderColor)),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: 343,
            height: 69,
            decoration: BoxDecoration(
              color: Color(0xfffbfbfb),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Give us a call',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: poppinSemiBold,
                      color: kBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    '${getAdminListModelObject.data![0].mobile}',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: poppinRegular,
                      color: Color(0xff8d8d8d),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: 343,
            height: 69,
            decoration: BoxDecoration(
              color: Color(0xfffbfbfb),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email us',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: poppinBold,
                      color: kBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    '${getAdminListModelObject.data![0].email}',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: poppinRegular,
                      color: Color(0xff8d8d8d),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height* 0.1),
          GestureDetector(
              onTap: () async {
               await startLiveChatApiWidget();

                Navigator.push(context, MaterialPageRoute(
                        builder: (context) => LiveChatDetailsPage(
                          adminId: getAdminListModelObject.data![0].usersSystemId,
                          adminImage: getAdminListModelObject.data![0].userImage,
                        )));
                print("userImage $baseUrlImage${getAdminListModelObject.data![0].userImage}");
              },
              child: loginButton('Chat with us', context),
          ),
        ],
      ),
    );
  }

  startLiveChatApiWidget() async {
    setState(() {
      loadingP = true;
    });
    Map body = {
      "requestType": "startChat",
      "users_customers_id": userId,
      "other_users_customers_id": "${getAdminListModelObject.data![0].usersSystemId}",
    };
    http.Response response = await http.post(Uri.parse(startLiveChatApiUrl),
        body: body,
        headers: {
          "Accept": "application/json"
        });
    Map jsonData = jsonDecode(response.body);
    print("startLiveChatApiUrl: $startLiveChatApiUrl");
    print('userId $userId');
    print('otherUsersCustomersId ${getAdminListModelObject.data![0].usersSystemId}');
    print('startLiveChatApiResponse $jsonData');

    if (jsonData['message'] == 'chat already started') {
      print('chat already started');
      setState(() {
        loadingP = false;
      });
    }
  }
}
