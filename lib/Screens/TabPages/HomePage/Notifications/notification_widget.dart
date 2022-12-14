import 'package:flutter/material.dart';

import '../../../../Utils/colors.dart';

Widget allNotificationList(){
  return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: notificationItemsList.length,
      itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const MessageDetailsScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Image.asset(notificationItemsList[index].image, height: 30, width: 30,),
                title: Text(notificationItemsList[index].sendName, textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 14, fontFamily: 'Poppins-Medium',)),
                subtitle: Text(notificationItemsList[index].messageDescription, textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 12, fontFamily: 'Poppins-Regular',),),
                trailing: Text(notificationItemsList[index].msgTime, textAlign: TextAlign.left, style: const TextStyle(fontSize: 10,fontFamily: 'Poppins-Regular',)),
              ),
            ),
          ),
        );
      });
}

List notificationItemsList = [
  NotificationClass( "assets/home_page/user.png", 'Notification title', "Company name accepted your booking.", "6:40 am",),
  NotificationClass( "assets/home_page/user.png", 'Notification title', "Company name accepted your booking.", "6:40 am",),
  NotificationClass( "assets/home_page/user.png", 'Notification title', "Company name accepted your booking.", "6:40 am",),
  NotificationClass( "assets/home_page/user.png", 'Notification title', "Company name accepted your booking.", "6:40 am",),
  NotificationClass( "assets/home_page/user.png", 'Notification title', "Company name accepted your booking.", "6:40 am",),
  NotificationClass( "assets/home_page/user.png", 'Notification title', "Company name accepted your booking.", "6:40 am",),
  NotificationClass( "assets/home_page/user.png", 'Notification title', "Company name accepted your booking.", "6:40 am",),
  NotificationClass( "assets/home_page/user.png", 'Notification title', "Company name accepted your booking.", "6:40 am",),
  NotificationClass( "assets/home_page/user.png", 'Notification title', "Company name accepted your booking.", "6:40 am",),
  NotificationClass( "assets/home_page/user.png", 'Notification title', "Company name accepted your booking.", "6:40 am",),
  NotificationClass( "assets/home_page/user.png", 'Notification title', "Company name accepted your booking.", "6:40 am",),
  NotificationClass( "assets/home_page/user.png", 'Notification title', "Company name accepted your booking.", "6:40 am",),
];

class NotificationClass {
  final String image;
  final String sendName;
  final String messageDescription;
  final String msgTime;

  NotificationClass(this.image, this.sendName, this.messageDescription, this.msgTime,);
}