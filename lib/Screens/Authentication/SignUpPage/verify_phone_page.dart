import 'dart:async';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import '../../../Model/AuthModels/verify_otp_model.dart';
import '../../../Model/resendOTP.dart';
import 'privacy_policy_page.dart';

class VerifyPhonePage extends StatefulWidget {
  final String? userId, email, verifyCode;
  VerifyPhonePage({Key? key, this.email , this.userId, this.verifyCode})
      : super(key: key);

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  bool checkBoxValue = false;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentText = "";
  final formKeyVerifyCode = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  var textEditingController = TextEditingController();

  final focusNode = FocusNode();

  Timer? timer;
  int secondsRemaining = 120;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  String getTimerText() {
    int minutes = secondsRemaining ~/ 60;
    int seconds = secondsRemaining % 60;
    return '${minutes}m:${seconds.toString().padLeft(2, '0')}s';
  }
  ResendOtp resendOtP = ResendOtp();

  resendOtp() async {
    try {
      String apiUrl = resendOtpSignUpApiUrl;
      print("emaillll: ${widget.email}");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Accept': 'application/json'},
        body: {
          'email': widget.email,
        },
      );
      final responseString = response.body;
      print("response String: $responseString");
      if (response.statusCode == 200) {
        print("resS $responseString");
        resendOtP = resendOtpFromJson(responseString);
          setState(() {});
          print('verifyModel status: ${resendOtP.status}');
          print('Code: ${resendOtP.data?.verifyCode}');
          toastSuccessMessage("OTP has been sent successfully.", colorGreen);
        otpCodes();
      }
    } catch (e) {
      print('verify error in catch = ${e.toString()}');
      return null;
    }
  }
  String? selectedVerifyCode;

  otpCodes() {
    if (resendOtP.data?.verifyCode != null) {
       selectedVerifyCode = resendOtP.data!.verifyCode.toString();
    } else if (widget.verifyCode != null) {
      selectedVerifyCode = widget.verifyCode;
    }else if( widget.verifyCode != null && resendOtP.data?.verifyCode != null) {
      selectedVerifyCode = resendOtP.data!.verifyCode.toString();
    } else{
      print("error");
    }
  }
  @override
  void initState() {
    super.initState();
    startTimer();
    otpCodes();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }


  VerifyOtpModel verifyOtpModel = VerifyOtpModel();

  verifyOTP() async {
    try {
      String apiUrl = verifyOtpSignUpApiUrl;
      print("api: $apiUrl");
      print("users_customers_id: ${widget.userId}");
      print("users_customers_id: ${widget.verifyCode}");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Accept': 'application/json'},
        body: {
          'users_customers_id': widget.userId,
          'verify_otp': textEditingController.text,
        },
      );
      final responseString = response.body;
      print("response String: $responseString");

      print("status Code verify: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("in 200 signUp");
        print("resS $responseString");
        if (responseString != 'false') {
          verifyOtpModel = verifyOtpModelFromJson(responseString);
          setState(() {});
          print('verifyModel status: ${verifyOtpModel.status}');
          toastSuccessMessage("${verifyOtpModel.message}", Colors.green);
        }
      }
    } catch (e) {
      print('verify error in catch = ${e.toString()}');
      return null;
    }
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
                Text("Verify Email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20, fontFamily: poppinBold, color: kWhite)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                SvgPicture.asset('assets/splash/login_image.svg',
                    fit: BoxFit.fill),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "We have sent a One-Time Password(OTP),a six digit code, to the email you provided. Kindly review your email inbox to locate the OTP. Enter the provide code below to verify your email address.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: poppinRegular,
                      color: kWhite,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Form(
                  key: formKeyVerifyCode,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
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
                        hintStyle: TextStyle(
                            color: textLabelColor, fontFamily: poppinRegular),
                        hintCharacter: "0",
                        // obscuringCharacter: '*',
                        // obscuringWidget: FlutterLogo(
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
                    onTap: () {
                      if (formKeyVerifyCode.currentState!.validate()) {
                        if (textEditingController.text.isEmpty) {
                          toastFailedMessage(
                              'pinController cannot be empty', Colors.red);
                        } else if (textEditingController.text != selectedVerifyCode) {
                          toastFailedMessage(
                              'pin code did not matched', Colors.red);
                        } else {
                          setState(() {
                            progress = true;
                          });

                          verifyOTP();

                          Future.delayed(Duration(seconds: 1), () {
                            toastSuccessMessage("success", Colors.green);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PrivacyPolicyPage()));
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/intro_images/timer.png",
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Text(
                        " Expire on ${getTimerText()}",
                        style: TextStyle(
                          color: Color(0xffFF6666),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: poppinMedium,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      // Text(
                      //   "Resend Code (4)",
                      //   style: TextStyle(
                      //       color: borderColor,
                      //       fontSize: 16,
                      //       fontFamily: poppinSemiBold,
                      //       fontWeight: FontWeight.w500),
                      // ),
                      secondsRemaining == 0
                          ? GestureDetector(
                        onTap: () {

                          setState(() {
                            secondsRemaining = 120;
                            startTimer();
                          });
                          resendOtp();
                        },
                        child: Text(
                          "Resend",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: borderColor,
                            fontSize: 16,
                            fontFamily: poppinSemiBold,
                            fontWeight: FontWeight.w500),
                          ),
                      )
                          : Text(
                        "Resend",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: poppinSemiBold,
                            fontWeight: FontWeight.w500),
                      ),
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
