import 'package:auto_haus_rental_app/Model/Auth/user_login_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Widget/TextFields/text_form_field.dart';
import '../../../Widget/button.dart';
import '../../../Utils/colors.dart';
import '../../../Widget/TextFields/password_text_field.dart';
import '../../../Widget/toast_message.dart';
import '../../TabPages/tab_page.dart';
import '../SignUpPage/sign_up_page.dart';
import 'ForgetPassword/myTextWidget.dart';
import 'ForgetPassword/reset_password_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _obscureText  = true;
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool checkBoxValue = false;
  SharedPreferences? prefs;
  String? userId;
  UserLoginModel userLoginModel = UserLoginModel();

  bool loading = true;
  sharedPrefs() async {
    loading = true;
    setState(() {});
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print("userId in  LoginPrefs is = $userId");
    if (userId != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => TabBarPage()));
    }
    else{
      loading = false;
      setState(() {});
      print("userId value is = $userId");
    }
  }

  userLogin() async {
    try {
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
        // print("resS $responseString");
        if (responseString != 'false') {
          userLoginModel = userLoginModelFromJson(responseString);
          setState(() {});
          print('signInModel status: ${userLoginModel.status}');
        }
      }
    } catch (e) {
      print('signIn error in catch = ${e.toString()}');
      return null;
    }
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
    return Scaffold(
      backgroundColor: appBgColor,
      body: ModalProgressHUD(
          inAsyncCall: progress,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.13),
                SvgPicture.asset('assets/splash/login_image.svg', fit: BoxFit.fill,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.09,),
                Text("Hey there, \nwelcome back", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontFamily: poppinMedium, color: kWhite),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Text("Please login your account.",
                  style: TextStyle(fontSize: 16, fontFamily: poppinLight, color: kWhite),),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

                buildTextFields(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                          Text('Remember me', textAlign: TextAlign.left,
                            style: TextStyle(color: kWhite, fontSize: 12, fontFamily: poppinRegular),
                          ), //Text
                        ], //<Widget>[]
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPasswordPage()));
                          },

                          child: Text('Forgot your password?', style: TextStyle(
                              color: kWhite, fontFamily: poppinRegular, fontSize: 12),)),
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.07),

                GestureDetector(
                    onTap: () async {
                      if(loginFormKey.currentState!.validate()){
                        // await userLogin();

                        setState(() {
                          progress = true;
                        });
                        await userLogin();
                        if (userLoginModel.status == "success") {
                          print("LogIn Success");
                          SharedPreferences sharedPref = await SharedPreferences.getInstance();
                          await sharedPref.setString('userid', userLoginModel.data!.usersCustomersId.toString());
                          await sharedPref.setString('token', userLoginModel.data!.firstName!);
                          await sharedPref.setString('username', userLoginModel.data!.lastName!);
                          print("userId: ${userLoginModel.data!.usersCustomersId.toString()}");
                          print("userFirstName: ${userLoginModel.data!.firstName!}");
                          print("userLastName: ${userLoginModel.data!.lastName!}");

                          Future.delayed(const Duration(seconds: 3), () {
                            toastSuccessMessage("${userLoginModel.status}", Colors.green);

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => const TabBarPage()));

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
                          toastFailedMessage("LoginError", Colors.red);
                        }
                      }

                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> const TabBarPage()));
                    },
                    child: loginButton("Login", context)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                RichText(
                  text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: kWhite, fontFamily: poppinRegular, fontSize: 16),
                      children: [
                        TextSpan(
                          text: 'SignUp',
                          style: TextStyle(fontFamily: poppinBold,
                              decoration: TextDecoration.underline, fontSize: 16, color: kWhite),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const SignUpPage())),
                        )
                      ]),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFields() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        EditTextUtils().getCustomEditTextArea(
                            hintValue: "rose.matthews@mail.com",
                            validation: true,
                            // autoFocus: true,
                            textController: loginEmailController,
                            keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget("Password"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        PasswordEditTextUtils().getPasswordTextField(
                          hintValue: "••••••••",
                          validation: true,
                          // autoFocus: true,
                          textController: loginPasswordController,
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

                        // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                        // TextField(
                        //   controller: passwordController,
                        //   keyboardType: TextInputType.visiblePassword,
                        //   decoration: InputDecoration(
                        //     contentPadding: const EdgeInsets.fromLTRB(20, 15, 10, 0),
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
                        //     hintText: 'password',
                        //     hintStyle: TextStyle(color: textLabelColor),
                        //     // labelStyle: TextStyle(color: textLabelColor),
                        //     focusColor: borderColor,
                        //     suffixIcon: Padding(
                        //       padding: const EdgeInsetsDirectional.only(end: 12.0),
                        //       child: IconButton(
                        //         icon: Icon(
                        //           _obscureText ?  Icons.visibility :Icons.visibility_off,
                        //           color: textLabelColor, size: 24,),
                        //         onPressed: () {
                        //           setState(() {
                        //             _obscureText = !_obscureText;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        //   style: TextStyle(color: borderColor, fontSize: 14, fontFamily: "Poppins-Regular"),
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
