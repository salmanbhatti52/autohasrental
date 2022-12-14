import 'dart:convert';
import 'package:auto_haus_rental_app/Screens/TabPages/MessagePage/message_page.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/ChatsModels/messages_details_model.dart';
import '../../../Model/ChatsModels/send_message_model.dart';
import '../../../Model/ChatsModels/update_message_model.dart';
import '../MyAppBarHeader/app_bar_header.dart';
import 'package:http/http.dart'as http;

class MessageDetailsScreen extends StatefulWidget {
  final String? senderImage, senderName;
  const MessageDetailsScreen({Key? key, this.senderName, this.senderImage}) : super(key: key);

  @override
  State<MessageDetailsScreen> createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  String? userId;

  var sendMessageController = TextEditingController();
  final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
  List<MessageDetailsModel> messageDetailsModelObject = [];
  List<MessageDetailsModel> newMessageObject = [];
  List<UpdateMessageModel> updateMessageModelObject = [];
  SendMessageModel sendMessageModelObject = SendMessageModel();
  bool loading = true;

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
        var pos = MessageDetailsModel();
        pos = MessageDetailsModel.fromJson(obj);
        messageDetailsModelObject.add(pos);
      }
      print("allChatLength: ${messageDetailsModelObject.length}");
      setState(() {
        loading = false;
        updateChatApiWidget();
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

  bool progress = false;
  @override
  Widget build(BuildContext context) {
    var cron = Cron();
    cron.schedule(Schedule.parse('*/60 * * * * *'), () async {
      print('auto refresh after 10 seconds allChatMessageApi');
      allChatMessageApi();
    });

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            print("clicked");
            // Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const MessagePage()));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Image.asset('assets/live_chat_images/back_arrow.png',
              height: 25, width: 25),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 30, left: 50),
          child: Row(
            children: [
              widget.senderImage == null? ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image.asset('assets/icon/fade_in_image.jpeg')):
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: FadeInImage(
                  placeholder: const AssetImage("assets/icon/fade_in_image.jpeg"),
                  fit: BoxFit.fill,
                  height: 27,
                  width: 27,
                  image: NetworkImage("${widget.senderImage}"),
                ),
              ),
              const SizedBox(width: 5),
              Text("${widget.senderName}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16, fontFamily: poppinBold, color: kBlack)),
            ],
          ),
        ),
        backgroundColor: homeBgColor,
        elevation: 0.0,
        centerTitle: true,
      ),

      // appBar: const MyAppBarDoubleImageForChats(
      //     frontImage: 'assets/live_chat_images/back_arrow.png',
      //     profileImage: 'assets/live_chat_images/user.png',
      //     title: "name"),
      backgroundColor: homeBgColor,
      body: loading? Center(child: CircularProgressIndicator(color: borderColor)):
      messageDetailsModelObject.isEmpty? const Center(child: Text("no chat history")):
          ModalProgressHUD(
            inAsyncCall: progress,
            opacity: 0.02,
            blur: 0.5,
            color: Colors.transparent,
            progressIndicator: CircularProgressIndicator(color: borderColor),
            child: SingleChildScrollView(
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
                          padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (messageDetailsModelObject[index].senderType == "Users"
                                ? Alignment.topRight : Alignment.topLeft),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (messageDetailsModelObject[index].senderType == "Users"
                                    ? borderColor : kWhite),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: messageDetailsModelObject[index].senderType == "Users"
                                  ? Text(messageDetailsModelObject[index].message.toString(),
                                      maxLines: 3, overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14,
                                          fontFamily: poppinLight, color: kWhite),
                                      textAlign: TextAlign.left,
                                    )
                                  : Text(messageDetailsModelObject[index].message.toString(),
                                      maxLines: 3, overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14, color: kBlack,
                                          fontFamily: poppinLight,), textAlign: TextAlign.left,),
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
                        child: Image.asset('assets/live_chat_images/send.png',
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
}

class ChatMessage {
  String? messageContent;
  String? messageType;
  ChatMessage({@required this.messageContent, @required this.messageType});
}
