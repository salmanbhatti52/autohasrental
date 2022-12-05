import 'package:auto_haus_rental_app/Widget/fontFamily.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../Widget/TextFields/text_form_field.dart';
import '../../../Widget/button.dart';
import '../../../Widget/colors.dart';
import '../../../Widget/TextFields/password_text_field.dart';
import '../../TabPages/tab_page.dart';
import '../ForgetPassword/myTextWidget.dart';
import '../ForgetPassword/reset_password_page.dart';
import '../SignUpPage/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _obscureText  = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
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
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const TabBarPage()));
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
                        // TextField(
                        //   controller: emailController,
                        //   cursorColor: borderColor,
                        //   keyboardType: TextInputType.emailAddress,
                        //   // textAlignVertical: TextAlignVertical.center,
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
                        //     hintText: 'rose.matthews@mail.com',
                        //     hintStyle: TextStyle(color: textLabelColor, fontFamily: 'Poppins-Regular',),
                        //     // labelStyle: TextStyle(color: textLabelColor),
                        //     focusColor: borderColor,
                        //     // errorText: "error_msg"
                        //   ),
                        //   style: TextStyle(color: borderColor, fontSize: 14, fontFamily: "Poppins-Regular"),
                        //
                        // ),
                        //
                        // SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                        EditTextUtils().getCustomEditTextArea(
                            hintValue: "rose.matthews@mail.com",
                            validation: true,
                            // autoFocus: true,
                            textController: emailController,
                            keyboardType: TextInputType.emailAddress,
                            // errorTextMsg: "Please Enter Email",
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget("Password"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        // TextField(
                        //   cursorColor: borderColor,
                        //   controller: passwordController,
                        //   keyboardType: TextInputType.text,
                        //   obscureText: _obscureText,
                        //   decoration: InputDecoration(
                        //       contentPadding: const EdgeInsets.only(
                        //           top: 15, left: 20, bottom: 15),
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
                        //     suffixIcon: Padding(
                        //       padding: const EdgeInsetsDirectional.only(end: 12.0),
                        //       child: IconButton(
                        //         icon: Icon(
                        //             _obscureText ?  Icons.visibility :Icons.visibility_off,
                        //             color: textLabelColor, size: 24,),
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
