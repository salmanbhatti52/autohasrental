import 'dart:async';
import 'dart:convert';
import 'package:auto_haus_rental_app/Model/LiveChat/get_admin_list_model.dart';
import 'package:auto_haus_rental_app/Model/LiveChat/get_live_msg_model.dart';
import 'package:auto_haus_rental_app/Model/LiveChat/send_live_msg_model.dart';
import 'package:auto_haus_rental_app/Model/LiveChat/update_live_msg_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

class LiveChatDetailsPage extends StatefulWidget {
  final int? adminId;
 LiveChatDetailsPage({super.key, this.adminId});

  @override
  State<LiveChatDetailsPage> createState() => _LiveChatDetailsPageState();
}

class _LiveChatDetailsPageState extends State<LiveChatDetailsPage> {

  final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
  var sendMessageController = TextEditingController();
  GetLiveMessagesModel getLiveMessagesModel = GetLiveMessagesModel();
  ScrollController _scrollController = ScrollController();
  SendLiveMessagesModel sendLiveMessagesModel = SendLiveMessagesModel();
  bool loading = true;

  // Declare a timer variable
  Timer? timer;

  void startTimer() {
    // Start the timer and call getMessageApi() every 1 second
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      allLiveChatApiWidget();
    });
  }

  void cancelTimer() {
    // Cancel the timer if it's active
    timer?.cancel();
  }

// Call this function when the user enters the page
  void onPageEnter() {
    // Start the timer to call getMessageApi() every 1 second
    startTimer();
  }

