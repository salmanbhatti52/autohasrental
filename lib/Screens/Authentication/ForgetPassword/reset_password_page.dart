import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Widget/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'myTextWidget.dart';
import 'new_password_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),

              Text("Reset Password", textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Bold', color: kWhite),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
              SvgPicture.asset('assets/splash/login_image.svg', fit: BoxFit.fill,),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Enter the email address associated with your account. We'll send you a link to reset your password.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins-Regular', color: kWhite),),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.05),

              buildTextFields(),

              SizedBox(height: MediaQuery.of(context).size.height * 0.07),

              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const NewPasswordPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: loginButton("Send Reset Link", context),
                  )),
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
          child: Form(
            key: loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget("Email"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.005),

                    TextField(
                      keyboardType: TextInputType.emailAddress,
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
              ],
            ),
          ),
        ));
  }
}
