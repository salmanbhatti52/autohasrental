import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Model/Notification/notifications_model.dart';
import '../../../../Utils/colors.dart';
import '../../MyAppBarHeader/app_bar_header.dart';
import 'package:http/http.dart' as http;

class NotificationsScreen extends StatefulWidget {
   NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  NotificationsModel notificationsModel = NotificationsModel();
  bool loadingP = true;
  getNotificationsWidget() async {
    loadingP = true;
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in notifications shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");
    // try {
    String apiUrl = notificationsApiUrl;
    print("notificationsApi: $apiUrl");
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "users_customers_id" : "8"
      },
      headers: {'Accept': 'application/json'},
    );
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("notificationsResponse: ${responseString.toString()}");
      notificationsModel = notificationsModelFromJson(responseString);
      print("notificationsLength: ${notificationsModel.data!.length}");
    }
    // } catch (e) {
    //   print('Error in evSubscription: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationsWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar:  MyAppBarSingleImage(
          title: "Notifications", backImage: "assets/home_page/back_arrow.png"),
      body: loadingP? Center(child: CircularProgressIndicator(color: borderColor)):
          notificationsModel.data!.length == 0 ?  Center(
            child: Text('No notification found...',
              style: TextStyle(fontWeight: FontWeight.bold))):
      Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              color: Colors.transparent,
              child: allNotificationList(),
            ),
          ),
        ],
      ),
    );
  }
String? myTime;
  dataFormate(){
    myTime = '2021-01-26T03:17:00.000000Z';
    DateTime parseDate =
    DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse("$myTime");
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    print("outputDate $outputDate");
  }

  Widget allNotificationList() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics:  BouncingScrollPhysics(),
        itemCount: notificationsModel.data!.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) =>  MessageDetailsScreen()));
            },
            child: Padding(
              padding:  EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: "$baseUrlImage${notificationsModel.data![index].companyLogo}",
                      height: 30, width: 30,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          CircularProgressIndicator(strokeWidth: 2, value: downloadProgress.progress, color: borderColor,),
                      errorWidget: (context, url, error) => Image.asset("assets/icon/fade_in_image.jpeg"),
                      // Icon(Icons.error),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${notificationsModel.data![index].companyName}",
                          textAlign: TextAlign.left, style: TextStyle(
                            fontSize: 14, fontFamily: poppinMedium,)),
                      Text("${notificationsModel.data![index].notificationDate}",
                          textAlign: TextAlign.left,
                          style: TextStyle( color:  Color(0xffD4DCE1),
                            fontSize: 10, fontFamily: poppinRegular,)),
                    ],
                  ),
                  subtitle: Text(
                    "${notificationsModel.data![index].message}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12, fontFamily: poppinRegular,),),
                ),
              ),
            ),
          );
        });
  }
}
