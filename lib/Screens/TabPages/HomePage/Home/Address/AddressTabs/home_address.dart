import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../../Widget/TextFields/address_text_field.dart';
import '../../../../../../Widget/colors.dart';
import '../../../../../../Widget/fontFamily.dart';
import '../../../../../Authentication/ForgetPassword/myTextWidget.dart';


class HomeAddressPage extends StatefulWidget {
  const HomeAddressPage({Key? key}) : super(key: key);

  @override
  State<HomeAddressPage> createState() => _HomeAddressPageState();
}

class _HomeAddressPageState extends State<HomeAddressPage> {
  String _country = 'United Kingdom';

  // Initial Selected Value
  String dropdownvalue = 'Select state';

  // List of items in our dropdown menu
  var items = [
    'Select state',
    'Select state 1',
    'Select state 2',
    'Select state 3',
    'Select state 4',
    'Select state 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            buildTextFields(),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                changePasswordTextWidget("State"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                Container(
                  height: MediaQuery.of(context).size.height *0.06,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, ),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: DropdownButton(
                        // Initial Value
                        value: dropdownvalue,
                        // hint: Text("Select state", style: TextStyle(color: textLabelColor, fontFamily: poppinRegular,
                        // ),
                        // ),

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                changePasswordTextWidget("Country"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      exclude: <String>['KN', 'MF'],
                      //Optional. Shows phone code before the country name.
                      showPhoneCode: true,
                      showWorldWide: false,
                      onSelect: (Country country) {
                        print('Select country: ${country.displayName}');

                        setState(() {
                          _country = country.name;
                        });
                      },
                      // Optional. Sets the theme for the country list picker.
                      countryListTheme: CountryListThemeData(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                        // Optional. Styles the search field.
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      margin: const EdgeInsets.only(left: 0, right: 0),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _country.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              Container(
                                //padding: EdgeInsets.only(right: 6),
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width * 0.07,
                                decoration: const BoxDecoration(
                                  // color: Colors.black12,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(4),
                                        bottomRight: Radius.circular(4))),
                                child: const Icon(Icons.keyboard_arrow_down_outlined),
                              ),
                            ]),
                      )),
                ),

              ],
            ),


            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  // color: borderColor,
                  color: const Color(0xffD4DCE1),
                  borderRadius: BorderRadius.circular(30)),
              child: const Center(
                child: Text("Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFields() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Form(
                // key: loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("Street address Line 1"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AddressTextUtils().getCustomEditTextArea(
                            hintValue: "Street address line 1",
                            validation: true,
                            // autoFocus: true,
                            // textController: resetEmailController,
                            keyboardType: TextInputType.text,
                          ),

                          // TextField(
                          //   keyboardType: TextInputType.text,
                          //   decoration: InputDecoration(
                          //     border: InputBorder.none,
                          //     contentPadding: const EdgeInsets.all(20),
                          //     focusedBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(30.0),
                          //         borderSide: BorderSide(color: borderColor)
                          //     ),
                          //     hintText: 'Street address line 1',
                          //     hintStyle: TextStyle(color: textLabelColor),
                          //     // labelStyle: TextStyle(color: textLabelColor),
                          //     focusColor: borderColor,
                          //     // errorText: "error_msg"
                          //     fillColor: kWhite,
                          //
                          //     // prefixIcon:
                          //   ),
                          //   style: TextStyle(color: borderColor, fontSize: 14),
                          // ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        changePasswordTextWidget("Street address Line 2"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AddressTextUtils().getCustomEditTextArea(
                            hintValue: "Street address line 2",
                            validation: true,
                            // autoFocus: true,
                            // textController: resetEmailController,
                            keyboardType: TextInputType.text,
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              changePasswordTextWidget("City"),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: AddressTextUtils().getCustomEditTextArea(
                                  hintValue: "City",
                                  validation: true,
                                  // autoFocus: true,
                                  // textController: resetEmailController,
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              changePasswordTextWidget("Post Code"),

                              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: AddressTextUtils().getCustomEditTextArea(
                                  hintValue: "Post Code",
                                  validation: true,
                                  // autoFocus: true,
                                  // textController: resetEmailController,
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
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
