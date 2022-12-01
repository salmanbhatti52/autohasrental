import 'package:flutter/material.dart';
import '../../../../Widget/colors.dart';
import '../../MyAppBarHeader/app_bar_header.dart';
import 'notification_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const myAppBarSingleImage(
        title: "Notifications", backImage: "assets/messages_images/Back.png",),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: MediaQuery.of(context).size.height* 0.87,
              color: Colors.transparent,
              child: allNotificationList(),
            ),
          ),
        ],
      ),
    );
  }
}
