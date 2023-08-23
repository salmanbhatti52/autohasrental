import 'package:flutter/material.dart';
import 'CartDetails/cart_details.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/myTextWidget.dart';
import 'package:country_state_picker/country_state_picker.dart';
import 'package:auto_haus_rental_app/Widget/TextFields/address_text_field.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/top_rented_cars_model.dart';

class BillingAddress extends StatefulWidget {
  final String? startTime, endTime, selectedDate,
      homeStreetAddress1, homeStreetAddress2, homeCity, homePostCode,
      homeSelectedState, homeSelectedCountry;
  final double? totalPrice, selectedSlotPrice;
  final DatumTopRented? myDatum;

  BillingAddress({Key? key, this.selectedDate, this.selectedSlotPrice,
    this.totalPrice, this.myDatum, this.startTime, this.endTime,
    this.homeStreetAddress1, this.homeStreetAddress2,
    this.homeCity, this.homePostCode, this.homeSelectedState, this.homeSelectedCountry
  }) : super(key: key);

  @override
  State<BillingAddress> createState() => _BillingAddressState();
}

class _BillingAddressState extends State<BillingAddress> {

  final GlobalKey<FormState> billingAddressFormKey = GlobalKey<FormState>();
  var address1ControllerBilling = TextEditingController();
  var address2ControllerBilling = TextEditingController();
  var cityControllerBilling = TextEditingController();
  var postCodeControllerBilling = TextEditingController();

