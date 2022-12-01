import 'package:flutter/material.dart';

import '../../../Widget/colors.dart';

class MessageDetailsScreen extends StatefulWidget {
  const MessageDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MessageDetailsScreen> createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  List<ChatMessage> messages = [
    ChatMessage(
        messageContent:
        "Phasellus finibus enim nulla, quis ornare odio facilisis eu. "
            "Suspendisse ornare ante sit amet arcu semper, vel eleifend tortor egestas. "
            "Aenean luctus, lorem in hendrerit interdum, leo orci egestas diam, ac euismod "
            "massa est et turpis. Etiam auctor lectus vel neque convallis pharetra. Ut turpis "
            "eros, aliquet non ante id, interdum placerat erat. Curabitur sit amet eros vel orci "
            "venenatis hendrerit. Cras sagittis sagittis sagittis. In hac habitasse platea dictumst. "
            "Phasellus diam erat, porttitor sed ligula at, ultricies auctor tellus. Donec ut sem in "
            "turpis ultrices suscipit ut auctor tellus. Quisque a tincidunt ipsum.",
        messageType: "receiver"),
    ChatMessage(messageContent: "Hi, Mardin", messageType: "sender"),
    ChatMessage(messageContent: "What you want?", messageType: "sender"),
    ChatMessage(messageContent: "Hi, Jeanie", messageType: "receiver"),
    ChatMessage(
        messageContent:
        "Phasellus finibus enim nulla, quis ornare odio facilisis eu. "
            "Suspendisse ornare ante sit amet arcu semper, vel eleifend tortor egestas. "
            "Aenean luctus, lorem in hendrerit interdum, leo orci egestas diam, ac euismod "
            "massa est et turpis. Etiam auctor lectus vel neque convallis pharetra. "
            "Ut turpis eros, aliquet non ante id, interdum placerat erat. Curabitur "
            "sit amet eros vel orci venenatis hendrerit. Cras sagittis sagittis sagittis. "
            "In hac habitasse platea dictumst. Phasellus diam erat, porttitor sed ligula at, "
            "ultricies auctor tellus. Donec ut sem in turpis ultrices suscipit ut auctor tellus. "
            "Quisque a tincidunt ipsum.",
        messageType: "sender"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("clicked");
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/messages_images/Back.png",
                      height: 25,
                      width: 25,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/home_page/user.png",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 05,
                      ),
                      Text(
                        "Jeanie",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins-Bold',
                            color: kBlack),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Container(),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.87,
              color: Colors.transparent,
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: messages.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messages[index].messageType == "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].messageType == "receiver"
                                  ? kWhite
                                  : borderColor),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: messages[index].messageType == "receiver"
                                ? Text(
                              messages[index].messageContent!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins-Light',
                                  color: kBlack),
                              textAlign: TextAlign.left,
                            )
                                : Text(
                              messages[index].messageContent!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins-Light',
                                  color: kWhite),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding:
                      const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      height: 60,
                      // width: double.infinity,
                      // color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 05, vertical: 0),
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextField(
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                    hintText: "Type your message here.....",
                                    hintStyle: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Poppins-Light',
                                        color: Color(0xffD4DCE1)),
                                    fillColor: kWhite,
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          const SizedBox(width: 05),
                          FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: borderColor,
                            elevation: 0,
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
