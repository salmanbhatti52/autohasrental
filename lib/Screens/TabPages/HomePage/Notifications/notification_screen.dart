import 'package:flutter/material.dart';
import '../../../../Utils/colors.dart';
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
      appBar: const MyAppBarSingleImage(
        title: "Notifications", backImage: "assets/home_page/back_arrow.png",),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: MediaQuery.of(context).size.height* 0.85,
              color: Colors.transparent,
              child: allNotificationList(),
            ),
          ),
        ],
      ),
    );
  }
}