  // String selectedCountryBilling = 'United Kingdom';
  //
  // // Initial Selected Value
  // String selectedStateBilling = 'Select state';
  //
  // // List of items in our dropdown menu
  // var items = [
  //   'Select state',
  //   'Select state 1',
  //   'Select state 2',
  //   'Select state 3',
  //   'Select state 4',
  //   'Select state 5',
  // ];
  mySelectedData(){
    print("carDayDate: ${widget.selectedDate}");
    print("carStartEndTime: ${widget.startTime} ${widget.endTime}");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySelectedData();
  }
  bool checkBoxValue = false;
  String? billingState, billingCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              children: <Widget>[
                Theme(
                  data: ThemeData(unselectedWidgetColor: Color(0xffD4DCE1),),
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: Colors.transparent,
                  child: Text('My billing address is different from my home address', textAlign: TextAlign.left,
                    maxLines: 2,
                    style: TextStyle(color: textLabelColor, fontSize: 12, fontFamily: poppinRegular,),
                  ),
                ), //Text
              ], //<Widget>[]
            ),

           checkBoxValue == false?
            Column(
              children: [
                Image.asset("assets/home_page/empty-cart.png",),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CartDetails(
                      myDatum: widget.myDatum,
                      selectedSlotPrice: widget.selectedSlotPrice,
                      startTime: widget.startTime,
                      endTime: widget.endTime,
                      selectedDate: widget.selectedDate,
                      totalPrice: widget.totalPrice,

                          homeAddress1: widget.homeStreetAddress1,
                          homeAddress2: widget.homeStreetAddress2,
                          homeCity: widget.homeCity,
                          homePostCode: widget.homePostCode,
                          homeState: widget.homeSelectedState,
                          homeCountry: widget.homeSelectedCountry,

                          billingAddress1: widget.homeStreetAddress1,
                          billingAddress2: widget.homeStreetAddress2,
                          billingCity: widget.homeCity,
                          billingPostCode: widget.homePostCode,
                          billingState: widget.homeSelectedState,
                          billingCountry: widget.homeSelectedCountry,
                        )));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                        color: kRed,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text("Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ):

            Column(
              children: [
                buildTextFields(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                CountryStatePicker(
                  onCountryChanged: (ct) => setState(() {
                    billingCountry = ct;
                    billingState = null;
                    print("country $billingCountry");
                  }),
                  onStateChanged: (st) => setState(() {
                    billingState = st;
                    print("state $billingState");
                  }),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     textWidgetBlack("State"),
                //     SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                //     Container(
                //       height: MediaQuery.of(context).size.height *0.06,
                //       width: MediaQuery.of(context).size.width,
                //       decoration: BoxDecoration(
                //           color: kWhite,
                //           borderRadius: BorderRadius.circular(30)
                //       ),
                //       padding: EdgeInsets.symmetric(horizontal: 10, ),
                //       child: DropdownButtonHideUnderline(
                //         child: Padding(
                //           padding: EdgeInsets.only(left: 10),
                //           child: DropdownButton(
                //             // Initial Value
                //             value: selectedStateBilling,
                //             // hint: Text("Select state", style: TextStyle(color: textLabelColor, fontFamily: poppinRegular,
                //             // ),
                //             // ),
                //
                //             // Down Arrow Icon
                //             icon: Icon(Icons.keyboard_arrow_down),
                //
                //             // Array list of items
                //             items: items.map((String items) {
                //               return DropdownMenuItem(
                //                 value: items,
                //                 child: Text(items),
                //               );
                //             }).toList(),
                //             // After selecting the desired option,it will
                //             // change button value to selected value
                //             onChanged: (String? newValue) {
                //               setState(() {
                //                 selectedStateBilling = newValue!;
                //               });
                //             },
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                //
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     textWidgetBlack("Country"),
                //     SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                //     GestureDetector(
                //       onTap: () {
                //         showCountryPicker(
                //           context: context,
                //           exclude: <String>['KN', 'MF'],
                //           //Optional. Shows phone code before the country name.
                //           showPhoneCode: true,
                //           showWorldWide: false,
                //           onSelect: (Country country) {
                //             print('Select country: ${country.displayName}');
                //
                //             setState(() {
                //               selectedCountryBilling = country.name;
                //             });
                //           },
                //           // Optional. Sets the theme for the country list picker.
                //           countryListTheme: CountryListThemeData(
                //             borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(40.0),
                //               topRight: Radius.circular(40.0),
                //             ),
                //             // Optional. Styles the search field.
                //             inputDecoration: InputDecoration(
                //               labelText: 'Search',
                //               hintText: 'Start typing to search',
                //               prefixIcon: Icon(Icons.search),
                //               border: OutlineInputBorder(
                //                 borderSide: BorderSide(
                //                   color:
                //                   Color(0xFF8C98A8).withOpacity(0.2),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         );
                //       },
                //       child: Container(
                //           padding: EdgeInsets.only(left: 10),
                //           height: MediaQuery.of(context).size.height * 0.06,
                //           width: MediaQuery.of(context).size.width,
                //           decoration: BoxDecoration(
                //               color: kWhite,
                //               borderRadius: BorderRadius.circular(30)
                //           ),
                //           margin: EdgeInsets.only(left: 0, right: 0),
                //           alignment: Alignment.centerLeft,
                //           child: Padding(
                //             padding: EdgeInsets.symmetric(horizontal: 10),
                //             child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Text(
                //                     selectedCountryBilling.toString(),
                //                     style: TextStyle(fontSize: 16),
                //                   ),
                //                   Container(
                //                     //padding: EdgeInsets.only(right: 6),
                //                     alignment: Alignment.center,
                //                     height: MediaQuery.of(context).size.height,
                //                     width: MediaQuery.of(context).size.width * 0.07,
                //                     decoration: BoxDecoration(
                //                       // color: Colors.black12,
                //                         borderRadius: BorderRadius.only(
                //                             topRight: Radius.circular(4),
                //                             bottomRight: Radius.circular(4))),
                //                     child: Icon(Icons.keyboard_arrow_down_outlined),
                //                   ),
                //                 ]),
                //           )),
                //     ),
                //
                //   ],
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CartDetails(
                            myDatum: widget.myDatum,
                            selectedSlotPrice: widget.selectedSlotPrice,
                            startTime: widget.startTime,
                            endTime: widget.endTime,
                            selectedDate: widget.selectedDate,
                            totalPrice: widget.totalPrice,

                            homeAddress1: widget.homeStreetAddress1,
                            homeAddress2: widget.homeStreetAddress2,
                            homeCity: widget.homeCity,
                            homePostCode: widget.homePostCode,
                            homeState: widget.homeSelectedState,
                            homeCountry: widget.homeSelectedCountry,

                            billingAddress1: address1ControllerBilling.text,
                            billingAddress2: address2ControllerBilling.text,
                            billingCity: cityControllerBilling.text,
                            billingPostCode: postCodeControllerBilling.text,
                            billingState: billingState,
                            billingCountry: billingCountry,
                          )));
                    },
                    child: loginButton("Save", context)),
              ],
            ),


          ],
        ),
      ),
    );
  }
  Widget buildTextFields() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Form(
                key: billingAddressFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidgetBlack("Street address Line 1"),
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
                            textController: address1ControllerBilling,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidgetBlack("Street address Line 2"),
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
                            textController: address2ControllerBilling,
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
                              textWidgetBlack("City"),
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
                                  textController: cityControllerBilling,
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
                              textWidgetBlack("Post Code"),

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
                                  textController: postCodeControllerBilling,
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
