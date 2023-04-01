import 'dart:convert';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/ChatsModels/all_chats_model.dart';
import '../../../Model/Notification/notifications_unread_model.dart';
import '../HomePage/Drawer/Settings/settings_screen.dart';
import '../HomePage/Drawer/drawer_screen.dart';
import '../Homepage/Notifications/notification_screen.dart';
import 'package:http/http.dart'as http;
import 'message_details_screen.dart';

class MessagePage extends StatefulWidget {
   MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  NotificationsUnReadModel notificationsUnReadModelObject = NotificationsUnReadModel();

  String? userId;
  bool loadingP = true;
  sharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in msgs shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");
    notificationStatus = (prefs.getString('notification_status'));
    print("notificationStatus in sharedPrefs $notificationStatus");
    getUnreadNotificationWidget();
    userChatHistoryApi();
  }

  getUnreadNotificationWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in HomePagePrefs is= $userId");
    loadingP = true;
    setState(() {});
    try {
      String apiUrl = unReadNotificationsApiUrl;
      print("gunReadNotificationsApi: $apiUrl");
      print("getUserId: $userId");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id" : userId,
          },
          headers: {
            'Accept': 'application/json'
          });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("getUserProfileResponseHomePage: ${responseString.toString()}");
        notificationsUnReadModelObject = notificationsUnReadModelFromJson(responseString);
        print("unReadNotificationsLength: ${notificationsUnReadModelObject.data!.length}");
      }
    } catch (e) {
      print('Error in gunReadNotification: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      body: loading ? Center(child: CircularProgressIndicator(color: borderColor)):
      Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    print("clicked");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DrawerScreen()));
                  },
                  child: Image.asset("assets/home_page/Side_Menu.png",
                    height: 25,
                    width: 25,
                  ),
                ),
                Text("Messages", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kBlack)),

                notificationStatus == "Yes"?
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => NotificationsScreen()));
                  },
                  child: Stack(
                    children: [
                      SvgPicture.asset("assets/home_page/notification_bell.svg"),
                      Positioned(
                        right: 02,
                        left: 05,
                        bottom: 10,
                        child: notificationsUnReadModelObject.data?.length == 0 ? Container():
                        Container(
                            height: 12, width: 12,
                            decoration: BoxDecoration(
                                color: kRed,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Center(
                              child: Text("${notificationsUnReadModelObject.data?.length}",
                                style: TextStyle(color: kWhite, fontSize: 08),),
                            )),
                      ),
                    ],
                  ),
                ) : Container(),
              ],
            ),
          ),
          loading ? Center(child: CircularProgressIndicator(color: borderColor)):
          allChatModel.isEmpty?  Center(
            child: Text('No Chat found...',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ):
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.76,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius:  BorderRadius.only(
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

  bool loading = true;

  List<AllChatsListModel> allChatModel = [];
  userChatHistoryApi() async {
    setState(() {
      loading = true;
    });
    Map body = {
      'users_customers_id': userId,
    };
    http.Response response = await http.post(Uri.parse(getAllChatApiUrl),
        body: body,
        headers: {
          "Accept": "application/json"
        });
    Map jsonData = jsonDecode(response.body);
    print("chatHistoryApiUrl: $getAllChatApiUrl");
    print('chatHistoryApiResponse == $jsonData');
    if (jsonData['message'] == 'chat unavailable.') {
      // toastSuccessMessage("Chat Not found", kRed);
      print('Chat not found!');
      setState(() {
        loading = false;
      });
    }
    else if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        print(obj['id']);
        var pos = AllChatsListModel();
        pos = AllChatsListModel.fromJson(obj);
        allChatModel.add(pos);
        print("showAllMessagesLength: ${allChatModel.length}");
        setState(() {
          loading = false;
        });
      }
    }
  }

  Widget allChatList() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemCount: allChatModel.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MessageDetailsScreen(
                    carOwnerName: allChatModel[index].companyName,
                    carOwnerImage: "$baseUrlImage${allChatModel[index].companyLogo}",
                    carOwnerId: "${allChatModel[index].receiverId}",
                  )));
              print("company Name & Id ${allChatModel[index].companyName} ${allChatModel[index].receiverId}");
              print("companyLogoImage $baseUrlImage${allChatModel[index].companyLogo}");
            },
            child: Column(
              children: [
                ListTile(
                  leading: allChatModel[index].companyLogo == null? ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.asset('assets/icon/fade_in_image.jpeg')):
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FadeInImage(
                      placeholder:  AssetImage("assets/icon/fade_in_image.jpeg"),
                      fit: BoxFit.fill,
                      height: 60,
                      width: 60,
                      image: NetworkImage("$baseUrlImage${allChatModel[index].companyLogo}"),
                    ),
                  ),
                  title: Text("${allChatModel[index].companyName}",
                    textAlign: TextAlign.left, style: TextStyle(
                      fontSize: 15, fontFamily: poppinMedium)),
                  subtitle: Text(
                    "${allChatModel[index].lastMessage}",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: poppinRegular,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  trailing: Text(
                      "${allChatModel[index].date}",
                    style: TextStyle(
                      fontSize: 10,
                      color:  Color(0xffB1A8B9),
                      fontFamily: poppinRegular,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                 Divider(),
              ],
            ),
          );
        });
  }
}
