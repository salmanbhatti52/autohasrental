import 'dart:convert';
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
  final String? adminImage;
 LiveChatDetailsPage({super.key, this.adminId, this.adminImage});

  @override
  State<LiveChatDetailsPage> createState() => _LiveChatDetailsPageState();
}

class _LiveChatDetailsPageState extends State<LiveChatDetailsPage> {

  final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
  var sendMessageController = TextEditingController();
  GetLiveMessagesModel getLiveMessagesModel = GetLiveMessagesModel();
  List<UpdateLiveMessagesModel> updateMessageModelObject = [];
  bool progress = false;
  SendLiveMessagesModel sendLiveMessagesModel = SendLiveMessagesModel();
  bool loading = true;
  String? adminImage;

  sharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in msgs details shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");
    print("adminId ${widget.adminId}");
    adminImage = "$baseUrlImage${widget.adminImage}";
    print("adminImage $adminImage");

    setState(() {
      allLiveChatApiWidget();
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
              print("clicked");
              Navigator.pop(context);
            },
            child: Padding(
              padding:EdgeInsets.only(top: 30),
              child: Image.asset("assets/live_chat_images/back_arrow.png",
                height: 25, width: 25),
            ),
          ),
          title: Padding(
            padding:EdgeInsets.only(top: 30, left: 50),
            child: Row(
              children: [
                // Image.asset(profileImage!, width: 24, height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: "$adminImage",
                    height: 25, width: 25,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(strokeWidth: 2, value: downloadProgress.progress, color: borderColor,),
                    errorWidget: (context, url, error) => Image.asset("assets/icon/fade_in_image.jpeg"),
                  ),
                ),
               SizedBox(width: 5),
                Text("Live Chat",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20, fontFamily: poppinBold, color: kBlack)),
              ],
            ),
          ),
          backgroundColor: homeBgColor,
          elevation: 0.0,
          centerTitle: true,
        ),
      backgroundColor: homeBgColor,
      body: loading? Center(child: CircularProgressIndicator(color: borderColor)):
      // getLiveMessagesModel.status == "error"?Text("no chat history"):
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.78,
              color: Colors.transparent,
              child: Stack(
                children: [
               getLiveMessagesModel.status == "error"?Center(child: Text("no chat history")):
                  ListView.builder(
                    itemCount: getLiveMessagesModel.data?.length,
                    shrinkWrap: true,
                    padding:EdgeInsets.only(top: 10, bottom: 10),
                    physics:BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding:EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (getLiveMessagesModel.data?[index].senderType == "Users"
                              ? Alignment.topRight : Alignment.topLeft),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (getLiveMessagesModel.data?[index].senderType == "Users"
                                  ? borderColor : kWhite),
                            ),
                            padding:EdgeInsets.all(10),
                            child: getLiveMessagesModel.data?[index].senderType == "Users"
                                ? Column(
                              children: [
                                Text("${getLiveMessagesModel.data?[index].message.toString()}",
                                    maxLines: 3, overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left, style: TextStyle(
                                        fontSize: 14, fontFamily: poppinLight, color: kWhite)),
                               SizedBox(height: 03),
                                Text("${getLiveMessagesModel.data?[index].time.toString()} ${getLiveMessagesModel.data?[index].date.toString()}",
                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left, style: TextStyle(
                                        fontSize: 10, color: kWhite, fontFamily: poppinLight)),
                              ],
                            ) :
                            Column(
                              children: [
                                Text("${getLiveMessagesModel.data?[index].message.toString()}",
                                    maxLines: 3, overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left, style: TextStyle(
                                        fontSize: 14, color: kBlack, fontFamily: poppinLight)),
                               SizedBox(height: 03),
                                Text("${getLiveMessagesModel.data?[index].time.toString()} ${getLiveMessagesModel.data?[index].date.toString()}",
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
                        if(sendMessageFormKey.currentState!.validate()){
                          if (sendMessageController.text.isEmpty) {
                            toastFailedMessage('please type a message', kRed);
                          } else{
                            setState(() {
                              progress = true;
                            });
                            await sendMessageApiWidget();
                            Future.delayed(Duration(seconds: 3), () {
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
    setState(() {
      loading = true;
    });
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
      setState(() {
        loading = false;
        updateChatApiWidget();
      });
  }

  sendMessageApiWidget() async {
    loading = true;
    setState(() {});
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
        final responseString = response.body;
        print("sendMessageResponse: ${responseString.toString()}");
        sendLiveMessagesModel = sendLiveMessagesModelFromJson(responseString);
        print("sendMessage: ${sendLiveMessagesModel.message}");
      }
    // } catch (e) {
    //   print('Error in  "messageType": "1",: ${e.toString()}');
    // }
    setState(() {
      loading = false;
      allLiveChatApiWidget();
    });
  }

  updateChatApiWidget() async {
    // setState(() {
    //   loading = true;
    // });
    Map body = {
      "requestType": "updateMessages",
      "users_customers_id": userId,
      "other_users_customers_id": "${widget.adminId}",
    };
    http.Response response = await http.post(Uri.parse(updateLiveMsgApiUrl),
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
        var pos = UpdateLiveMessagesModel();
        pos = UpdateLiveMessagesModel.fromJson(obj);
        updateMessageModelObject.add(pos);
        print("updateLiveMessagesLength: ${updateMessageModelObject.length}");
        // setState(() {
        //   loading = false;
        // });
      }
    }
  }
}