// Call this function when the user leaves the page
  void onPageExit() {
    // Cancel the timer to stop calling getMessageApi()
    cancelTimer();
  }


  sharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    allLiveChatApiWidget();
  }

  void scrollToBottom() {
    final bottomOffset = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    onPageExit();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
    onPageEnter();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          systemOverlayStyle:SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, // <-- SEE HERE
            statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
            statusBarBrightness:
            Brightness.dark, //<-- For iOS SEE HERE (dark icons)
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding:EdgeInsets.only(top: 30),
              child: Image.asset("assets/live_chat_images/back_arrow.png",
                height: 25, width: 25,
              ),
            ),
          ),
          title: Padding(
            padding:EdgeInsets.only(top: 30),
            child: Text("Live Chat",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, fontFamily: poppinBold, color: kBlack)),
          ),
          backgroundColor: homeBgColor,
          elevation: 0.0,
          centerTitle: true,
        ),
      backgroundColor: homeBgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                getLiveMessagesModel.data != null
                    ? Container(
                  height: MediaQuery.of(context).size.height * 0.78,
                  color: Colors.transparent,
                  child:  Stack(
                    children: [
                   ListView.builder(
                        itemCount: getLiveMessagesModel.data?.length,
                     controller: _scrollController,
                        reverse: true,
                        padding:EdgeInsets.only(top: 10, bottom: 10),
                        physics:BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          int reverseIndex = getLiveMessagesModel.data!.length - 1 - index;
                          return getLiveMessagesModel.data!.isEmpty
                              ? Center(child: Text("no chat history"),)
                              : Container(
                            padding:EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                            child: Align(
                              alignment: (getLiveMessagesModel.data?[reverseIndex].senderType == "Users"
                                  ? Alignment.topRight : Alignment.topLeft),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (getLiveMessagesModel.data?[reverseIndex].senderType == "Users"
                                      ? borderColor : kWhite),
                                ),
                                padding:EdgeInsets.all(10),
                                child: getLiveMessagesModel.data?[reverseIndex].senderType == "Users"
                                    ? Column(
                                  children: [
                                    Text("${getLiveMessagesModel.data?[reverseIndex].message.toString()}",
                                        maxLines: 3, overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left, style: TextStyle(
                                            fontSize: 14, fontFamily: poppinLight, color: kWhite)),
                                   SizedBox(height: 03),
                                    Text("${getLiveMessagesModel.data?[reverseIndex].time.toString()} ${getLiveMessagesModel.data?[reverseIndex].date.toString()}",
                                        maxLines: 1, overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left, style: TextStyle(
                                            fontSize: 10, color: kWhite, fontFamily: poppinLight)),
                                  ],
                                ) :
                                Column(
                                  children: [
                                    Text("${getLiveMessagesModel.data?[reverseIndex].message.toString()}",
                                        maxLines: 3, overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left, style: TextStyle(
                                            fontSize: 14, color: kBlack, fontFamily: poppinLight)),
                                   SizedBox(height: 03),
                                    Text("${getLiveMessagesModel.data?[reverseIndex].time.toString()} ${getLiveMessagesModel.data?[reverseIndex].date.toString()}",
                                        maxLines: 1, overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left, style: TextStyle(
                                            fontSize: 10, color: kBlack, fontFamily: poppinLight)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )  : Container(
                  height: MediaQuery.of(context).size.height * 0.78,
        ),

                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding:EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 65,
                    child: Row(
                      children: <Widget>[
                        sendMessageTextFields(),
                       SizedBox(width: 05),
                        FloatingActionButton(
                          onPressed: () async {
                            final currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus &&
                                currentFocus.focusedChild != null) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                            if(sendMessageFormKey.currentState!.validate()){
                              if (sendMessageController.text.isEmpty) {
                                toastFailedMessage('please type a message', kRed);
                              } else{
                                setState(() {
                                  loading = true;
                                });
                                await sendMessageApiWidget();
                                Future.delayed(Duration(seconds: 3), () {
                                  print("sendMessage Success");
                                  // toastSuccessMessage("Message sent successfully2.", colorGreen);
                                  setState(() {
                                    loading = false;
                                  });
                                  print("false: $loading");
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
        ),
      ),
    );
  }
  Widget sendMessageTextFields() {
    return Form(
      key: sendMessageFormKey,
      child: Expanded(
        child: Container(
          padding:EdgeInsets.symmetric(horizontal: 05, vertical: 0),
          decoration: BoxDecoration(color: kWhite,
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
            cursorColor: borderColor,
            textAlign: TextAlign.left,
            controller: sendMessageController,
            decoration: InputDecoration(
                contentPadding:EdgeInsets.only(left: 10, bottom: 3),
                hintText: "Type your message here.....",
                hintStyle: TextStyle(fontSize: 14,
                    fontFamily: poppinLight, color:Color(0xffD4DCE1)),
                fillColor: kWhite, border: InputBorder.none),
          ),
        ),
      ),
    );
  }

  allLiveChatApiWidget() async {
    // setState(() {
    //   loading = true;
    // });
    Map body = {
      "requestType": "getMessages",
      "users_customers_id": userId,
      "other_users_customers_id": "${widget.adminId}",
    };
    http.Response response = await http.post(Uri.parse(getLiveMsgApiUrl),
        body: body,
        headers: {
          "Accept": "application/json"
        });
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("getLiveMsgApiUrl: ${getLiveMsgApiUrl}");
      print("getLiveChatResponse: ${responseString.toString()}");
      getLiveMessagesModel = getLiveMessagesModelFromJson(responseString);
      print("getLiveChatLength: ${getLiveMessagesModel.data?.length}");
      setState(() {
        loading = false;
      });
    }
      // setState(() {
      //   loading = false;
      // });
  }

  sendMessageApiWidget() async {
    setState(() {
      loading = true;
    });
    // try {
      String apiUrl = sendLiveMsgApiUrl;
      print("sendLiveMsgApiUrl $sendLiveMsgApiUrl");
      print("sendLiveMsgText ${sendMessageController.text}");
      final response = await http.post(Uri.parse(apiUrl),
        body: {
          "requestType": "sendMessage",
          "sender_type": "Users",
          "users_customers_id": userId,
          "other_users_customers_id": "${widget.adminId}",
          "content": sendMessageController.text,
          "messageType": "1",
        },
        headers: {
        'Accept': 'application/json'
        },
      );
      print('statusCodeSendMessage ${response.statusCode}');

      if (response.statusCode == 200) {
        sendMessageController.clear();
        final responseString = response.body;
        print("sendMessageResponse: ${responseString.toString()}");
        sendLiveMessagesModel = sendLiveMessagesModelFromJson(responseString);
        print("sendMessage: ${sendLiveMessagesModel.message}");
      }
    setState(() {
      loading = false;
      allLiveChatApiWidget();
    });
  }

}
