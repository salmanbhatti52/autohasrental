import 'dart:convert';

import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/Chats/all_chats_model.dart';
import '../../../Utils/api_urls.dart';
import '../../../Utils/colors.dart';
import '../../../Utils/fontFamily.dart';
import '../MyAppBarHeader/app_bar_header.dart';
import 'package:http/http.dart'as http;

import 'message_details_screen.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  String? userId;
  sharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in msgs shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");

    // getAllChatWidget();

    userChatHistoryApi();

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
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          myHeaderDrawer(context, "assets/home_page/Side_Menu.png", "Messages",
              "assets/home_page/notification_image.png"),
          loading ? Center(child: CircularProgressIndicator(color: borderColor)):
          allChatModel.isEmpty? const Center(
            child: Text('No Chat found...',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ):
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

  bool loading = true;

  List<AllChatsListModel> allChatModel = [];
  userChatHistoryApi() async {
    setState(() {
      loading = true;
    });
    Map body = {
      'users_customers_id': userId,
      // 'users_customers_id': "36",
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
      toastSuccessMessage("Chat Not found", kRed);
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
        physics: const BouncingScrollPhysics(),
        // itemCount: messageItemsList.length,
        itemCount: allChatModel.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const MessageDetailsScreen()));
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
                      placeholder: const AssetImage("assets/icon/fade_in_image.jpeg"),
                      fit: BoxFit.fill,
                      height: 60,
                      width: 60,
                      image: NetworkImage("$baseUrlImage${allChatModel[index].companyLogo}"),
                    ),
                  ),

                  // Image.asset(messageItemsList[index].image),
                  title: Text(
                    "${allChatModel[index].companyName}",
                    // messageItemsList[index].sendName,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: poppinMedium,
                    ),
                    textAlign: TextAlign.left,
                  ),
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
                      color: const Color(0xffB1A8B9),
                      fontFamily: poppinRegular,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const Divider(),
              ],
            ),
          );
        });
  }
}

List messageItemsList = [
  MessageItemList(
    "assets/home_page/user.png",
    'Josh Gibson',
    "Subject line comes here",
    "10 min ago",
  ),
  MessageItemList(
    "assets/home_page/user.png",
    'Miss Mindy Kub',
    "Subject line comes here",
    "Yesterday",
  ),
  MessageItemList(
    "assets/home_page/user.png",
    'Roxanne Nitzsche',
    "Subject line comes here",
    "Yesterday",
  ),
  MessageItemList(
    "assets/home_page/user.png",
    'Deanna Stamm',
    "Subject line comes here",
    "29 August 2022",
  ),
  MessageItemList(
    "assets/home_page/user.png",
    'Nettie Dicki V',
    "Subject line comes here",
    "29 August 2022",
  ),
  MessageItemList(
    "assets/home_page/user.png",
    'Eula Mitchell',
    "Subject line comes here",
    "29 August 2022",
  ),
  MessageItemList(
    "assets/home_page/user.png",
    'Lorium',
    "Subject line comes here",
    "29 August 2022",
  ),
  MessageItemList(
    "assets/home_page/user.png",
    'Josh Gibson',
    "Subject line comes here",
    "10 min ago",
  ),
  MessageItemList(
    "assets/home_page/user.png",
    'Miss Mindy Kub',
    "Subject line comes here",
    "Yesterday",
  ),
  MessageItemList(
    "assets/home_page/user.png",
    'Roxanne Nitzsche',
    "Subject line comes here",
    "29 August 2022",
  ),
  MessageItemList(
    "assets/home_page/user.png",
    'Deanna Stamm',
    "Subject line comes here",
    "29 August 2022",
  ),
  MessageItemList(
    "assets/home_page/user.png",
    'Nettie Dicki V',
    "Subject line comes here",
    "29 August 2022",
  ),
  MessageItemList(
    "assets/home_page/user.png",
    'Eula Mitchell',
    "Subject line comes here",
    "29 August 2022",
  ),
  MessageItemList(
    "assets/home_page/user.png",
    'Lorium',
    "Subject line comes here",
    "29 August 2022",
  ),
];

class MessageItemList {
  final String image;
  final String sendName;
  final String messageDescription;
  final String msgTime;

  MessageItemList(
      this.image,
      this.sendName,
      this.messageDescription,
      this.msgTime,
      );
}
