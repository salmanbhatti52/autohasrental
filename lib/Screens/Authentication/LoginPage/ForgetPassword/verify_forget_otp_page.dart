import 'dart:async';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'set_new_password_page.dart';

class VerifyForgetOTPPage extends StatefulWidget {
  final String? email, verifyCode;
  VerifyForgetOTPPage({Key? key, this.email, this.verifyCode})
      : super(key: key);

  @override
  State<VerifyForgetOTPPage> createState() => _VerifyForgetOTPPageState();
}

class _VerifyForgetOTPPageState extends State<VerifyForgetOTPPage> {
  bool checkBoxValue = false;
  String currentText = "";
  final formKeyVerifyCode = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  var textEditingController = TextEditingController();

  final focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("object123 $userId ${widget.verifyCode}");
  }

  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: ModalProgressHUD(
        inAsyncCall: progress,
        opacity: 0.02,
        blur: 0.5,
        color: Colors.transparent,
        progressIndicator: CircularProgressIndicator(
          color: borderColor,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Text("Verify Email", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,
                      fontFamily: poppinBold, color: kWhite)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                SvgPicture.asset('assets/splash/login_image.svg',
                    fit: BoxFit.fill),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "We sent you an email with a 4 digit code. Enter the code to change your password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16,
                      fontFamily: poppinRegular,
                      color: kWhite)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Form(
                  key: formKeyVerifyCode,
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 80),
                      child: PinCodeTextField(
                        appContext: context,
                        textStyle: TextStyle(color: borderColor),
                        pastedTextStyle: TextStyle(
                          color: borderColor, fontWeight: FontWeight.bold),
                        length: 4,
                        hintStyle: TextStyle(color: textLabelColor, fontFamily: poppinRegular),
                        hintCharacter: "0",
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 3) {
                            return "Please Input OTP";
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
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: false,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        boxShadows: [
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
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                GestureDetector(
                    onTap: () async {
                      if (formKeyVerifyCode.currentState!.validate()) {
                        if (textEditingController.text.isEmpty) {
                          toastFailedMessage('pinController cannot be empty', Colors.red);
                        } else if (textEditingController.text != widget.verifyCode) {
                          toastFailedMessage('pin code did not matched', Colors.red);
                        } else {
                          setState(() {
                            progress = true;
                          });

                         // await verifyOTP();

                          Future.delayed(Duration(seconds: 1), () {
                            toastSuccessMessage("success", Colors.green);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => SetNewPasswordPage(
                                  email: widget.email,
                                  verifyCode: widget.verifyCode,
                                )));
                            print("email & verifyCode ${widget.email} ${widget.verifyCode}");

                            setState(() {
                              progress = false;
                            });
                            print("false: $progress");
                          });
                        }
                      }
                    },
                    child: loginButton("Next", context)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/intro_images/timer.png"),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Text(" Expire on 02:00",
                        style: TextStyle(color: Color(0xffFF6666),
                          fontSize: 12, fontFamily: poppinMedium)),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Text("Resend Code (4)", style: TextStyle(color: borderColor,
                            fontSize: 16, fontFamily: poppinSemiBold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
