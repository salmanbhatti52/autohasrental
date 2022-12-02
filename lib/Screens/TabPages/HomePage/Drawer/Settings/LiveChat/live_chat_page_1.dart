import 'package:auto_haus_rental_app/Widget/fontFamily.dart';
import 'package:flutter/material.dart';

import '../../../../../../Widget/button.dart';
import '../../../../../../Widget/colors.dart';
import '../../../../MyAppBarHeader/app_bar_header.dart';
import 'live_chat_page_2.dart';

class LiveChatPage1 extends StatefulWidget {
  const LiveChatPage1({super.key});

  @override
  State<LiveChatPage1> createState() => _LiveChatPage1State();
}

class _LiveChatPage1State extends State<LiveChatPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarSettingsPage(
        backImage: "assets/home_page/Side_Menu.png", title: "Live Chat", ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

          Image.asset('assets/live_chat_images/service _24_7.png'),
          const SizedBox(height: 10),
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
          const SizedBox(height: 30),
          Container(
            width: 343,
            height: 69,
            decoration: BoxDecoration(
              color: const Color(0xfffbfbfb),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
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
                    '00971526454139',
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
          const SizedBox(height: 15),
          Container(
            width: 343,
            height: 69,
            decoration: BoxDecoration(
              color: const Color(0xfffbfbfb),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
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
                    '360uae1@gmail.com',
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const LiveChatPage2()));
              },
              child: loginButton('Chat with us', context),
          ),
        ],
      ),
    );
  }
}
