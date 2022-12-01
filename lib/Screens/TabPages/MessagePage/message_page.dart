import 'package:flutter/material.dart';
import '../../../Widget/colors.dart';
import '../MyAppBarHeader/app_bar_header.dart';
import 'msg_widget.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          myHeaderDrawer(context, "assets/home_page/Side_Menu.png", "Messages",
              "assets/home_page/notification_image.png"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.76,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: allChatList(),
            ),
          ),
        ],
      ),
    );
  }
}
