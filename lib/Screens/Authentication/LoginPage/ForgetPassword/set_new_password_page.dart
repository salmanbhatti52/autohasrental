import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../Widget/TextFields/password_text_field.dart';
import '../../../TabPages/MyAppBarHeader/app_bar_header.dart';
import 'myTextWidget.dart';
import 'privacy_policy_page.dart';

class SetNewPasswordPage extends StatefulWidget {
  const SetNewPasswordPage({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const MyAppBarSignUp(title: "Set a New Password"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // SizedBox(height: MediaQuery.of(context).size.height * 0.1),

              // Text("Set a New Password", textAlign: TextAlign.center,
              //   style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Bold', fontWeight: FontWeight.bold, color: kWhite),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              SvgPicture.asset('assets/splash/login_image.svg', fit: BoxFit.fill,),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Enter your new password, and confirm it by entering it a second time.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins-Regular', color: kWhite),),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

              buildTextFields(),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const PrivacyPolicyPage()));
                  },
                  child: loginButton("Next", context)),
            ],
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
                          // errorTextMsg: "Please Enter Email",
                        ),

                        // TextField(
                        //   controller: newPassController,
                        //   keyboardType: TextInputType.visiblePassword,
                        //   decoration: InputDecoration(
                        //     contentPadding: const EdgeInsets.only(
                        //         top: 15, left: 20, bottom: 15),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(30.0),
                        //         borderSide: BorderSide(color: textLabelColor)
                        //     ),
                        //     border: OutlineInputBorder(
                        //         borderSide: BorderSide(color: textLabelColor),
                        //         borderRadius: BorderRadius.circular(30)
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(30.0),
                        //         borderSide: BorderSide(color: borderColor)
                        //     ),
                        //     hintText: '••••••••',
                        //     hintStyle: TextStyle(color: textLabelColor, letterSpacing: 3,
                        //         fontFamily: 'Poppins-Bold'),
                        //     // labelStyle: TextStyle(color: textLabelColor),
                        //     focusColor: borderColor,
                        //     suffixIcon: IconButton(
                        //       icon: Icon(
                        //         // _obscureText ? Icons.visibility_off : Icons.visibility,
                        //           obscurePass ?  Icons.visibility :Icons.visibility_off,
                        //           color: textLabelColor),
                        //       onPressed: () {
                        //         setState(() {
                        //           obscurePass = !obscurePass;
                        //         });
                        //       },
                        //     ),
                        //   ),
                        //   style: TextStyle(color: borderColor, fontSize: 14),
                        // ),

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
                          // errorTextMsg: "Please Enter Email",
                        ),

                        // TextField(
                        //   cursorColor: borderColor,
                        //   controller: confirmNewPassController,
                        //   keyboardType: TextInputType.visiblePassword,
                        //   decoration: InputDecoration(
                        //     contentPadding: const EdgeInsets.only(
                        //         top: 15, left: 20, bottom: 15),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(30.0),
                        //         borderSide: BorderSide(color: textLabelColor)
                        //     ),
                        //     border: OutlineInputBorder(
                        //         borderSide: BorderSide(color: textLabelColor),
                        //         borderRadius: BorderRadius.circular(30)
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(30.0),
                        //         borderSide: BorderSide(color: borderColor)
                        //     ),
                        //     hintText: '••••••••',
                        //     hintStyle: TextStyle(color: textLabelColor, letterSpacing: 3,
                        //         fontFamily: 'Poppins-Bold'),
                        //     // labelStyle: TextStyle(color: textLabelColor),
                        //     focusColor: borderColor,
                        //     suffixIcon: IconButton(
                        //       icon: Icon(
                        //         // _obscureText ? Icons.visibility_off : Icons.visibility,
                        //           obscureConfirmPass ?  Icons.visibility :Icons.visibility_off,
                        //           color: textLabelColor),
                        //       onPressed: () {
                        //         setState(() {
                        //           obscureConfirmPass = !obscureConfirmPass;
                        //         });
                        //       },
                        //     ),
                        //   ),
                        //   style: TextStyle(color: borderColor, fontSize: 14),
                        // ),
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
