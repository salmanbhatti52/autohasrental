import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/myTextWidget.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../Model/SettingsModel/change_password_model.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/cookies_utils.dart';
import '../settings_screen.dart';
import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();
  var confirmNewPassController = TextEditingController();
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  bool obscureOldPass = true;
  bool obscureNewPass = true;
  bool obscureConfirmPass = true;
  bool loading = true;
  bool progress = false;
  ChangePasswordModel changePasswordModel = ChangePasswordModel();

  sharedPrefs() async {
    loading = true;
    setState(() {});
    print('in sharedPrefs');
    prefs = await SharedPreferences.getInstance();
    userEmail = (prefs!.getString('user_email'));
    print("userEmail in sharedPrefs is = $userEmail");
  }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  changePassword() async {
    setState(() {
      progress = true;
    });
    String apiUrl = changePasswordApiUrl;
    print("api: $apiUrl");
    print("userEmail: $userEmail");
    print("old_password: ${oldPassController.text}");
    print("newPassword: ${newPassController.text}");
    print("confirmPassword: ${confirmNewPassController.text}");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
        'Cookie': cookieChangePassword,
      },
      body: {
        'email': userEmail,
        'old_password': oldPassController.text,
        'password': newPassController.text,
        'confirm_password': confirmNewPassController.text,
      },
    );
    final responseString = response.body;
    print("changePasswordResponse: $responseString");
    print("status Code changePassword: ${response.statusCode}");
    if (response.statusCode == 200) {
      print("in 200 changePassword");
        changePasswordModel = changePasswordModelFromJson(responseString);
        setState(() {
          progress = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: MyAppBarSingleImage(
        title: "Change Password",
        backImage: "assets/messages_images/Back.png",
      ),
      body: ModalProgressHUD(
        inAsyncCall: progress,
        opacity: 0.02,
        blur: 0.5,
        color: Colors.transparent,
        progressIndicator: CircularProgressIndicator(
          color: borderColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
              buildTextFields(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
              GestureDetector(
                  onTap: () async {
                    if (changePasswordFormKey.currentState!.validate()) {
                      if (oldPassController.text.isEmpty) {
                        toastFailedMessage('old password cannot be empty', Colors.red);
                      } else if (oldPassController.text.length < 6) {
                        toastFailedMessage('oldPassword must be 6 digit', Colors.red);
                      } else if (newPassController.text.isEmpty) {
                        toastFailedMessage('new password cannot be empty', Colors.red);
                      } else if (newPassController.text.length < 6) {
                        toastFailedMessage('password must be 6 digit', Colors.red);
                      } else if (confirmNewPassController.text.isEmpty) {
                        toastFailedMessage('confirm new password cannot be empty',Colors.red);
                      } else if (confirmNewPassController.text.length < 6) {
                        toastFailedMessage('password must be 6 digit',Colors.red);
                      } else if(newPassController.text != confirmNewPassController.text){
                        toastFailedMessage('password did not matched', Colors.red);
                      } else {
                        print("password matched");
                        await changePassword();
                        if (changePasswordModel.status == "success") {
                          print("Password Changed");

                          Future.delayed(Duration(seconds: 1), () {
                            toastSuccessMessage("Password Changed Successfully", Colors.green);

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => SettingsScreen()));
                            print("false: $progress");
                          }
                          );
                        } else{
                          toastSuccessMessage("Old password is not correct.", Colors.red);
                        }
                      }
                    }
                  },
                  child: loginButton("Reset", context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFields() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Form(
                key: changePasswordFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidgetBlack("Enter Old Password"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            controller: oldPassController,
                            cursorColor: borderColor,
                            obscureText: obscureOldPass,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
                              hintText: '••••••••',
                              hintStyle: TextStyle(
                                  color: textLabelColor,
                                  letterSpacing: 3,
                                  fontFamily: poppinBold),
                              focusColor: borderColor,
                              suffixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(end: 12.0),

                                child: IconButton(
                                  icon: Icon(
                                      obscureOldPass ? Icons.visibility : Icons.visibility_off,
                                      color: textLabelColor),
                                  onPressed: () {
                                    setState(() {
                                      obscureOldPass = !obscureOldPass;
                                    });
                                  },
                                ),
                              ),
                            ),
                            style: TextStyle(color: textLabelColor, fontSize: 14),

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidgetBlack("Enter New Password"),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            controller: newPassController,
                            cursorColor: borderColor,
                            obscureText: obscureNewPass,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
                              hintText: '••••••••',
                              hintStyle: TextStyle(color: textLabelColor,
                                  letterSpacing: 3, fontFamily: poppinBold),
                              focusColor: borderColor,
                              suffixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(end: 12.0),

                                child: IconButton(
                                  icon: Icon(
                                      obscureNewPass ? Icons.visibility : Icons.visibility_off,
                                      color: textLabelColor),
                                  onPressed: () {
                                    setState(() {
                                      obscureNewPass = !obscureNewPass;
                                    });
                                  },
                                ),
                              ),
                            ),
                            style:     TextStyle(color: textLabelColor, fontSize: 14),

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidgetBlack("Enter Confirm Password"),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            controller: confirmNewPassController,
                            cursorColor: borderColor,
                            obscureText: obscureConfirmPass,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  top: 15, left: 20, bottom: 15),
                              hintText: '••••••••',
                              hintStyle: TextStyle(
                                  color: textLabelColor,
                                  letterSpacing: 3,
                                  fontFamily: poppinBold),
                              focusColor: borderColor,
                              suffixIcon: Padding(
                                padding:
                                EdgeInsetsDirectional.only(end: 12.0),
                                child: IconButton(
                                  icon: Icon(
                                      obscureConfirmPass
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: textLabelColor),
                                  onPressed: () {
                                    setState(() {
                                      obscureConfirmPass = !obscureConfirmPass;
                                    });
                                  },
                                ),
                              ),
                            ),
                            style:TextStyle(color: textLabelColor, fontSize: 14),

                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
