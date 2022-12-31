import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:flutter/material.dart';
import '../../../../../../Utils/colors.dart';
import '../../../../../../Utils/fontFamily.dart';

class LiveChatPage2 extends StatefulWidget {
  const LiveChatPage2({super.key});

  @override
  State<LiveChatPage2> createState() => _LiveChatPage2State();
}

class _LiveChatPage2State extends State<LiveChatPage2> {
  List<LiveChatMessage> messages = [
    LiveChatMessage(
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
    LiveChatMessage(messageContent: "Hi, Mardin", messageType: "sender"),
    LiveChatMessage(messageContent: "What you want?", messageType: "sender"),
    LiveChatMessage(messageContent: "Hi, Jeanie", messageType: "receiver"),
    LiveChatMessage(
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
    LiveChatMessage(
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
    LiveChatMessage(messageContent: "Hi, Mardin", messageType: "sender"),
    LiveChatMessage(messageContent: "What you want?", messageType: "sender"),
    LiveChatMessage(messageContent: "Hi, Jeanie", messageType: "receiver"),
    LiveChatMessage(
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
      appBar: const MyAppBarDoubleImageForChats(
          frontImage: 'assets/live_chat_images/back_arrow.png',
          profileImage: 'assets/live_chat_images/user.png',
          title: "Live Chat"),
      backgroundColor: homeBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.78,
              color: Colors.transparent,
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: messages.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    physics: const BouncingScrollPhysics(),
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
                                        fontFamily: poppinLight,
                                        color: kBlack),
                                    textAlign: TextAlign.left,
                                  )
                                : Text(
                                    messages[index].messageContent!,
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
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 05, vertical: 0),
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextField(
                          cursorColor: borderColor,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(left: 10, bottom: 3),
                              hintText: "Type your message here.....",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: poppinLight,
                                  color: const Color(0xffD4DCE1)),
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
      // body: Column(
      //   children: [
      //     const SizedBox(height: 60),
      //     Container(
      //       width: MediaQuery.of(context).size.width * 0.8,
      //       height: MediaQuery.of(context).size.height * 0.11,
      //       decoration: BoxDecoration(
      //         color: const Color(0xfffbfbfb),
      //         borderRadius: BorderRadius.circular(20),
      //       ),
      //       child: Padding(
      //         padding: const EdgeInsets.all(10),
      //         child: Text(
      //           "Phasellus finibus enim nulla, quis ornare odio facilisis eu. Suspendisse ornare ante sit amet arcu semper, vel eleifend tortor egestas. Aenean luctus, lorem in hendrerit interdum, leo orci egestas diam, ac euismod massa est et turpis. Etiam auctor lectus vel neque convallis pharetra. Ut turpis eros, aliquet non ante id, interdum placerat erat. Curabitur sit amet eros vel orci venenatis hendrerit. Cras sagittis sagittis sagittis. In hac habitasse platea dictumst. Phasellus diam erat, porttitor sed ligula at, ultricies auctor tellus. Donec ut sem in turpis ultrices suscipit ut auctor tellus. Quisque a tincidunt ipsum.",
      //           style: TextStyle(
      //               fontSize: 14, fontFamily: poppinLight, color: kBlack),
      //           textAlign: TextAlign.left,
      //         ),
      //       ),
      //     ),
      //     const SizedBox(height: 15),
      //     Text(
      //       "09:41 AM",
      //       style: TextStyle(
      //           fontSize: 12,
      //           fontFamily: poppinLight,
      //           color: detailsTextColor),
      //       textAlign: TextAlign.left,
      //     ),
      //     const SizedBox(height: 30),
      //     Padding(
      //       padding: const EdgeInsets.only(right: 70),
      //       child: Align(
      //         alignment: Alignment.centerRight,
      //         child: Container(
      //           width: MediaQuery.of(context).size.width * 0.3,
      //           height: 40,
      //           decoration: BoxDecoration(
      //             color: borderColor,
      //             borderRadius: BorderRadius.circular(30),
      //           ),
      //           child: Center(
      //             child: Text(
      //               "Hi, Mardin",
      //               style: TextStyle(
      //                   fontSize: 14,
      //                   fontFamily: poppinLight,
      //                   color: kWhite),
      //               textAlign: TextAlign.left,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     const SizedBox(height: 15),
      //     Padding(
      //       padding: const EdgeInsets.only(right: 70),
      //       child: Align(
      //         alignment: Alignment.centerRight,
      //         child: Container(
      //           width: 159,
      //           height: 40,
      //           decoration: BoxDecoration(
      //             color: borderColor,
      //             borderRadius: BorderRadius.circular(30),
      //           ),
      //           child: Center(
      //             child: Text(
      //               "What you want?",
      //               style: TextStyle(
      //                   fontSize: 14,
      //                   fontFamily: poppinLight,
      //                   color: kWhite),
      //               textAlign: TextAlign.left,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     const SizedBox(height: 30),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 70),
      //       child: Align(
      //         alignment: Alignment.centerLeft,
      //         child: Text(
      //           "Hi, Jeanie",
      //           style: TextStyle(
      //               fontSize: 14, fontFamily: poppinLight, color: kBlack),
      //           textAlign: TextAlign.left,
      //         ),
      //       ),
      //     ),
      //     const SizedBox(height: 30),
      //     Padding(
      //       padding: const EdgeInsets.only(right: 25),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           Container(
      //             width: 246,
      //             height: 110,
      //             decoration: BoxDecoration(
      //               color: borderColor,
      //               borderRadius: BorderRadius.circular(20),
      //             ),
      //             child: Padding(
      //               padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      //               child: Text(
      //                 "Phasellus finibus enim nulla, quis ornare odio facilisis eu. Suspendisse ornare ante sit amet arcu semper, vel eleifend tortor egestas. Aenean luctus, lorem in hendrerit interdum, leo orci egestas diam, ac euismod massa est et turpis. Etiam auctor lectus vel neque convallis pharetra. Ut turpis eros, aliquet non ante id, interdum placerat erat. Curabitur sit amet eros vel orci venenatis hendrerit. Cras sagittis sagittis sagittis. In hac habitasse platea dictumst. Phasellus diam erat, porttitor sed ligula at, ultricies auctor tellus. Donec ut sem in turpis ultrices suscipit ut auctor tellus. Quisque a tincidunt ipsum.",
      //                 style: TextStyle(
      //                     fontSize: 14,
      //                     fontFamily: poppinLight,
      //                     color: kWhite),
      //                 textAlign: TextAlign.left,
      //               ),
      //             ),
      //           ),
      //           const SizedBox(width: 10),
      //           Padding(
      //             padding: const EdgeInsets.only(top: 80),
      //             child: Image.asset('assets/live_chat_images/user.png',
      //                 width: 24, height: 24),
      //           ),
      //         ],
      //       ),
      //     ),
      //     const SizedBox(height: 90),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         SizedBox(
      //           width: 295,
      //           height: 45,
      //           child: TextField(
      //             textAlign: TextAlign.left,
      //             decoration: InputDecoration(
      //               hintText: "Type your message here.....",
      //               hintStyle: const TextStyle(
      //                 fontSize: 14,
      //                 fontFamily: poppinLight,
      //                 color: Color(0xffd4dce1),
      //               ),
      //               fillColor: const Color(0xfffbfbfb),
      //               filled: true,
      //               contentPadding: const EdgeInsets.all(10),
      //               enabledBorder: OutlineInputBorder(
      //                 borderSide: BorderSide.none,
      //                 borderRadius: BorderRadius.circular(30),
      //               ),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(width: 8),
      //         SizedBox(
      //           width: 55,
      //           height: 60,
      //           child: FittedBox(
      //             child: FloatingActionButton(
      //                 onPressed: () {},
      //                 backgroundColor: borderColor,
      //                 elevation: 0,
      //                 child: Image.asset('assets/live_chat_images/send.png')),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}

class LiveChatMessage {
  String? messageContent;
  String? messageType;
  LiveChatMessage({@required this.messageContent, @required this.messageType});
}
