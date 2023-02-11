import 'dart:convert';
import 'dart:io';
import 'package:auto_haus_rental_app/Model/SettingsModel/ProfileModels/get_user_profile_model.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../Model/SettingsModel/ProfileModels/update_profile_model.dart';
import '../../../../../../Utils/api_urls.dart';
import '../../../../../../Utils/colors.dart';
import '../../../../../../Utils/constants.dart';
import '../../../../../../Widget/TextFields/address_text_field.dart';
import '../../../../../../Widget/myTextWidget.dart';
import '../../../../../../Widget/toast_message.dart';
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

  File? imageFile;

  String? base64img;
  final ImagePicker _picker = ImagePicker();
  Future pickCoverImage() async {
    try {
      final XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) return;

      Uint8List imageByte = await xFile.readAsBytes();
      base64img = base64.encode(imageByte);
      print("base64img $base64img");

      final imageTemporary = File(xFile.path);
      setState(() {
        imageFile = imageTemporary;
        print("newImage $imageFile");
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }

  UpdateProfileModel updateProfileModel = UpdateProfileModel();

  bool loader = false;

  sharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");
    getUserProfileWidget();
  }

  setData() {
    firstNameController.text = "${getUserProfileModelObject.data!.firstName}";
    lastNameController.text = "${getUserProfileModelObject.data!.lastName}";
    aboutController.text =  getUserProfileModelObject.data!.about == null? "no about": "${getUserProfileModelObject.data!.about}" ;
    emailController.text = "${getUserProfileModelObject.data!.email}";
    locationController.text = getUserProfileModelObject.data!.location == null? "no location": "${getUserProfileModelObject.data!.location}";

    print("firstName ${firstNameController.text}");
    print("lastName ${lastNameController.text}");
    print("aboutName ${aboutController.text}");
    print("emailName ${emailController.text}");
    print("locationName ${locationController.text}");
  }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  GetUserProfileModel getUserProfileModelObject = GetUserProfileModel();
  uploadUserProfileWidget() async {
    loader = true;
    setState(() {});
    try {
      String apiUrl = updateProfileApiUrl;
      print("updateUserProfileApi: $apiUrl");
      print("firstName: ${firstNameController.text}");
      print("lastName: ${lastNameController.text}");
      print("email: ${emailController.text}");
      print("profileImage: $base64img");

      final response = await http.post(Uri.parse(apiUrl),
          body: {
        "users_customers_id" : userId,
        "first_name" : firstNameController.text,
        "last_name" : lastNameController.text,
        "phone" : "03001234567",
        "email" : emailController.text,
        "notifications" : "Yes",
        "profile_pic" : base64img,
          },
          headers: {
            'Accept': 'application/json',
          });
      print('statusCode ${response.statusCode}');
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("updateUserProfileResponse: ${responseString.toString()}");
        updateProfileModel = updateProfileModelFromJson(responseString);
        print("getUserName: ${updateProfileModel.data}");
        print("updateUserProfileImage: $base64img");
      }
    } catch (e) {
      print('Error in updateUserProfile: ${e.toString()}');
    }
    loader = false;
    setState(() {
      setData();
    });
  }

  getUserProfileWidget() async {
    loader = true;
    setState(() {});
    try {
      String apiUrl = getUserProfileApiUrl;
      print("getUserProfileApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
        "users_customers_id" : userId,
          },
          headers: {
            'Accept': 'application/json'
          });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("getUserProfileResponse: ${responseString.toString()}");
        getUserProfileModelObject = getUserProfileModelFromJson(responseString);
        print("getUserName: ${getUserProfileModelObject.data!.lastName}");
        print("getUserProfileImage: $baseUrlImage${getUserProfileModelObject.data!.profilePic}");
      }
    } catch (e) {
      print('Error in getUserProfileWidget: ${e.toString()}');
    }
    loader = false;
    setState(() {
      setData();
    });
  }

  bool progress = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarSingleImage(
        title: "Edit Profile", backImage: "assets/messages_images/Back.png",),
      body: loader ? Center(child: CircularProgressIndicator(color: borderColor)):
      getUserProfileModelObject.status != "success"? const Center(
        child: Text('no data found...', style: TextStyle(fontWeight: FontWeight.bold))):
      ModalProgressHUD(
        inAsyncCall: progress,
        opacity: 0.02,
        blur: 0.5,
        color: Colors.transparent,
        progressIndicator: CircularProgressIndicator(
          color: borderColor),
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
                            border: Border.all(color: kWhite, width: 3)),
                        child: getUserProfileModelObject.data!.profilePic == null?
                        CircleAvatar(
                          radius: (screenWidth > 600) ? 90 : 70,
                          backgroundColor: Colors.transparent,
                          backgroundImage: imageFile == null?
                          const AssetImage("assets/icon/fade_in_image.jpeg",)
                              : Image.file(imageFile!, height: 50, width: 50, fit: BoxFit.contain,).image,
                        ):
                        CircleAvatar(
                          radius: (screenWidth > 600) ? 90 : 70,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                          imageFile == null?
                          NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)
                              : Image.file(imageFile!, height: 50, width: 50, fit: BoxFit.contain,).image,
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
                      // await updateUserWidget();
                      await uploadUserProfileWidget();
                      // if (updateProfileModel.status == "success") {
                        print("updated Success");
                        Future.delayed(const Duration(seconds: 3), () {
                          toastSuccessMessage("updated Successfully...!", Colors.green);

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => const SettingsScreen()));

                          setState(() {
                            progress = false;
                          });
                          print("false: $progress");
                        });
                      // }
                      // if (updateProfileModel.status != "success") {
                      //   setState(() {
                      //     progress = false;
                      //   });
                      //   print("updateProfileModel");
                      //   toastFailedMessage("updateProfile Error", Colors.red);
                      // }
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
                        textWidgetBlack("First Name"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AddressTextUtils().getCustomEditTextArea(
                            // hintValue: "John",
                            hintValue: getUserProfileModelObject.data!.firstName.toString(),
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
                        textWidgetBlack("Last Name"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AddressTextUtils().getCustomEditTextArea(
                            // hintValue: "Doe",
                            hintValue: getUserProfileModelObject.data!.lastName.toString(),
                            validation: true,
                            // autoFocus: true,
                            textController: lastNameController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     textWidgetBlack("About"),
                    //     SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                    //     Container(
                    //       decoration: BoxDecoration(
                    //         color: kWhite,
                    //         borderRadius: BorderRadius.circular(30.0),
                    //       ),
                    //       child: AddressTextUtils().getCustomEditTextArea(
                    //         hintValue: getUserProfileModelObject.data!.about == null? "nothing to show":
                    //         getUserProfileModelObject.data!.about.toString(),
                    //         validation: true,
                    //         textController: aboutController,
                    //         keyboardType: TextInputType.text,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidgetBlack("About"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),

                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            controller: aboutController,
                            cursorColor: borderColor,
                            keyboardType: TextInputType.text,
                            maxLength: 100,
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                              hintText: getUserProfileModelObject.data!.about == null? "nothing to show":
                              getUserProfileModelObject.data!.about.toString(),
                              fillColor: kWhite,
                              hintStyle: TextStyle(color: textLabelColor, fontFamily: poppinRegular),
                              focusColor: borderColor,
                              // errorText: errorTextMsg,
                            ),
                            style: TextStyle(color: borderColor, fontSize: 14),

                          )
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidgetBlack("Email"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AddressTextUtils().getCustomEditTextArea(
                            // hintValue: "rose.matthews@mail.com",
                            hintValue: getUserProfileModelObject.data!.email.toString(),
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
                        textWidgetBlack("Location"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AddressTextUtils().getCustomEditTextArea(
                            // hintValue: "Enter your location here",
                            hintValue: getUserProfileModelObject.data!.location == null? "no location":
                            getUserProfileModelObject.data!.location.toString(),
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
