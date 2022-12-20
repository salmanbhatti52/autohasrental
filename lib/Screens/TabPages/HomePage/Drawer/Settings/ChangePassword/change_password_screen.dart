import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../Model/SettingsModel/change_passwod_model.dart';
import '../../../../../../Widget/toast_message.dart';
import '../../../../../Authentication/LoginPage/ForgetPassword/myTextWidget.dart';
import '../../../../MyAppBarHeader/app_bar_header.dart';
import '../settings_screen.dart';
import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

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
  SharedPreferences? prefs;
  ChangePasswordModel changePasswordModel = ChangePasswordModel();

  changePassword() async {
    String apiUrl = changePasswordApiUrl;
    print("api: $apiUrl");
    print("old_password: ${oldPassController.text}");
    print("password: ${newPassController.text}");
    print("confirm_password: ${confirmNewPassController.text}");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Accept': 'application/json'},
      body: {
        'email': email,
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
      if (responseString != 'false') {
        changePasswordModel = changePasswordModelFromJson(responseString);
        setState(() {});
        print('changePasswordModel status: ${changePasswordModel.status}');
      }
    }
  }

  String? email;

  sharedPrefs() async {
    loading = true;
    setState(() {});
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    email = (prefs!.getString('email'));
    print("Email in  LoginPrefs is = $email");
  }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarSingleImage(
        title: "Change Password",
        backImage: "assets/messages_images/Back.png",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            buildTextFields(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            GestureDetector(
                onTap: () async {
                  if (changePasswordFormKey.currentState!.validate()) {
                    setState(() {
                      progress = true;
                    });
                    await changePassword();
                    if (changePasswordModel.status == "success") {
                      print("Password Changed");

                      Future.delayed(const Duration(seconds: 3), () {
                        toastSuccessMessage("${changePasswordModel.status}", Colors.green);

                        Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => const SettingsScreen()));

                        setState(() {
                          progress = false;
                        });
                        print("false: $progress");
                      });
                    }
                    if (changePasswordModel.status != "success") {
                      setState(() {
                        progress = false;
                      });
                      print("Password Not Changed");
                      toastFailedMessage("Error", Colors.red);
                    }
                  }
                },
                child: loginButton("Reset", context)),
          ],
        ),
      ),
    );
  }

  Widget buildTextFields() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
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
                        textWidget("Enter Old Password"),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
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
                              contentPadding: const EdgeInsets.only(
                                  top: 15, left: 20, bottom: 15),
                              hintText: '••••••••',
                              hintStyle: TextStyle(
                                  color: textLabelColor,
                                  letterSpacing: 3,
                                  fontFamily: 'Poppins-Bold'),
                              focusColor: borderColor,
                              suffixIcon: Padding(
                                padding:
                                const EdgeInsetsDirectional.only(end: 12.0),
                                child: IconButton(
                                  icon: Icon(
                                      obscureOldPass
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: textLabelColor),
                                  onPressed: () {
                                    setState(() {
                                      obscureOldPass = !obscureOldPass;
                                    });
                                  },
                                ),
                              ),
                            ),
                            style:
                            TextStyle(color: textLabelColor, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget("Enter New Password"),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
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
                              contentPadding: const EdgeInsets.only(
                                  top: 15, left: 20, bottom: 15),
                              hintText: '••••••••',
                              hintStyle: TextStyle(
                                  color: textLabelColor,
                                  letterSpacing: 3,
                                  fontFamily: 'Poppins-Bold'),
                              focusColor: borderColor,
                              suffixIcon: Padding(
                                padding:
                                const EdgeInsetsDirectional.only(end: 12.0),
                                child: IconButton(
                                  icon: Icon(
                                      obscureNewPass
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: textLabelColor),
                                  onPressed: () {
                                    setState(() {
                                      obscureNewPass = !obscureNewPass;
                                    });
                                  },
                                ),
                              ),
                            ),
                            style:
                            TextStyle(color: textLabelColor, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget("Enter Confirm Password"),
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
                              contentPadding: const EdgeInsets.only(
                                  top: 15, left: 20, bottom: 15),
                              hintText: '••••••••',
                              hintStyle: TextStyle(
                                  color: textLabelColor,
                                  letterSpacing: 3,
                                  fontFamily: 'Poppins-Bold'),
                              focusColor: borderColor,
                              suffixIcon: Padding(
                                padding:
                                const EdgeInsetsDirectional.only(end: 12.0),
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
                            style:
                            TextStyle(color: textLabelColor, fontSize: 14),
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
