import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import '../../../Model/AuthModels/user_sign_up_model.dart';
import '../../../Widget/TextFields/password_text_field.dart';
import '../../../Widget/TextFields/text_form_field.dart';
import '../../../Widget/myTextWidget.dart';
import '../../TabPages/MyAppBarHeader/app_bar_header.dart';
import '../LoginPage/login_page.dart';
import 'verify_phone_page.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;
  bool checkBoxValue = false;
  final GlobalKey<FormState> singUpFormKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  SignUpModel signUpModel = SignUpModel();
  registerUser() async {
    // try {
    String apiUrl = signUpApiUrl;
    print("api: $apiUrl");
    print("one_signal_id: 123456");
    print("first_name: ${firstNameController.text}");
    print("last_name: ${lastNameController.text}");
    print("phone: ${phoneController.text}");
    print("email: ${emailController.text}");
    print("password: ${passwordController.text}");
    print("account_type: SignupWithApp");
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      'one_signal_id': "123456",
      'first_name': firstNameController.text.trim(),
      'last_name': lastNameController.text.trim(),
      'phone': phoneController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text,
      'account_type': "SignupWithApp",
    });
    final responseString = response.body;
    print("responseSignUpApi: $responseString");

    print("status Code SignUp: ${response.statusCode}");
    print("in 200 signUp");
    if (response.statusCode == 200) {
      signUpModel = signUpModelFromJson(responseString);
      setState(() {});
      print('signUpModel status: ${signUpModel.status}');
    }
    // } catch (e) {
    //   print('singUp error in catch = ${e.toString()}');
    //   return null;
    // }
  }

  bool isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      // appBar: MyAppBarSignUp(title: "Create Your New Account "),
      body: ModalProgressHUD(
        inAsyncCall: isInAsyncCall,
        opacity: 0.02,
        blur: 0.5,
        color: Colors.transparent,
        progressIndicator: CircularProgressIndicator(
          color: borderColor,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Center(child: Padding(
                padding:  EdgeInsets.only(top: 30),
                child: Text("Create your\nNew Account",
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(fontSize: 20, fontFamily: poppinBold, color: kWhite)),
              ),),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              // Center(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Image.asset(
              //         "assets/images/license.png",
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Container(
              //         color: Colors.transparent,
              //         width: MediaQuery.of(context).size.width * 0.6,
              //         child: Text(
              //           "Enter your name as it appears on your driving license.",
              //           maxLines: 2,
              //           textAlign: TextAlign.left,
              //           style: TextStyle(
              //               fontSize: 12,
              //               fontFamily: poppinRegular,
              //               color: kWhite),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth < 600) {
                    return  Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/license.png",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              "Enter your name as it appears on your driving license.",
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: poppinRegular,
                                  color: kWhite),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.3),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/license.png",
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                "Enter your name as it appears on your driving license.",
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: poppinRegular,
                                    color: kWhite),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              buildTextFields(),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RichText(
                  text: TextSpan(
                      text: "By creating an account, you agree to ",
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 12,
                          fontFamily: poppinRegular),
                      children: [
                        TextSpan(
                          text: "AutoHaus Rental's Terms of Use ",
                          style: TextStyle(
                            fontFamily: poppinRegular,
                            fontSize: 12,
                            color: borderColor,
                          ),
                          // recognizer: TapGestureRecognizer()..onTap = () => Navigator.push(
                          //     context, MaterialPageRoute(builder: (context) => PrivacyPolicy())),
                        ),
                        TextSpan(
                            text: " and ",
                            style: TextStyle(
                                fontFamily: poppinRegular, fontSize: 12)),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            fontSize: 12,
                            color: borderColor,
                            fontFamily: poppinRegular,
                          ),
                          // recognizer: TapGestureRecognizer()..onTap = () => Navigator.push(
                          //     context, MaterialPageRoute(builder: (context) => TermsAndCondition())),
                        ),
                      ]),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: borderColor,
                      ),
                      child: Checkbox(
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
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
                    Text(
                      "I don't want to get deals, discount and updates",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 12,
                        fontFamily: poppinRegular,
                      ),
                    ), //Text
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () async {
                    // Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => VerifyPhonePage()));
                    if (singUpFormKey.currentState!.validate()) {
                      if (firstNameController.text.isEmpty) {
                        toastFailedMessage('firstName cannot be empty', kRed);
                      } else if (lastNameController.text.isEmpty) {
                        toastFailedMessage('lastName cannot be empty', kRed);
                      } else if (phoneController.text.isEmpty) {
                        toastFailedMessage(
                            'phone number cannot be empty', kRed);
                      } else if (emailController.text.isEmpty) {
                        toastFailedMessage('email cannot be empty', kRed);
                      } else if (passwordController.text.isEmpty) {
                        toastFailedMessage('password cannot be empty', kRed);
                      } else if (passwordController.text.length < 6) {
                        toastFailedMessage(
                            'password must be of 6 digit', kRed);
                      } else {
                        setState(() {
                          isInAsyncCall = true;
                        });
                        await registerUser();

                        if (signUpModel.status == "success") {
                          // Future.delayed(Duration(seconds: ), () {
                            // toastSuccessMessage("success", colorGreen);
                            toastSuccessMessage(
                                "OTP Send in the Email",
                                colorGreen);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerifyPhonePage(
                                          userId: signUpModel
                                              .data![0].usersCustomersId
                                              .toString(),
                                          verifyCode:
                                              signUpModel.data![0].verifyCode,
                                        )));
                            setState(() {
                              isInAsyncCall = false;
                            });
                            print("false: $isInAsyncCall");
                          // });
                        }
                        if (signUpModel.status != "success") {
                          toastFailedMessage(signUpModel.message, kRed);
                          setState(() {
                            isInAsyncCall = false;
                          });
                        }
                      }
                    }
                  },
                  child: loginButton("Sign up", context)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 16,
                        fontFamily: poppinRegular,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                              fontFamily: poppinRegular,
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              color: kWhite),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage())),
                        )
                      ]),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  bool isLoggedIn = false;

  Widget buildTextFields() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.005),
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
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.005),
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
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     textWidget("Mobile number"),
                  //     SizedBox(
                  //         height: MediaQuery.of(context).size.height * 0.005),
                  //     EditTextUtils().getCustomEditTextArea(
                  //       hintValue: "+971 | Mobile number",
                  //       validation: true,
                  //       textController: phoneController,
                  //       keyboardType: TextInputType.phone,
                  //     ),
                  //   ],
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget("Mobile number"),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.005),
                      IntlPhoneField(
                        style: TextStyle(
                            color: borderColor,
                            fontFamily: poppinRegular,
                            fontSize: 14),
                        controller: phoneController,
                        initialCountryCode: 'US',
                        disableLengthCheck: false,
                        disableAutoFillHints: false,
                        // showCountryFlag: false,
                        // showDropdownIcon: false,
                        dropdownTextStyle: TextStyle(color: borderColor),
                        dropdownIcon: Icon(Icons.arrow_drop_down, color: textLabelColor,),
                        onChanged: onCountryChange,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.transparent),
                          contentPadding: EdgeInsets.only(top: 15, left: 20, bottom: 15),
                          isDense: true,
                          hintText: "Mobile number",
                          hintStyle: TextStyle(
                              color: textLabelColor,
                              fontFamily: poppinRegular,
                              fontSize: 14),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:  BorderSide(
                              color: textLabelColor,
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:  BorderSide(
                              color: textLabelColor,
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:  BorderSide(
                              color: textLabelColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:  BorderSide(
                              color: textLabelColor,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget("Email"),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005),
                      EditTextUtils().getCustomEditTextArea(
                        hintValue: "rose.matthews@gmail.com",
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005),
                      PasswordEditTextUtils().getPasswordTextField(
                        hintValue: "••••••••",
                        validation: true,
                        // autoFocus: true,
                        textController: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: _obscureText,
                        suffixIcon: IconButton(
                          icon: Padding(
                            padding: EdgeInsetsDirectional.only(end: 12.0),
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: textLabelColor,
                              size: 24,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
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
        ));
  }

  String countryCode = '';
  void onCountryChange(PhoneNumber number) {
    setState(() {
      countryCode = number.countryISOCode;
      print("countryCode ${countryCode}");
    });
  }
}
