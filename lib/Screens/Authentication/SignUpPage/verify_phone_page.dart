import 'dart:async';
import 'package:auto_haus_rental_app/Widget/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../Widget/button.dart';
import '../../../Widget/fontFamily.dart';
import '../LoginPage/login_page.dart';

class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage({Key? key}) : super(key: key);

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {

  bool checkBoxValue = false;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController textEditingController = TextEditingController();

  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text("Verify Phone", textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Bold', color: kWhite),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.12),
              SvgPicture.asset('assets/splash/login_image.svg', fit: BoxFit.fill,),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text("We sent you an SMS with a 6 digit code. Enter the code to verify your mobile.",
                 textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins-Regular', color: kWhite,),),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      textStyle: TextStyle(color: borderColor),
                      pastedTextStyle: TextStyle(
                        color: borderColor,
                        fontWeight: FontWeight.bold,
                        // backgroundColor: Colors.transparent,
                      ),
                      length: 6,
                      // obscureText: true,
                      hintStyle: TextStyle(color: textLabelColor, fontFamily: 'Poppins-Regular'),
                      hintCharacter: "0",
                      // obscuringCharacter: '*',
                      // obscuringWidget: const FlutterLogo(
                      //   size: 24,
                      // ),
                      // blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 3) {
                          return "I'm from validator";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(50),
                        fieldHeight: 40,
                        fieldWidth: 40,
                        selectedFillColor: Colors.purple,
                        activeFillColor: homeBgColor,
                        activeColor: borderColor,
                        selectedColor: borderColor,
                        inactiveColor: homeBgColor,
                      ),
                      cursorColor: kWhite,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: false,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.04),

              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                  },
                  child: loginButton("Next", context)),

              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/timer.png",),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    const Text(" Expire on 02:00",
                    style: TextStyle(color: Color(0xffFF6666), fontSize: 12, fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins-Medium',),),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Text("Resend Code (4)",
                    style: TextStyle(color: borderColor, fontSize: 16, fontFamily: 'Poppins-SemiBold', fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
