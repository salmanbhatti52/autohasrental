import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../Widget/button.dart';
import '../../../Widget/colors.dart';
import '../ForgetPassword/myTextWidget.dart';
import 'verify_phone_page.dart';
import '../LoginPage/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool _obscureText  = true;
  bool checkBoxValue = false;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.09,),
              Text("Create Your \nNew Account ", textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Bold', color: kWhite),),
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
                            fontFamily: 'Poppins-Regular', color: kWhite),),
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
                      style: TextStyle(color: kWhite, fontSize: 12, fontFamily: 'Poppins-Regular'),
                      children: [
                        TextSpan(text: "AutoHaus Rental's Terms of Use ", style: TextStyle(
                          fontFamily: 'Poppins',                           fontSize: 12, color: borderColor,),
                          // recognizer: TapGestureRecognizer()..onTap = () => Navigator.push(
                          //     context, MaterialPageRoute(builder: (context) => PrivacyPolicy())),
                        ),
                        const TextSpan(text: " and ", style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 12)),
                        TextSpan(
                          text: 'Privacy Policy', style: TextStyle(
                          fontSize: 12, color: borderColor,  fontFamily: 'Poppins-Regular',),
                          // recognizer: TapGestureRecognizer()..onTap = () => Navigator.push(
                          //     context, MaterialPageRoute(builder: (context) => TermsAndCondition())),
                        ),
                      ]),
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
                      style: TextStyle(color: kWhite, fontSize: 12,  fontFamily: 'Poppins-Regular',),
                    ), //Text
                    //SizedBox
                  ], //<Widget>[]
                ),
              ),

              // SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const VerifyPhonePage()));
                  },
                  child: loginButton("Sign up", context)),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              RichText(
                text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: kWhite, fontSize: 16, fontFamily: 'Poppins-Regular',),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(fontFamily: 'Poppins-Regular',
                            decoration: TextDecoration.underline, fontSize: 16, color: kWhite),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const LoginPage())),
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
          child: Column(
            children: [
              Form(
                key: loginFormKey,
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
                              TextField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
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
                                  hintText: 'Legal first name',
                                  hintStyle: TextStyle(color: textLabelColor),
                                  // labelStyle: TextStyle(color: textLabelColor),
                                  focusColor: borderColor,
                                  // errorText: "error_msg"
                                ),
                                style: TextStyle(color: borderColor, fontSize: 14),

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
                              TextField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
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
                                  hintText: 'Legal last name',
                                  hintStyle: TextStyle(color: textLabelColor),
                                  // labelStyle: TextStyle(color: textLabelColor),
                                  focusColor: borderColor,
                                  // errorText: "error_msg"
                                ),
                                style: TextStyle(color: borderColor, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget("Mobile number"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
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
                            hintText: "+971 | Mobile number",
                            hintStyle: TextStyle(color: textLabelColor),
                            // labelStyle: TextStyle(color: textLabelColor),
                            focusColor: borderColor,
                            // errorText: "error_msg"
                          ),
                          style: TextStyle(color: borderColor, fontSize: 14),
                        ),

                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget("Email"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),

                        TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
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
                            hintText: "rose.matthews@mail.com",
                            hintStyle: TextStyle(color: textLabelColor),
                            // labelStyle: TextStyle(color: textLabelColor),
                            focusColor: borderColor,
                            // errorText: "error_msg"
                          ),
                          style: TextStyle(color: borderColor, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget("Password"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        TextField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
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
                            hintText: '*********',
                            hintStyle: TextStyle(color: textLabelColor),
                            // labelStyle: TextStyle(color: textLabelColor),
                            focusColor: borderColor,
                            suffixIcon: IconButton(
                              icon: Icon(
                                // _obscureText ? Icons.visibility_off : Icons.visibility,
                                  _obscureText ?  Icons.visibility :Icons.visibility_off,
                                  color: textLabelColor),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(color: borderColor, fontSize: 14),
                        ),

                        // TextFormField(
                        //   keyboardType: TextInputType.text,
                        //   style: TextStyle(color: borderColor),
                        //   // controller: passwordControllerLogin,
                        //   obscureText: _obscureText,
                        //   // maxLength: 15,
                        //   decoration: InputDecoration(
                        //     labelText: '*********',
                        //     hintText: '*********',
                        //     enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(30.0),
                        //         borderSide: BorderSide(color: textLabelColor)
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(30.0),
                        //         borderSide: BorderSide(color: borderColor)
                        //     ),
                        //     border: OutlineInputBorder(
                        //         borderSide: BorderSide(color: textLabelColor),
                        //         borderRadius: BorderRadius.circular(30)
                        //     ),
                        //     labelStyle: TextStyle(color: textLabelColor),
                        //     hintStyle: TextStyle(color: borderColor),
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
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return "Please Enter Password";
                        //     }
                        //     return null;
                        //   },
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
