import 'package:auto_haus_rental_app/Widget/colors.dart';
import 'package:flutter/material.dart';
import '../../../Widget/button.dart';
import '../LoginPage/login_page.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset('assets/live_chat_images/back_arrow.png', color: kWhite,),
                ),
                // GestureDetector(
                //   onTap: (){
                //     Navigator.pop(context);
                //   },
                //   child: Icon(Icons.arrow_back_ios_new_outlined, color: kWhite,),
                //  // child: Image.asset("assets/messages_images/Back.png", color: kWhite,),
                // ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Text("Review Terms of \nService & Privacy Policy",
                  maxLines: 2, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontFamily: 'Poppins-SemiBold', color: kWhite),),
              ],
            ),
          ),

          Container(
            // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
                  "sed diam nonumy eirmod tempor invidunt ut labore et dolore magna "
                  "aliquyam erat, sed diam voluptua. At vero eos et accusam et justo "
                  "duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata "
                  "sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, "
                  "consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt "
                  "ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero "
                  "eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, "
                  "no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor "
                  "sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt "
                  "ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et "
                  "accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea "
                  "takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, "
                  "consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore "
                  "et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et "
                  "justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus "
                  "est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing.\n\n"

                  "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
                  "sed diam nonumy eirmod tempor invidunt ut labore et dolore magna "
                  "aliquyam erat, sed diam voluptua. At vero eos et accusam et justo "
                  "duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata "
                  "sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, "
                  "consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt "
                  "ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero "
                  "eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, "
                  "no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor "
                  "sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt "
                  "ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et "
                  "accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea "
                  "takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, "
                  "consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore "
                  "et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et "
                  "justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus "
                  "est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing."
                , textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Light', color: kWhite),),
            ),
          ),
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
              },
              child: loginButton("Accept", context)),

        ],
      ),

    );
  }
}
