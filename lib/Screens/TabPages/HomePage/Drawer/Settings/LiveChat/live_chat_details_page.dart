import 'dart:convert';
import 'package:auto_haus_rental_app/Model/ChatsModels/get_messages_model.dart';
import 'package:auto_haus_rental_app/Model/ChatsModels/send_message_model.dart';
import 'package:auto_haus_rental_app/Model/ChatsModels/update_message_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../Utils/colors.dart';
import '../../../../../../Utils/fontFamily.dart';
import 'package:http/http.dart'as http;

class LiveChatDetailsPage extends StatefulWidget {
  const LiveChatDetailsPage({super.key});

  @override
  State<LiveChatDetailsPage> createState() => _LiveChatDetailsPageState();
}

class _LiveChatDetailsPageState extends State<LiveChatDetailsPage> {

  final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
  var sendMessageController = TextEditingController();
  List<GetMessageDetailsModel> messageDetailsModelObject = [];
  List<UpdateMessageModel> updateMessageModelObject = [];
  bool progress = false;
  SendMessageModel sendMessageModelObject = SendMessageModel();
  bool loading = true;


  // List<LiveChatMessage> messages = [
  //   LiveChatMessage(
  //       messageContent:
  //           "Phasellus finibus enim nulla, quis ornare odio facilisis eu. "
  //           "Suspendisse ornare ante sit amet arcu semper, vel eleifend tortor egestas. "
  //           "Aenean luctus, lorem in hendrerit interdum, leo orci egestas diam, ac euismod "
  //           "massa est et turpis. Etiam auctor lectus vel neque convallis pharetra. Ut turpis "
  //           "eros, aliquet non ante id, interdum placerat erat. Curabitur sit amet eros vel orci "
  //           "venenatis hendrerit. Cras sagittis sagittis sagittis. In hac habitasse platea dictumst. "
  //           "Phasellus diam erat, porttitor sed ligula at, ultricies auctor tellus. Donec ut sem in "
  //           "turpis ultrices suscipit ut auctor tellus. Quisque a tincidunt ipsum.",
  //       messageType: "receiver"),
  //   LiveChatMessage(messageContent: "Hi, Mardin", messageType: "sender"),
  //   LiveChatMessage(messageContent: "What you want?", messageType: "sender"),
  //   LiveChatMessage(messageContent: "Hi, Jeanie", messageType: "receiver"),
  //   LiveChatMessage(
  //       messageContent:
  //           "Phasellus finibus enim nulla, quis ornare odio facilisis eu. "
  //           "Suspendisse ornare ante sit amet arcu semper, vel eleifend tortor egestas. "
  //           "Aenean luctus, lorem in hendrerit interdum, leo orci egestas diam, ac euismod "
  //           "massa est et turpis. Etiam auctor lectus vel neque convallis pharetra. "
  //           "Ut turpis eros, aliquet non ante id, interdum placerat erat. Curabitur "
  //           "sit amet eros vel orci venenatis hendrerit. Cras sagittis sagittis sagittis. "
  //           "In hac habitasse platea dictumst. Phasellus diam erat, porttitor sed ligula at, "
  //           "ultricies auctor tellus. Donec ut sem in turpis ultrices suscipit ut auctor tellus. "
  //           "Quisque a tincidunt ipsum.",
  //       messageType: "sender"),
  //   LiveChatMessage(
  //       messageContent:
  //           "Phasellus finibus enim nulla, quis ornare odio facilisis eu. "
  //           "Suspendisse ornare ante sit amet arcu semper, vel eleifend tortor egestas. "
  //           "Aenean luctus, lorem in hendrerit interdum, leo orci egestas diam, ac euismod "
  //           "massa est et turpis. Etiam auctor lectus vel neque convallis pharetra. Ut turpis "
  //           "eros, aliquet non ante id, interdum placerat erat. Curabitur sit amet eros vel orci "
  //           "venenatis hendrerit. Cras sagittis sagittis sagittis. In hac habitasse platea dictumst. "
  //           "Phasellus diam erat, porttitor sed ligula at, ultricies auctor tellus. Donec ut sem in "
  //           "turpis ultrices suscipit ut auctor tellus. Quisque a tincidunt ipsum.",
  //       messageType: "receiver"),
  //   LiveChatMessage(messageContent: "Hi, Mardin", messageType: "sender"),
  //   LiveChatMessage(messageContent: "What you want?", messageType: "sender"),
  //   LiveChatMessage(messageContent: "Hi, Jeanie", messageType: "receiver"),
  //   LiveChatMessage(
  //       messageContent:
  //           "Phasellus finibus enim nulla, quis ornare odio facilisis eu. "
  //           "Suspendisse ornare ante sit amet arcu semper, vel eleifend tortor egestas. "
  //           "Aenean luctus, lorem in hendrerit interdum, leo orci egestas diam, ac euismod "
  //           "massa est et turpis. Etiam auctor lectus vel neque convallis pharetra. "
  //           "Ut turpis eros, aliquet non ante id, interdum placerat erat. Curabitur "
  //           "sit amet eros vel orci venenatis hendrerit. Cras sagittis sagittis sagittis. "
  //           "In hac habitasse platea dictumst. Phasellus diam erat, porttitor sed ligula at, "
  //           "ultricies auctor tellus. Donec ut sem in turpis ultrices suscipit ut auctor tellus. "
  //           "Quisque a tincidunt ipsum.",
  //       messageType: "sender"),
  // ];

  sharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in msgs details shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");

    setState(() {
      allChatMessageApi();
    });

  }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarDoubleImageForChats(
          frontImage: 'assets/live_chat_images/back_arrow.png',
          profileImage: 'assets/live_chat_images/user.png',
          title: "Live Chat"),
      backgroundColor: homeBgColor,
      body: loading? Center(child: CircularProgressIndicator(color: borderColor)):
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.78,
              color: Colors.transparent,
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: messageDetailsModelObject.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messageDetailsModelObject[index].senderType == "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messageDetailsModelObject[index].senderType == "receiver"
                                  ? kWhite : borderColor),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: messageDetailsModelObject[index].senderType == "receiver"
                                ? Text(messageDetailsModelObject[index].message!,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: poppinLight,
                                        color: kBlack),
                                    textAlign: TextAlign.left,
                                  )
                                : Text(messageDetailsModelObject[index].message!,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: poppinLight,
                                        color: kWhite),
                                    textAlign: TextAlign.left,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 65,
                child: Row(
                  children: <Widget>[
                    sendMessageTextFields(),
                    const SizedBox(width: 05),
                    FloatingActionButton(
                      onPressed: () async {
                        if(sendMessageFormKey.currentState!.validate()){
                          if (sendMessageController.text.isEmpty) {
                            toastFailedMessage('please type a message', kRed);
                          } else{
                            setState(() {
                              progress = true;
                            });
                            await sendMessageApiWidget();
                            Future.delayed(const Duration(seconds: 3), () {
                              print("sendMessage Success");
                              // toastSuccessMessage("Message sent successfully2.", colorGreen);
                              setState(() {
                                progress = false;
                                sendMessageController.clear();
                              });
                              print("false: $progress");
                            });
                          }
                        }
                      },
                      backgroundColor: borderColor,
                      elevation: 0,
                      child: Image.asset(
                        'assets/live_chat_images/send.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget sendMessageTextFields() {
    return Form(
      key: sendMessageFormKey,
      child: Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 05, vertical: 0),
          decoration: BoxDecoration(color: kWhite,
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
            cursorColor: borderColor,
            textAlign: TextAlign.left,
            controller: sendMessageController,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10, bottom: 3),
                hintText: "Type your message here.....",
                hintStyle: TextStyle(fontSize: 14,
                    fontFamily: poppinLight, color: const Color(0xffD4DCE1)),
                fillColor: kWhite, border: InputBorder.none),
          ),
        ),
      ),
    );
  }

  Map jsonData = {};
  allChatMessageApi() async {
    Map body = {
      "requestType": "getMessages",
      "users_customers_id": userId,
      "other_users_customers_id": "1",
    };
    http.Response response = await http.post(Uri.parse(getUsersChatApiUrl),
        body: body,
        headers: {
          "Accept": "application/json"
        });
    messageDetailsModelObject.clear();
    jsonData = jsonDecode(response.body);
    print("allChatApi: $getAllChatApiUrl");
    print("statusCode: ${response.statusCode}");
    print("responseData: $jsonData");
    if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        var pos = GetMessageDetailsModel();
        pos = GetMessageDetailsModel.fromJson(obj);
        messageDetailsModelObject.add(pos);
      }
      print("allChatLength: ${messageDetailsModelObject.length}");
      setState(() {
        loading = false;
        updateChatApiWidget();
      });
    }
  }

  sendMessageApiWidget() async {
    setState(() {
      loading = true;
    });
    Map body = {
      "requestType": "sendMessage",
      "sender_type": "Users",
      "messageType": "1",
      "users_customers_id": userId,
      "other_users_customers_id": "1",
      "content": sendMessageController.text,
    };
    http.Response response = await http.post(Uri.parse(sendMessageApiUrl),
        body: body,
        headers: {
          "Accept": "application/json"
        });
    Map jsonData = jsonDecode(response.body);
    print("sendMessageApiUrl: $sendMessageApiUrl");
    print("sendMessageText: ${sendMessageController.text}");
    print('sendMessageApiResponse $jsonData');

    if (jsonData['message'] == 'Message sent successfully.') {
      toastSuccessMessage("Message sent successfully1.", colorGreen);
      print('Message sent successfully.');
      setState(() {
        loading = false;
        allChatMessageApi();
      });
    }
  }

  updateChatApiWidget() async {
    // setState(() {
    //   loading = true;
    // });
    Map body = {
      "requestType": "updateMessages",
      "users_customers_id": userId,
      "other_users_customers_id": "1",
    };
    http.Response response = await http.post(Uri.parse(updateMessageApiUrl),
        body: body,
        headers: {
          "Accept": "application/json"
        });
    Map jsonData = jsonDecode(response.body);
    print("updateMessageApiUrl: $updateMessageApiUrl");
    print('updateMessageApiResponse $jsonData');

    if (jsonData['message'] == 'no chat found') {
      // toastSuccessMessage("no chat found", kRed);
      print('no chat found');
      // setState(() {
      //   loading = false;
      // });
    }
    else if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        print(obj['id']);
        var pos = UpdateMessageModel();
        pos = UpdateMessageModel.fromJson(obj);
        updateMessageModelObject.add(pos);
        print("updateMessagesLength: ${updateMessageModelObject.length}");
        // setState(() {
        //   loading = false;
        // });
      }
    }
  }
}

class LiveChatMessage {
  String? messageContent;
  String? messageType;
  LiveChatMessage({@required this.messageContent, @required this.messageType});
}
