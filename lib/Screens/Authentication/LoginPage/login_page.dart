import 'package:flutter_svg/svg.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ForgetPassword/forget_password_page.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_haus_rental_app/Widget/myTextWidget.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/tab_page.dart';
import 'package:auto_haus_rental_app/Widget/TextFields/text_form_field.dart';
import 'package:auto_haus_rental_app/Model/AuthModels/user_login_model.dart';
import 'package:auto_haus_rental_app/Widget/TextFields/password_text_field.dart';
import 'package:auto_haus_rental_app/Screens/Authentication/SignUpPage/sign_up_page.dart';

import 'KYC Pages/Kyc_selectionPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _obscureText  = true;
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool checkBoxValue = false;
  UserLoginModel userLoginModel = UserLoginModel();

  bool loading = true;

  userLogin() async {
    // try {
      String apiUrl = loginApiUrl;
      print("api: $apiUrl");
      print("email: ${loginEmailController.text}");
      print("password: ${loginPasswordController.text}");
      final response = await http.post(Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json'
        },
        body: {
          'email': loginEmailController.text,
          'password': loginPasswordController.text,
        },
      );
      final responseString = response.body;
      print("loginResponse: $responseString");

      print("status Code SignIn: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("in 200 signUp");
          userLoginModel = userLoginModelFromJson(responseString);
          setState(() {});
          print('signInModel status: ${userLoginModel.status}');
      }
    // } catch (e) {
    //   print('signIn error in catch = ${e.toString()}');
    //   return null;
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // sharedPrefs();
  }

  bool progress = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.13),
              SvgPicture.asset('assets/splash/login_image.svg', fit: BoxFit.fill,),
              SizedBox(height: screenHeight * 0.09,),
              Text("Hey there, \nwelcome back", textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: poppinMedium, color: kWhite),),
              SizedBox(height: screenHeight * 0.03,),
              Text("Please login your account.",
                style: TextStyle(fontSize: 16, fontFamily: poppinLight, color: kWhite),),
              SizedBox(height: screenHeight * 0.03,),
              buildTextFields(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        Theme(
                          data: ThemeData(unselectedWidgetColor: borderColor),
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
                        Text('Remember me', textAlign: TextAlign.left,
                          style: TextStyle(color: kWhite,
                              fontSize: 12, fontFamily: poppinRegular),
                        ), //Text
                      ], //<Widget>[]
                    ),
                    // SizedBox(width: screenWidth * 0.17),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordPage()));
                          },
                          child: Text('Forgot your password?', style: TextStyle(
                              color: kWhite, fontFamily: poppinRegular, fontSize: 12),)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.07),
              GestureDetector(
                  onTap: () async {
                    if(loginFormKey.currentState!.validate()){
                      if (loginEmailController.text.isEmpty) {
                        toastFailedMessage('email cannot be empty', Colors.red);
                      } else if (loginPasswordController.text.isEmpty) {
                        toastFailedMessage('password cannot be empty',Colors.red);
                      }  else if (loginPasswordController.text.length < 6) {
                        toastFailedMessage(
                            'password must be 6 digit', Colors.red);
                        // }  else
                      }
                      else{
                        setState(() {
                          progress = true;
                        });
                        await userLogin();
                        if (userLoginModel.status == "success") {
                          print("LogIn Success");
                          SharedPreferences sharedPref = await SharedPreferences.getInstance();
                          await sharedPref.setString('userid', "${userLoginModel.data?.usersCustomersId.toString()}");
                          await sharedPref.setString('user_first_name', "${userLoginModel.data?.firstName.toString()}");
                          await sharedPref.setString('user_email', "${userLoginModel.data?.email.toString()}");
                          await sharedPref.setString('user_last_name', "${userLoginModel.data?.lastName.toString()}");
                          await sharedPref.setString('profile_pic', "${userLoginModel.data?.profilePic}");
                          print("userId: ${userLoginModel.data!.usersCustomersId.toString()}");
                          print("userEmail: ${userLoginModel.data!.email}");
                          print("userFirstName: ${userLoginModel.data!.firstName!}");
                          print("userLastName: ${userLoginModel.data!.lastName!}");

                          Future.delayed(Duration(seconds: 1), () {
                            toastSuccessMessage("${userLoginModel.status}", Colors.green);

                            // Navigator.pushReplacement(context,
                            //     MaterialPageRoute(builder: (context) => TabBarPage()));

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => KYCSelectionScreen()));

                            setState(() {
                              progress = false;
                            });
                            print("false: $progress");
                          });
                        }
                        if (userLoginModel.status != "success") {
                          setState(() {
                            progress = false;
                          });
                          print("LoginMessage: loginError");
                          // toastFailedMessage("LoginError", Colors.red);
                          toastFailedMessage("${userLoginModel.message}", Colors.red);
                        }
                      }
                    }
                  },
                  child: loginButton("Login", context)),
              SizedBox(height: screenHeight * 0.05),
              RichText(
                text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: kWhite, fontFamily: poppinRegular, fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'SignUp',
                        style: TextStyle(fontFamily: poppinBold,
                            decoration: TextDecoration.underline, fontSize: 16, color: kWhite),
                        recognizer: TapGestureRecognizer()..onTap = () => Navigator.push(
                            context, MaterialPageRoute(builder: (context) => SignUpPage())),
                      )
                    ]),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  void launchSDK() async {

    // From your backend get an access token for the applicant to be verified.
    // The token must be generated with `levelName` and `userId`,
    // where `levelName` is the name of a level configured in your dashboard.
    //
    // The sdk will work in the production or in the sandbox environment
    // depend on which one the `accessToken` has been generated on.
    //
    final String accessToken = "your_access_token";

    // The access token has a limited lifespan and when it's expired, you must provide another one.
    // So be prepared to get a new token from your backend.
    final onTokenExpiration = () async {
      // call your backend to fetch a new access token (this is just an example)
      return Future<String>.delayed(Duration(seconds: 2), () => "your new access token");
    };

    final SNSStatusChangedHandler onStatusChanged = (SNSMobileSDKStatus newStatus, SNSMobileSDKStatus prevStatus) {
      print("The SDK status was changed: $prevStatus -> $newStatus");
    };

    final snsMobileSDK = SNSMobileSDK.init(accessToken, onTokenExpiration)
        .withHandlers( // optional handlers
        onStatusChanged: onStatusChanged
    )
        .withDebug(true) // set debug mode if required
        .withLocale(Locale("en")) // optional, for cases when you need to override the system locale
        .build();

    final SNSMobileSDKResult result = await snsMobileSDK.launch();

    print("Completed with result: $result");
  }

  Widget buildTextFields() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
        // padding: EdgeInsets.symmetric(horizontal: 20),
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
                        textWidget("Email"),
                        SizedBox(height: screenHeight * 0.005),
                        // EditTextUtils().getCustomEditTextArea(
                        //     hintValue: "rose.matthews@gmail.com",
                        //     validation: true,
                        //     // autoFocus: true,
                        //     textController: loginEmailController,
                        //     keyboardType: TextInputType.emailAddress,
                        // ),
                        TextFormField(
                          controller: loginEmailController,
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

                    SizedBox(height: screenHeight * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget("Password"),
                        SizedBox(height: screenHeight* 0.005),
                        PasswordEditTextUtils().getPasswordTextField(
                          hintValue: "••••••••",
                          validation: true,
                          // autoFocus: true,
                          textController: loginPasswordController,
                          keyboardType: TextInputType.text,
                          obscureText: _obscureText,
                          suffixIcon: IconButton(
                            icon: Padding(
                              padding: EdgeInsetsDirectional.only(end: 12.0),
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
