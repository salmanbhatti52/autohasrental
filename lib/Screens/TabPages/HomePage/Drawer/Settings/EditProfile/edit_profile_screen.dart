import 'dart:convert';
import 'dart:io';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../Model/update_profile_model.dart';
import '../../../../../../Utils/api_urls.dart';
import '../../../../../../Utils/colors.dart';
import '../../../../../../Widget/TextFields/address_text_field.dart';
import '../../../../../../Widget/toast_message.dart';
import '../../../../../Authentication/LoginPage/ForgetPassword/myTextWidget.dart';
import '../../../../MyAppBarHeader/app_bar_header.dart';
import '../settings_screen.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> updateProfileFormKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var aboutController = TextEditingController();
  var emailController = TextEditingController();
  var locationController = TextEditingController();

  File? image;

  Future pickCoverImage() async {
    try {
      final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (selectedImage == null) return;
      final imageTemporary = File(selectedImage.path);
      setState(() {
        image = imageTemporary;
        print("newImage $image");
        // onUploadImage();
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }

  UpdateProfileModel updateProfileModel = UpdateProfileModel();

  var resJson;
  bool loader = false;
  updateUserWidget() async {
    setState(() {
      loader = true;
    });
    var request = http.MultipartRequest('POST', Uri.parse(updateProfileApiUrl));
    Map<String, String>  headers = {
      'Accept': 'application/json'
    };

    print("apiRequest: $request");
    request.fields['users_customers_id'] = userId!;
    request.fields['first_name'] = firstNameController.text;
    request.fields['last_name'] = lastNameController.text;
    request.fields['phone'] = '03001234567';
    request.fields['email'] = emailController.text;
    request.fields['notifications'] = 'Yes';
    request.files.add(
      http.MultipartFile(
        'profile_pic',
        image!.readAsBytes().asStream(),
        image!.lengthSync(),
        filename: image!.path.split('/').last,
      ),
    );

    // request.files.add(http.MultipartFile.fromBytes('profile_pic',
    //     await File.fromUri("<path/to/file>").readAsBytes(),
    //     contentType: MediaType('image', 'jpeg')));


    request.headers.addAll(headers);
    print("request: $request");
    var res = await request.send();

    http.Response response = await http.Response.fromStream(res);
    resJson = jsonDecode(response.body);
    print("jsonResponse $resJson");
    print("responseStatusCode ${response.statusCode}");
    // response.stream

    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });

    setState(() {
      loader = false;
    });
  }

  bool loading = true;
  SharedPreferences? prefs;

  String? userId;
  sharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");
  }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  bool progress = false;
  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarSingleImage(
        title: "Edit Profile", backImage: "assets/messages_images/Back.png",),
      body:ModalProgressHUD(
        inAsyncCall: progress,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: kWhite,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: kWhite, width: 3)),
                        child: CircleAvatar(
                          radius: (screenWidth > 600) ? 90 : 70,
                          backgroundColor: Colors.transparent,
                          backgroundImage: image == null?
                          const AssetImage("assets/home_page/user.png",)
                              : Image.file(image!, height: 50, width: 50, fit: BoxFit.contain,).image,
                        ),
                      ),

                      Positioned(
                        right: 0,
                        bottom: 18,
                        child: GestureDetector(
                            onTap: (){
                              pickCoverImage();
                            },
                            child: Image.asset("assets/payment_card_images/edit_profile_icon.png")),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

              buildTextFields(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

              GestureDetector(
                onTap:() async {

                  if(updateProfileFormKey.currentState!.validate()){
                    if (firstNameController.text.isEmpty) {
                      toastFailedMessage('firstName cannot be empty', Colors.red);
                    } else if (lastNameController.text.isEmpty) {
                      toastFailedMessage('lastName cannot be empty',Colors.red);
                    } else if (emailController.text.isEmpty) {
                      toastFailedMessage('email cannot be empty',Colors.red);
                    }
                    else{
                      setState(() {
                        progress = true;
                      });
                      await updateUserWidget();
                      if (updateProfileModel.status == "success") {
                        print("LogIn Success");
                        Future.delayed(const Duration(seconds: 3), () {
                          toastSuccessMessage("updated Successfully...!", Colors.green);

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => const SettingsScreen()));

                          setState(() {
                            progress = false;
                          });
                          print("false: $progress");
                        });
                      }
                      if (updateProfileModel.status != "success") {
                        setState(() {
                          progress = false;
                        });
                        print("updateProfileModel");
                        toastFailedMessage("updateProfile Error", Colors.red);
                      }
                    }
                  }

                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                },
                  child: loginButton("Update", context)),
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
                key: updateProfileFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("First Name"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AddressTextUtils().getCustomEditTextArea(
                            hintValue: "John",
                            validation: true,
                            // autoFocus: true,
                            textController: firstNameController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("Last Name"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AddressTextUtils().getCustomEditTextArea(
                            hintValue: "Doe",
                            validation: true,
                            // autoFocus: true,
                            textController: lastNameController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("About"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AddressTextUtils().getCustomEditTextArea(
                            hintValue: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam.",
                            validation: true,
                            // autoFocus: true,
                            textController: aboutController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("Email"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AddressTextUtils().getCustomEditTextArea(
                            hintValue: "rose.matthews@mail.com",
                            validation: true,
                            // autoFocus: true,
                            textController: emailController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("Location"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AddressTextUtils().getCustomEditTextArea(
                            hintValue: "Enter your location here",
                            validation: true,
                            // autoFocus: true,
                            textController: locationController,
                            keyboardType: TextInputType.text,
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
