import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Model/Auth/forget_password_model.dart';
import '../../../../Widget/TextFields/text_form_field.dart';
import '../../../../Widget/toast_message.dart';
import '../../../TabPages/MyAppBarHeader/app_bar_header.dart';
import 'myTextWidget.dart';
import 'set_new_password_page.dart';
import 'package:http/http.dart' as http;

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var resetEmailController = TextEditingController();
  ForgetPasswordModel forgetPasswordModel = ForgetPasswordModel();

  resetPasswordWidget() async {
    try {
      String apiUrl = forgetPasswordApiUrl;
      print("api: $apiUrl");
      print("email: ${resetEmailController.text}");
      final response = await http.post(Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json'
        },
        body: {
          'email': resetEmailController.text,
        },
      );
      final responseString = response.body;
      print("resetPasswordResponse: $responseString");

      print("status Code forgetModel: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("in 200 resetPassModel");
        // print("resS $responseString");
        if (responseString != 'false') {
          forgetPasswordModel = forgetPasswordModelFromJson(responseString);
          setState(() {});
          print('forgetModel status: ${forgetPasswordModel.status}');
        }
      }
    } catch (e) {
      print('forgetModel error in catch = ${e.toString()}');
      return null;
    }
  }

  bool progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: const MyAppBarSignUp(title: "Reset Password"),
      body: ModalProgressHUD(
        inAsyncCall: progress,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                // Text("Reset Password", textAlign: TextAlign.center,
                //   style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Bold', color: kWhite),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                SvgPicture.asset('assets/splash/login_image.svg', fit: BoxFit.fill,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Enter the email address associated with your account. We'll send you a link to reset your password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontFamily: poppinRegular, color: kWhite),),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                buildTextFields(),

                SizedBox(height: MediaQuery.of(context).size.height * 0.07),

                GestureDetector(
                    onTap: () async {
                      if(loginFormKey.currentState!.validate()){
                        if (resetEmailController.text.isEmpty) {
                          toastFailedMessage('email cannot be empty', Colors.red);
                        } else{
                          setState(() {
                            progress = true;
                          });
                          await resetPasswordWidget();
                          if (forgetPasswordModel.status == "success") {
                            print("reset Success");
                            Future.delayed(const Duration(seconds: 3), () {
                              toastSuccessMessage("${forgetPasswordModel.status}", Colors.green);

                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => SetNewPasswordPage(
                                    email: resetEmailController.text,
                                    verifyCode: forgetPasswordModel.data!.otp.toString(),
                                  )));
                              print("resetEmail: ${resetEmailController.text}");
                              print("resetCode: ${forgetPasswordModel.data!.otp.toString()}");

                              setState(() {
                                progress = false;
                              });
                              print("false: $progress");
                            });
                          }
                          if (forgetPasswordModel.status != "success") {
                            setState(() {
                              progress = false;
                            });
                            print("forgetPasswordModel: loginError");
                            toastFailedMessage("forgetPasswordModel", Colors.red);
                          }
                        }
                      }

                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> const SetNewPasswordPage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: loginButton("Send Reset Link", context),
                    )),
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

                    EditTextUtils().getCustomEditTextArea(
                      hintValue: "rose.matthews@mail.com",
                      validation: true,
                      // autoFocus: true,
                      textController: resetEmailController,
                      keyboardType: TextInputType.emailAddress,
                      // errorTextMsg: "Please Enter Email",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
