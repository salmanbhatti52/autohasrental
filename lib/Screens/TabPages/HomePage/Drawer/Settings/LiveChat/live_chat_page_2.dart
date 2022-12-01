import 'package:auto_haus_rental_app/Widget/fontFamily.dart';
import 'package:flutter/material.dart';
import '../../../../../../Widget/colors.dart';

class LiveChatPage2 extends StatefulWidget {
  const LiveChatPage2({super.key});

  @override
  State<LiveChatPage2> createState() => _LiveChatPage2State();
}

class _LiveChatPage2State extends State<LiveChatPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: homeBgColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset('assets/live_chat_images/back_arrow.png',
                      width: 20, height: 20),
                ),
                const SizedBox(width: 105),
                Image.asset('assets/live_chat_images/user.png',
                    width: 24, height: 24),
                const SizedBox(width: 5),
                Text(
                  "Live Chat",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: poppinBold,
                      color: appBgColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          Container(
            width: 271,
            height: 110,
            decoration: BoxDecoration(
              color: const Color(0xfffbfbfb),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Phasellus finibus enim nulla, quis ornare odio facilisis eu. Suspendisse ornare ante sit amet arcu semper, vel eleifend tortor egestas. Aenean luctus, lorem in hendrerit interdum, leo orci egestas diam, ac euismod massa est et turpis. Etiam auctor lectus vel neque convallis pharetra. Ut turpis eros, aliquet non ante id, interdum placerat erat. Curabitur sit amet eros vel orci venenatis hendrerit. Cras sagittis sagittis sagittis. In hac habitasse platea dictumst. Phasellus diam erat, porttitor sed ligula at, ultricies auctor tellus. Donec ut sem in turpis ultrices suscipit ut auctor tellus. Quisque a tincidunt ipsum.",
                style: TextStyle(
                    fontSize: 14, fontFamily: 'Poppins-Light', color: kBlack),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "09:41 AM",
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins-Light',
                color: detailsTextColor),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(right: 70),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 109,
                height: 40,
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "Hi, Mardin",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins-Light',
                        color: kWhite),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(right: 70),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 159,
                height: 40,
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "What you want?",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins-Light',
                        color: kWhite),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hi, Jeanie",
                style: TextStyle(
                    fontSize: 14, fontFamily: 'Poppins-Light', color: kBlack),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 246,
                  height: 110,
                  decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      "Phasellus finibus enim nulla, quis ornare odio facilisis eu. Suspendisse ornare ante sit amet arcu semper, vel eleifend tortor egestas. Aenean luctus, lorem in hendrerit interdum, leo orci egestas diam, ac euismod massa est et turpis. Etiam auctor lectus vel neque convallis pharetra. Ut turpis eros, aliquet non ante id, interdum placerat erat. Curabitur sit amet eros vel orci venenatis hendrerit. Cras sagittis sagittis sagittis. In hac habitasse platea dictumst. Phasellus diam erat, porttitor sed ligula at, ultricies auctor tellus. Donec ut sem in turpis ultrices suscipit ut auctor tellus. Quisque a tincidunt ipsum.",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins-Light',
                          color: kWhite),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Image.asset('assets/live_chat_images/user.png',
                      width: 24, height: 24),
                ),
              ],
            ),
          ),
          const SizedBox(height: 90),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 295,
                height: 45,
                child: TextField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: "Type your message here.....",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins-Light',
                      color: Color(0xffd4dce1),
                    ),
                    fillColor: const Color(0xfffbfbfb),
                    filled: true,
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 55,
                height: 60,
                child: FittedBox(
                  child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: borderColor,
                      elevation: 0,
                      child: Image.asset('assets/live_chat_images/send.png')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
