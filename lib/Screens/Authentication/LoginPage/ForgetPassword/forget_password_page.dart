import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../Model/AuthModels/forget_password_model.dart';
import '../../../../Widget/myTextWidget.dart';
import '../../../../Widget/toast_message.dart';
import '../../../TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:http/http.dart' as http;
import 'verify_forget_otp_page.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var resetEmailController = TextEditingController();
  ForgetPasswordModel forgetPasswordModel = ForgetPasswordModel();

  resetPasswordWidget() async {
    try {
      String apiUrl = forgetPasswordApiUrl;
      print("api: $apiUrl");
      print("email: ${resetEmailController.text}");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Accept': 'application/json'},
        body: {
          'email': resetEmailController.text,
        },
      );
      final responseString = response.body;
      print("resetPasswordResponse: $responseString");

      print("status Code forgetModel: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("in 200 resetPassModel");
        // print("resS $responseString");
        // if (responseString != 'false') {
          forgetPasswordModel = forgetPasswordModelFromJson(responseString);
          setState(() {});
          print('forgetModel status: ${forgetPasswordModel.status}');
        // }
      }
    } catch (e) {
      print('forgetModel error in catch = ${e.toString()}');
      return null;
    }
  }

  bool progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: MyAppBarSignUp(title: "Reset Password"),
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
            padding: EdgeInsets.all(0.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                SvgPicture.asset(
                  'assets/splash/login_image.svg',
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Enter the email address associated with your account. We'll send you a link to reset your password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, fontFamily: poppinRegular, color: kWhite),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                buildTextFields(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                GestureDetector(
                    onTap: () async {
                      if (loginFormKey.currentState!.validate()) {
                        if (resetEmailController.text.isEmpty) {
                          toastFailedMessage('email cannot be empty', Colors.red);
                        } else {
                          setState(() {
                            progress = true;
                          });
                          await resetPasswordWidget();
                          if (forgetPasswordModel.status == "success") {
                            print("reset Success");
                            Future.delayed(Duration(seconds: 1), () {
                              toastSuccessMessage("${forgetPasswordModel.data!.message}", colorGreen);
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                      builder: (context) => VerifyForgetOTPPage(
                                        email: resetEmailController.text,
                                        verifyCode: forgetPasswordModel.data!.otp.toString(),
                                      )));
                              print("resetEmail: ${resetEmailController.text}");
                              print("resetCode: ${forgetPasswordModel.data!.otp.toString()}");

                              setState(() {
                                progress = false;
                              });
                              print("false: $progress");
                            });
                          }
                          if (forgetPasswordModel.status != "success") {
                            setState(() {
                              progress = false;
                            });
                            print("forgetPasswordModel: loginError");
                            toastFailedMessage(
                                "forgetPasswordModel", Colors.red);
                          }
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: loginButton("Send Reset Link", context),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFields() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: Colors.transparent,
        child: Form(
          key: loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget("Email"),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  TextFormField(
                    controller: resetEmailController,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your Email");
                      }
                      // reg expression for email validation
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: textLabelColor)
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: textLabelColor),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: borderColor)
                      ),
                      hintText: "rose.matthews@gmail.com",
                      hintStyle: TextStyle(color: textLabelColor, fontFamily: poppinRegular,),
                      focusColor: borderColor,
                      // errorText: errorTextMsg,
                    ),
                    style: TextStyle(color: borderColor, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
