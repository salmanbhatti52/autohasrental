import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Model/Notification/notifications_model.dart';
import '../../MyAppBarHeader/app_bar_header.dart';
import 'package:http/http.dart' as http;

class NotificationsScreen extends StatefulWidget {
   NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  NotificationsListModel notificationsModel = NotificationsListModel();
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
        "users_customers_id" : userId
      },
      headers: {'Accept': 'application/json'},
    );
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("notificationsResponse: ${responseString.toString()}");
      notificationsModel = notificationsListModelFromJson(responseString);
      print("notificationsLength: ${notificationsModel.data!.length}");
      print("notificationsLength: ${notificationsModel.data![0].notificationDate}");
      formattedDate();
    }
    // } catch (e) {
    //   print('Error in evSubscription: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {
    });
  }

  List<Datum> newList = [];
  String? formattedDateTime;
  DateTime? dateTime;
formattedDate(){
  for(int i = 0; i<notificationsModel.data!.length; i++){
    dateTime = DateTime.parse("${notificationsModel.data![i].notificationDate}");
    formattedDateTime = '${dateTime!.year}-${dateTime!.month.toString().padLeft(2, '0')}-${dateTime!.day.toString().padLeft(2, '0')} ${dateTime!.hour.toString().padLeft(2, '0')}:${dateTime!.minute.toString().padLeft(2, '0')}:${dateTime!.second.toString().padLeft(2, '0')}';
    print("formattedDateTimeLength $formattedDateTime");
    notificationsModel.data![i].formattedDateTime = formattedDateTime;
    print("notificationsModelDate ${notificationsModel.data![i].formattedDateTime}");
  }
  // for(int i = notificationsModel.data!.length; i>0; i--){
  //   newList.add(notificationsModel.data![i]);
  //   print("newListLength ${newList.length}");
  //   // newList.add(NotificationsListModel(
  //   //   data: notificationsModel.data![i];
  //   // ))
  // }

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

  ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  Widget allNotificationList() {
    return ListView.builder(
        shrinkWrap: true,
        // reverse: true,
        // physics: BouncingScrollPhysics(),
        itemCount: notificationsModel.data!.length,
        // controller: scrollController,
        // scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          int reverseIndex = notificationsModel.data!.length - 1 - index;
          return Padding(
            padding: EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: "$baseUrlImage${notificationsModel.data![reverseIndex].companyLogo}",
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
                    Text("${notificationsModel.data![reverseIndex].companyName}",
                        textAlign: TextAlign.left, style: TextStyle(
                          fontSize: 14, fontFamily: poppinMedium,)),
                    Text("${notificationsModel.data![reverseIndex].formattedDateTime}",
                        textAlign: TextAlign.left,
                        style: TextStyle( color: Colors.grey,
                          fontSize: 10, fontFamily: poppinRegular,)),
                  ],
                ),
                subtitle: Text(
                  "${notificationsModel.data![reverseIndex].message}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12, fontFamily: poppinRegular,),),
              ),
            ),
          );
        });
  }
}
