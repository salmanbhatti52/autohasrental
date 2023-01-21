import 'dart:convert';
import 'dart:io';
import 'package:auto_haus_rental_app/Model/SettingsModel/ProfileModels/get_user_profile_model.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
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
    print("firstName: ${firstNameController.text}");
    print("lastName: ${lastNameController.text}");
    print("email: ${emailController.text}");
    print("profileImage: ${image!.path.split('/').last}");
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
    request.headers.addAll(headers);
    print("request: $request");
    var res = await request.send();

    http.Response response = await http.Response.fromStream(res);
    final resJson = jsonDecode(response.body);
    print("jsonResponse $resJson");
    print("responseStatusCode ${response.statusCode}");
    // response.stream

    // request.send().then((response) {
    //   if (response.statusCode == 200) print("Uploaded!");
    // });

    setState(() {
      loader = false;
    });
  }

  bool loading = true;

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
        // setData();
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
    // final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarSingleImage(
        title: "Edit Profile", backImage: "assets/messages_images/Back.png",),
      body: loader ? Center(child: CircularProgressIndicator(color: borderColor,)):
      getUserProfileModelObject.status != "success"? const Center(
        child: Text('no data found...',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ):
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
                          backgroundImage: image == null?
                          const AssetImage("assets/home_page/user.png",)
                              : Image.file(image!, height: 50, width: 50, fit: BoxFit.contain,).image,
                        ):
                        CircleAvatar(
                          radius: (screenWidth > 600) ? 90 : 70,
                          backgroundColor: Colors.transparent,
                          backgroundImage: image == null?
                          NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidgetBlack("About"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AddressTextUtils().getCustomEditTextArea(
                            // hintValue: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam.",
                            hintValue: getUserProfileModelObject.data!.about == null? "nothing to show":
                            getUserProfileModelObject.data!.about.toString(),
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
