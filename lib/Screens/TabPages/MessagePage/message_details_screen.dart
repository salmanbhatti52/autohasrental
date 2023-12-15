import 'dart:convert';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/tab_page.dart';
import 'package:auto_haus_rental_app/Model/ChatsModels/get_messages_model.dart';
import 'package:auto_haus_rental_app/Model/ChatsModels/send_message_model.dart';
import 'package:auto_haus_rental_app/Model/ChatsModels/update_message_model.dart';

class MessageDetailsScreen extends StatefulWidget {
  final String? carOwnerImage, carOwnerName, carOwnerId;
   MessageDetailsScreen({Key? key, this.carOwnerId,
    this.carOwnerName, this.carOwnerImage}) : super(key: key);

  @override
  State<MessageDetailsScreen> createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  String? userId;

  var sendMessageController = TextEditingController();
  final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
  List<GetMessageDetailsModel> messageDetailsModelObject = [];
  List<GetMessageDetailsModel> newMessageObject = [];
  List<UpdateMessageModel> updateMessageModelObject = [];
  SendMessageModel sendMessageModelObject = SendMessageModel();
  bool loading = true;

  Map jsonData = {};
  getMessageApi() async {
    Map body = {
      "requestType": "getMessages",
      "users_customers_id": userId,
      "other_users_customers_id": carOwnerID1,
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

    if (jsonData['status'] == 'error') {
      print('no chat history');
      setState(() {
        loading = false;
      });
    }
    else if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        var pos = GetMessageDetailsModel();
        pos = GetMessageDetailsModel.fromJson(obj);
        messageDetailsModelObject.add(pos);
      }
      print("allChatLength: ${messageDetailsModelObject.length}");
      loading = false;
      setState(() {

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
      "other_users_customers_id": carOwnerID1,
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
        setState(() {
          getMessageApi();
        });
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
      "other_users_customers_id": carOwnerID1,
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
      // toastSuccessMessage("Message sent successfully1.", colorGreen);
      print('Message sent successfully.');
      setState(() {
        loading = false;
        getMessageApi();
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
      getMessageApi();
    });

  }

  String? carOwnerName1, carOwnerImage1, carOwnerID1;
  // int? carOwnerID1;

  @override
  void initState() {
    super.initState();
    carOwnerName1 = widget.carOwnerName;
    carOwnerImage1 = widget.carOwnerImage;
    carOwnerID1 = widget.carOwnerId;
    print("carOwnerImage1 $carOwnerName1");
    print("carOwnerName1 $carOwnerImage1");
    print("carOwnerId1 $carOwnerID1");
    sharedPrefs();
  }

  bool progress = false;
  @override
  Widget build(BuildContext context) {
    var cron = Cron();
    cron.schedule(Schedule.parse('*/03 * * * * *'), () async {
      print('auto refresh after 03 seconds allChatMessageApi');
      // await getMessageApi();
    });

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            print("clicked");
            // Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>  TabBarPage()));
          },
          child: Padding(
            padding:  EdgeInsets.only(top: 30),
            child: Image.asset('assets/live_chat_images/back_arrow.png',
              height: 25, width: 25),
          ),
        ),
        title: Padding(
          padding:  EdgeInsets.only(top: 20, left: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              carOwnerImage1 == null? ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image.asset('assets/icon/fade_in_image.jpeg')):
              ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: FadeInImage(
                  placeholder:  AssetImage("assets/icon/fade_in_image.jpeg"),
                  fit: BoxFit.fill,
                  height: 25,
                  width: 25,
                  image: NetworkImage("$carOwnerImage1"),
                ),
              ),
               SizedBox(width: 5),
              Text("$carOwnerName1",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16, fontFamily: poppinBold, color: kBlack)),
            ],
          ),
        ),
        backgroundColor: homeBgColor,
        elevation: 0.0,
        centerTitle: true,
        actions: [
          Container(
            color: Colors.transparent, width: 60,
          )
        ],
      ),

      backgroundColor: homeBgColor,
      body: loading? Center(child: CircularProgressIndicator(color: borderColor)):
      // messageDetailsModelObject.isEmpty?  Center(child: Text("no chat history")):
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
                      reverse: true,
                      padding:  EdgeInsets.only(top: 10, bottom: 10),
                      physics:  BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        int reverseIndex = messageDetailsModelObject.length - 1 - index;
                        print(' Time: ${messageDetailsModelObject[reverseIndex].time.toString()}\nDate: ${messageDetailsModelObject[reverseIndex].date.toString()}');
                        return Container(
                          padding:  EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (messageDetailsModelObject[reverseIndex].senderType == "Users"
                                ? Alignment.topRight : Alignment.topLeft),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (messageDetailsModelObject[reverseIndex].senderType == "Users"
                                    ? borderColor : kWhite),
                              ),
                              padding: EdgeInsets.all(10),
                              child: messageDetailsModelObject[reverseIndex].senderType == "Users"
                                  ? Column(
                                    children: [
                                      Text(messageDetailsModelObject[reverseIndex].message.toString(),
                                      maxLines: 3, overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left, style: TextStyle(
                                          fontSize: 14, fontFamily: poppinLight, color: kWhite)),
                                       SizedBox(height: 03),
                                      Text("${messageDetailsModelObject[reverseIndex].time.toString()} ${messageDetailsModelObject[reverseIndex].date.toString()}",
                                        maxLines: 1, overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.right, style: TextStyle(
                                          fontSize: 10, color: kWhite, fontFamily: poppinLight)),
                                    ],
                                  ) :
                              Column(
                                children: [
                                  Text(messageDetailsModelObject[reverseIndex].message.toString(),
                                    maxLines: 3, overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left, style: TextStyle(
                                      fontSize: 14, color: kBlack, fontFamily: poppinLight)),
                                   SizedBox(height: 03),
                                  Text("${messageDetailsModelObject[reverseIndex].time.toString()} ${messageDetailsModelObject[reverseIndex].date.toString()}",
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
                  padding:  EdgeInsets.only(left: 10, bottom: 10, top: 10),
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
                                Future.delayed( Duration(seconds: 3), () {
                                  print("sendMessage Success");
                                  // toastSuccessMessage("Message sent successfully2.", colorGreen);
                                  setState(() {
                                    sendMessageController.clear();
                                    progress = false;

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
          padding: EdgeInsets.symmetric(horizontal: 05, vertical: 0),
          decoration: BoxDecoration(color: kWhite,
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
            cursorColor: borderColor,
            textAlign: TextAlign.left,
            controller: sendMessageController,
            decoration: InputDecoration(
                contentPadding:  EdgeInsets.only(left: 10, bottom: 3),
                hintText: "Type your message here.....",
                hintStyle: TextStyle(fontSize: 14,
                    fontFamily: poppinLight, color: Color(0xffD4DCE1)),
                fillColor: kWhite, border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
