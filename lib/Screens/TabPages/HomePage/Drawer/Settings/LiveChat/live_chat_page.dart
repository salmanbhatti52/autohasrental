import 'dart:convert';
import 'package:auto_haus_rental_app/Model/LiveChat/get_admin_list_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../drawer_screen.dart';
import 'live_chat_details_page.dart';
import 'package:http/http.dart' as http;

class LiveChatPage extends StatefulWidget {
  LiveChatPage({super.key});

  @override
  State<LiveChatPage> createState() => _LiveChatPageState();
}

class _LiveChatPageState extends State<LiveChatPage> {
  GetAdminListModel getAdminListModelObject = GetAdminListModel();
  bool loadingP = false;
  bool loading2 = false;

  getAdminListWidget() async {
    loadingP = true;
    setState(() {});
    try {
      String apiUrl = getAdminListApiUrl;
      print("getAdminListApi: $apiUrl");
      final response = await http.get(Uri.parse(apiUrl));
      print('${response.statusCode}');
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("getAdminResponse: ${responseString.toString()}");
        getAdminListModelObject = getAdminListModelFromJson(responseString);
        loadingP = false;
        setState(() {});
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
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    print("clicked");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrawerScreen()));
                  },
                  child: Image.asset(
                    "assets/home_page/Side_Menu.png",
                    height: 25,
                    width: 25,
                  ),
                ),
                Text("Live Chat",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20, fontFamily: poppinBold, color: kBlack)),
                SizedBox(),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Image.asset('assets/live_chat_images/service _24_7.png'),
          SizedBox(height: 10),
          RichText(
            text: TextSpan(
              text: "Need Help? ",
              style: TextStyle(
                  fontSize: 20, fontFamily: poppinBold, color: appBgColor),
              children: [
                TextSpan(
                    text: "We're here",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: poppinBold,
                        color: borderColor,
                    ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () async {
              String url = 'tel:${getAdminListModelObject.data![0].mobile}';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              }
            },
            child: Container(
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
                    loadingP
                        ? Text(
                            '',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: poppinRegular,
                              color: Color(0xff8d8d8d),
                            ),
                            textAlign: TextAlign.left,
                          )
                        : Text(
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
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () async {
              final Uri _emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: '${getAdminListModelObject.data![0].email}',
                  queryParameters: {'': ''});
              launch(_emailLaunchUri.toString());
            },
            child: Container(
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
                    loadingP
                        ? Text(
                            '',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: poppinRegular,
                              color: Color(0xff8d8d8d),
                            ),
                            textAlign: TextAlign.left,
                          )
                        : Text(
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
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          GestureDetector(
            onTap: () async {

              await startLiveChatApiWidget();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LiveChatDetailsPage(
                    adminId: getAdminListModelObject.data![0].usersSystemId,
                  ),
                ),
              );
            },
            child: loginButton('Chat with us', context),
          ),
        ],
      ),
    );
  }

  startLiveChatApiWidget() async {
    setState(() {
      loading2 = true;
    });
    Map body = {
      "requestType": "startChat",
      "users_customers_id": userId,
      "other_users_customers_id":
          "${getAdminListModelObject.data![0].usersSystemId}",
    };
    http.Response response = await http.post(Uri.parse(startLiveChatApiUrl),
        body: body, headers: {"Accept": "application/json"});
    Map jsonData = jsonDecode(response.body);
    print("startLiveChatApiUrl: $startLiveChatApiUrl");
    print('userId $userId');
    print(
        'otherUsersCustomersId ${getAdminListModelObject.data![0].usersSystemId}');
    print('startLiveChatApiResponse $jsonData');

    if (jsonData['message'] == 'chat already started') {
      print('chat already started');
      setState(() {
        loading2 = false;
      });
    }
  }
}
