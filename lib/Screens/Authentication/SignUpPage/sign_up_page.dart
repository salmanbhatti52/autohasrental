import 'dart:convert';

import 'package:auto_haus_rental_app/Model/Auth/user_sign_up_model.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Widget/TextFields/text_form_field.dart';
import '../../../Utils/api_urls.dart';
import '../../../Widget/button.dart';
import '../../../Utils/colors.dart';
import '../../../Widget/TextFields/password_text_field.dart';
import '../../TabPages/MyAppBarHeader/app_bar_header.dart';
import '../LoginPage/ForgetPassword/myTextWidget.dart';
import '../LoginPage/login_page.dart';
import 'package:http/http.dart'as http;

import 'verify_phone_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText  = true;
  bool checkBoxValue = false;
  final GlobalKey<FormState> singUpFormKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  SignUpModel signUpModel = SignUpModel();
  registerUser() async {
    try {
      String apiUrl = signUpApiUrl;
      print("api: $apiUrl");
      print("one_signal_id: 123456");
      print("first_name: ${firstNameController.text}");
      print("last_name: ${lastNameController.text}");
      print("phone: ${phoneController.text}");
      print("email: ${emailController.text}");
      print("password: ${passwordController.text}");
      print("account_type: SignupWithApp");
      final response = await http.post(Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json'
        },
        body: {
          'one_signal_id': "123456",
          'first_name': firstNameController.text.trim(),
          'last_name': lastNameController.text.trim(),
          'phone': phoneController.text.trim(),
          'email': emailController.text.trim(),
          'password': passwordController.text,
          'account_type': "SignupWithApp",
        },
      );
      final responseString = response.body;
      print("response String: $responseString");

      print("status Code SignUp: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("in 200 signUp");
        print("resS $responseString");
        if (responseString != 'false') {
          signUpModel = signUpModelFromJson(responseString);
          setState(() {});
          print('signUpModel status: ${signUpModel.status}');
        }
      }
    } catch (e) {
      print('singUp error in catch = ${e.toString()}');
      return null;
    }
  }

  // var userId;
  // getSignup() async {
  //   Map body = {
  //     'one_signal_id': "123456",
  //     'first_name': firstNameController.text.trim(),
  //     'last_name': lastNameController.text.trim(),
  //     'phone': phoneController.text.trim(),
  //     'email': emailController.text.trim(),
  //     'password': passwordController.text,
  //     'account_type': "SignupWithApp",
  //   };
  //   http.Response response = await http.post(Uri.parse(signUpUrl),
  //       body: body,
  //       headers: {
  //     'Accept': 'application/json'
  //   });
  //   print('response==' + response.body.toString());
  //   var jsonData = jsonDecode(response.body);
  //   userId = (jsonData['data']);
  //   //
  //   print("userId $userId");
  //   // print("signUpApiUrl: $signUpUrl");
  //   // userToken = (jsonData['token']);
  //
  //   if(jsonData["status"] == "success"){
  //     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //     sharedPreferences.setString('userId', userId.toString());
  //     sharedPreferences.setString('userToken', signUpModel.verifyCode.toString());
  //
  //     print("userId ${signUpModel.usersCustomersId.toString()}");
  //     print("userToken ${signUpModel.verifyCode.toString()}");
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (context) => const VerifyPhonePage()));
  //     toastSuccessMessage("SignUp Successfully...", Colors.green);
  //   }
  //   // setState(() {
  //   //   isSignUp = false;
  //   // });
  // }

  bool isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const MyAppBarSignUp(title: "Create Your New Account "),
      body: ModalProgressHUD(
        inAsyncCall: isInAsyncCall,
        // opacity: 0.5,
        // blur: 0.5,
        // progressIndicator: const CircularProgressIndicator(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                // SizedBox(height: MediaQuery.of(context).size.height * 0.09,),
                // Text("Create Your \nNew Account ", textAlign: TextAlign.center,
                //   style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kWhite),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/license.png",),
                      const SizedBox(width: 10,),
                      Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text("Enter your name as it appears on your driving license.",
                          maxLines: 2, textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 12,
                              fontFamily: poppinRegular, color: kWhite),),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

                buildTextFields(),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: RichText(
                    text: TextSpan(text: "By creating an account, you agree to ",
                        style: TextStyle(color: kWhite, fontSize: 12, fontFamily: poppinRegular),
                        children: [
                          TextSpan(text: "AutoHaus Rental's Terms of Use ", style: TextStyle(
                            fontFamily: poppinRegular, fontSize: 12, color: borderColor,),
                            // recognizer: TapGestureRecognizer()..onTap = () => Navigator.push(
                            //     context, MaterialPageRoute(builder: (context) => PrivacyPolicy())),
                          ),
                          TextSpan(text: " and ", style: TextStyle(fontFamily: poppinRegular, fontSize: 12)),
                          TextSpan(
                            text: 'Privacy Policy', style: TextStyle(
                            fontSize: 12, color: borderColor,  fontFamily: poppinRegular,),
                            // recognizer: TapGestureRecognizer()..onTap = () => Navigator.push(
                            //     context, MaterialPageRoute(builder: (context) => TermsAndCondition())),
                          ),
                        ]),
                    textAlign: TextAlign.left,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Theme(
                        data: ThemeData(unselectedWidgetColor: borderColor,),
                        child: Checkbox(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: kWhite,
                          checkColor: borderColor,
                          value: checkBoxValue,
                          onChanged: (bool? value) {
                            setState(() {
                              checkBoxValue = value!;
                            });
                          },
                        ),
                      ),
                      Text("I don't want to get deals, discount and updates", textAlign: TextAlign.left,
                        style: TextStyle(color: kWhite, fontSize: 12,  fontFamily: poppinRegular,),
                      ), //Text
                      //SizedBox
                    ], //<Widget>[]
                  ),
                ),

                GestureDetector(
                    onTap: () async {
                      // submit();
                      if(singUpFormKey.currentState!.validate()){
                        if (firstNameController.text.isEmpty) {
                          toastFailedMessage('firstName cannot be empty', Colors.red);
                        } else if (lastNameController.text.isEmpty) {
                          toastFailedMessage('lastName cannot be empty',Colors.red);
                        } else if (phoneController.text.isEmpty) {
                          toastFailedMessage('phone number cant be empty', Colors.red);
                        } else if (emailController.text.isEmpty) {
                          toastFailedMessage('email cannot be empty', Colors.red);
                        } else if (passwordController.text.isEmpty) {
                          toastFailedMessage('password cannot be empty', Colors.red);
                        } else if (passwordController.text.length < 6) {
                          toastFailedMessage('password must be 6 digit', Colors.red);
                        } else {
                          setState(() {
                            isInAsyncCall = true;
                          });
                         await registerUser();
                          // SharedPreferences prefs = await SharedPreferences.getInstance();
                          // await prefs.setString('verify_code', signUpModel.data![0].verifyCode.toString());
                          // await prefs.setInt('userid', signUpModel.data![0].usersCustomersId!);
                          // print("verificationCode: ${signUpModel.data![0].verifyCode}");
                          // print("userId: ${signUpModel.data![0].usersCustomersId}");
                              // .then((){
                            // setState(() {
                              toastSuccessMessage("success", Colors.green);

                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => VerifyPhonePage(
                                  userId: signUpModel.data![0].usersCustomersId.toString(),
                                  verifyCode: signUpModel.data![0].verifyCode,
                                )));
                            setState(() {
                              isInAsyncCall = false;
                            });
                            print("false: $isInAsyncCall");
                          });
                        }
                      }
                    },
                    child: loginButton("Sign up", context)),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                RichText(
                  text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: kWhite, fontSize: 16, fontFamily: poppinRegular,),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(fontFamily: poppinRegular,
                              decoration: TextDecoration.underline, fontSize: 16, color: kWhite),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const LoginPage())),
                        )
                      ]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool isLoggedIn = false;
  // void submit() {
  //   if (singUpFormKey.currentState!.validate()) {
  //     singUpFormKey.currentState!.save();
  //
  //     // dismiss keyboard during async call
  //     FocusScope.of(context).requestFocus(FocusNode());
  //
  //     // start the modal progress HUD
  //     setState(() {
  //       isInAsyncCall = true;
  //     });
  //
  //     // Simulate a service call
  //     Future.delayed(const Duration(seconds: 3), () async {
  //       setState(() {
  //         if (firstNameController.text.isEmpty) {
  //           toastFailedMessage('firstName cannot be empty', Colors.red);
  //         } else if (lastNameController.text.isEmpty) {
  //           toastFailedMessage('lastName cannot be empty',Colors.red);
  //         } else if (phoneController.text.isEmpty) {
  //           toastFailedMessage('phone number cant be empty', Colors.red);
  //         } else if (emailController.text.isEmpty) {
  //           toastFailedMessage('email cannot be empty', Colors.red);
  //         } else if (passwordController.text.isEmpty) {
  //           toastFailedMessage('password cannot be empty', Colors.red);
  //         } else if (passwordController.text.length < 6) {
  //           toastFailedMessage('password must be 6 digit', Colors.red);
  //         }
  //         // stop the modal progress HUD
  //         isInAsyncCall = false;
  //       });
  //       if (isLoggedIn) {
  //         await registerUser();
  //         toastSuccessMessage("success", Colors.green);
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => const VerifyPhonePage()));
  //       }
  //     });
  //   }
  // }

  Widget buildTextFields() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Form(
              key: singUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWidget("First name"),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                            EditTextUtils().getCustomEditTextArea(
                              hintValue: "Legal first name",
                              validation: true,
                              textController: firstNameController,
                              keyboardType: TextInputType.text,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWidget("Last name"),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                            EditTextUtils().getCustomEditTextArea(
                              hintValue: "Legal last name",
                              validation: true,
                              textController: lastNameController,
                              keyboardType: TextInputType.text,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget("Mobile number"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                      EditTextUtils().getCustomEditTextArea(
                        hintValue: "+971 | Mobile number",
                        validation: true,
                        textController: phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget("Email"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.005),

                      // EditTextUtils().getCustomEditTextArea(
                      //   hintValue: "Legal first name",
                      //   validation: true,
                      //   textController: firstNameController,
                      //   keyboardType: TextInputType.text,
                      // ),
                      EditTextUtils().getCustomEditTextArea(
                        hintValue: "rose.matthews@mail.com",
                        validation: true,
                        textController: emailController,
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget("Password"),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                      PasswordEditTextUtils().getPasswordTextField(
                        hintValue: "••••••••",
                        validation: true,
                        // autoFocus: true,
                        textController: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: _obscureText,
                        suffixIcon: IconButton(
                          icon: Padding(
                            padding: const EdgeInsetsDirectional.only(end: 12.0),
                            child: Icon(
                              _obscureText ?  Icons.visibility :Icons.visibility_off,
                              color: textLabelColor, size: 24,),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        // errorTextMsg: "Please Enter Email",
                      ),

                      // TextField(
                      //   cursorColor: borderColor,
                      //   controller: passwordController,
                      //   keyboardType: TextInputType.text,
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
                      //         fontFamily: poppinBold),
                      //     // labelStyle: TextStyle(color: textLabelColor),
                      //     focusColor: borderColor,
                      //     suffixIcon: IconButton(
                      //       icon: Icon(
                      //         // _obscureText ? Icons.visibility_off : Icons.visibility,
                      //           _obscureText ?  Icons.visibility :Icons.visibility_off,
                      //           color: textLabelColor),
                      //       onPressed: () {
                      //         setState(() {
                      //           _obscureText = !_obscureText;
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
        ));
  }
}
