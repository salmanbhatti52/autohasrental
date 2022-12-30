import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/cookies_utils.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../Model/AuthModels/modify_password_model.dart';
import '../../../../Utils/fontFamily.dart';
import '../../../../Widget/TextFields/password_text_field.dart';
import '../../../../Widget/myTextWidget.dart';
import '../../../TabPages/MyAppBarHeader/app_bar_header.dart';
import '../../SignUpPage/privacy_policy_page.dart';
import 'package:http/http.dart'as http;

import '../login_page.dart';

class SetNewPasswordPage extends StatefulWidget {
  final String? email, verifyCode;
  const SetNewPasswordPage({Key? key, this.email, this.verifyCode}) : super(key: key);

  @override
  State<SetNewPasswordPage> createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  var newPassController = TextEditingController();
  var confirmNewPassController = TextEditingController();
  bool obscureConfirmPass  = true;
  bool obscurePass  = true;
  bool checkBoxValue = false;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("resetEmail & code${widget.email} ${widget.verifyCode}");
  }

  ModifyPasswordModel modifyPasswordModel = ModifyPasswordModel();
  modifyNewPasswordWidget() async {
    try {
      String apiUrl = modifyNewPasswordApiUrl;
      print("modifyNewPasswordApiUrl: $apiUrl");
      print("email: ${widget.email}");
      print("verifyCode: ${widget.verifyCode}");
      print("password: ${newPassController.text}");
      print("passwordConfirm: ${confirmNewPassController.text}");
      final response = await http.post(Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Cookie': cookieModifyPassword,
        },
        body: {
          'email': widget.email,
          'otp': widget.verifyCode,
          'password': newPassController.text,
          'confirm_password': confirmNewPassController.text,
        },
      );
      final responseString = response.body;
      print("modifyPasswordResponse: $responseString");

      print("status Code modifyPassword: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("in 200 modifyPassword");
        if (responseString != 'false') {
          modifyPasswordModel = modifyPasswordModelFromJson(responseString);
          setState(() {});
          print('modifyPassword status: ${modifyPasswordModel.status}');
        }
      }
    } catch (e) {
      print('modifyPassword error in catch = ${e.toString()}');
      return null;
    }
  }

  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const MyAppBarSignUp(title: "Set a New Password"),

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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                SvgPicture.asset('assets/splash/login_image.svg', fit: BoxFit.fill,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Enter your new password, and confirm it by entering it a second time.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontFamily: poppinRegular, color: kWhite),),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

                buildTextFields(),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                GestureDetector(
                    onTap: () async {
                      if(loginFormKey.currentState!.validate()){
                        if (newPassController.text.isEmpty) {
                          toastFailedMessage('new password cannot be empty', Colors.red);
                        } else if (confirmNewPassController.text.isEmpty) {
                          toastFailedMessage('confirm new password cannot be empty',Colors.red);
                        } else if(newPassController.text != confirmNewPassController.text){
                          toastFailedMessage('password did not matched', Colors.red);
                        } else if(newPassController.text == confirmNewPassController.text) {
                          print("password matched");
                          setState(() {
                            progress = true;
                          });
                          await modifyNewPasswordWidget();
                          if (modifyPasswordModel.status == "success") {
                            Future.delayed(const Duration(seconds: 3), () {
                              print("passwordModify");
                              print("${modifyPasswordModel.status}");
                              toastSuccessMessage("${modifyPasswordModel.status}", colorGreen);

                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()));

                              setState(() {
                                progress = false;
                              });
                              print("false: $progress");
                            });
                          }
                          if (modifyPasswordModel.status != "success") {
                            setState(() {
                              progress = false;
                            });
                            print("passwordModify error");
                            toastFailedMessage("passwordModify error ", Colors.red);
                          }
                        }
                      }
                      },
                    child: loginButton("Next", context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFields() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Form(
                key: loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget("New Password"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        PasswordEditTextUtils().getPasswordTextField(
                          hintValue: "••••••••",
                          validation: true,
                          // autoFocus: true,
                          textController: newPassController,
                          keyboardType: TextInputType.text,
                          obscureText: obscurePass,
                          suffixIcon: IconButton(
                            icon: Padding(
                              padding: const EdgeInsetsDirectional.only(end: 12.0),
                              child: Icon(
                                obscurePass ?  Icons.visibility :Icons.visibility_off,
                                color: textLabelColor, size: 24,),
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePass = !obscurePass;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget("Confirm new password"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        PasswordEditTextUtils().getPasswordTextField(
                          hintValue: "••••••••",
                          validation: true,
                          // autoFocus: true,
                          textController: confirmNewPassController,
                          keyboardType: TextInputType.text,
                          obscureText: obscureConfirmPass,
                          suffixIcon: IconButton(
                            icon: Padding(
                              padding: const EdgeInsetsDirectional.only(end: 12.0),
                              child: Icon(
                                obscureConfirmPass ?  Icons.visibility :Icons.visibility_off,
                                color: textLabelColor, size: 24,),
                            ),
                            onPressed: () {
                              setState(() {
                                obscureConfirmPass = !obscureConfirmPass;
                              });
                            },
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
