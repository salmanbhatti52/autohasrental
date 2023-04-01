import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/TextFields/address_text_field.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Widget/myTextWidget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_state_picker/country_state_picker.dart';
import 'package:flutter/material.dart';
import 'CartDetails/photo_cart_details.dart';

class PhotoBillingAddress extends StatefulWidget {
  final String? amount, myDate, myDay, selectedHours,
      selectedStartTime, selectedEndTime;
  final int? totalHoursInNumber;
  final double? hoursAmount, totalAmount;

  final String? carName, carImage, carYear, carPrice, favouriteStatus,
      carColorName, carModelName, carMakesName, carMakesImage,
      carRating, carOwnerImage, carOwnerName, discountPercentage, carDiscountPrice,
      homeStreetAddress1, homeStreetAddress2, homeCity, homePostCode,
      homeSelectedState, homeSelectedCountry;
  final int? carId, carOwnerId;

  const PhotoBillingAddress(
      {Key? key, this.myDate, this.myDay, this.totalHoursInNumber,
        this.selectedHours, this.hoursAmount, this.totalAmount,
        this.selectedStartTime, this.selectedEndTime, this.amount,
        this.carName, this.carColorName, this.carModelName, this.discountPercentage,
        this.carDiscountPrice, this.carImage, this.carYear, this.carMakesImage,
        this.favouriteStatus, this.carMakesName, this.carId, this.carPrice, this.carRating,
        this.carOwnerId, this.carOwnerImage, this.carOwnerName, this.homeCity,
        this.homeStreetAddress1, this.homeStreetAddress2,
        this.homePostCode, this.homeSelectedState, this.homeSelectedCountry}) : super(key: key);

  @override
  State<PhotoBillingAddress> createState() => _PhotoBillingAddressState();
}

class _PhotoBillingAddressState extends State<PhotoBillingAddress> {
  final GlobalKey<FormState> billingAddressFormKey = GlobalKey<FormState>();
  var streetAddressLineOneController = TextEditingController();
  var streetAddressLineTwoController = TextEditingController();
  var cityController = TextEditingController();
  var postCodeController = TextEditingController();

  String? billingState, billingCountry;

  // String _country = 'United Kingdom';
  //
  // // Initial Selected Value
  // String dropdownValue = 'Select state';
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

  mySelectedData() {
    print("carDiscountAmount2: ${widget.amount}");
    print("carDayDate2: ${widget.myDay} ${widget.myDate}");
    print("carMakersName2: ${widget.totalHoursInNumber}");
    print("carStartEndTime2: ${widget.selectedStartTime} ${widget.selectedEndTime}");
    print("carHours2: ${widget.selectedHours} ${widget.hoursAmount} ${widget.totalAmount}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySelectedData();
  }

  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              children: <Widget>[
                Theme(
                  data: ThemeData(
                    unselectedWidgetColor: const Color(0xffD4DCE1),
                  ),
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
                  child: Text(
                    'My billing address is different from my home address',
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: TextStyle(
                      color: textLabelColor,
                      fontSize: 12,
                      fontFamily: poppinRegular,
                    ),
                  ),
                ), //Text
              ], //<Widget>[]
            ),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.09),
            checkBoxValue == false
                ? Column(
                    children: [
                      Image.asset(
                        "assets/home_page/empty-cart.png",
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhotoCartDetailsPage(
                                    amount: widget.amount,
                                    selectedHours: widget.selectedHours,
                                    hoursAmount: widget.hoursAmount,
                                    totalAmount: widget.totalAmount,
                                    selectedStartTime: widget.selectedStartTime,
                                    selectedEndTime: widget.selectedEndTime,
                                    myDate: widget.myDate,
                                    myDay: widget.myDay,
                                    totalHoursInNumber: widget.totalHoursInNumber,

                                    carName: widget.carName,
                                    carYear: widget.carYear,
                                    carId: widget.carId,
                                    carRating: widget.carRating,
                                    carColorName: widget.carColorName,
                                    carMakesName: widget.carMakesName,
                                    carModelName: widget.carModelName,
                                    carImage: widget.carImage,
                                    carMakesImage: widget.carMakesImage,
                                    favouriteStatus: widget.favouriteStatus,
                                    discountPercentage: widget.discountPercentage,
                                    carDiscountPrice: widget.carDiscountPrice,
                                    carPrice: widget.carPrice,
                                    carOwnerImage: widget.carOwnerImage,
                                    carOwnerName: widget.carOwnerName,
                                    carOwnerId: widget.carOwnerId,


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
                          child: const Center(
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
                  )
                : Column(
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
                      //     SizedBox(
                      //         height:
                      //             MediaQuery.of(context).size.height * 0.005),
                      //     Container(
                      //       height: MediaQuery.of(context).size.height * 0.06,
                      //       width: MediaQuery.of(context).size.width,
                      //       decoration: BoxDecoration(
                      //           color: kWhite,
                      //           borderRadius: BorderRadius.circular(30)),
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 10,
                      //       ),
                      //       child: DropdownButtonHideUnderline(
                      //         child: Padding(
                      //           padding: const EdgeInsets.only(left: 10),
                      //           child: DropdownButton(
                      //             // Initial Value
                      //             value: dropdownValue,
                      //             // hint: Text("Select state", style: TextStyle(color: textLabelColor, fontFamily: poppinRegular,
                      //             // ),
                      //             // ),
                      //
                      //             // Down Arrow Icon
                      //             icon: const Icon(Icons.keyboard_arrow_down),
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
                      //                 dropdownValue = newValue!;
                      //               });
                      //             },
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //     height: MediaQuery.of(context).size.height * 0.02),
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
                      //             print(
                      //                 'Select country: ${country.displayName}');
                      //
                      //             setState(() {
                      //               _country = country.name;
                      //             });
                      //           },
                      //           // Optional. Sets the theme for the country list picker.
                      //           countryListTheme: CountryListThemeData(
                      //             borderRadius: const BorderRadius.only(
                      //               topLeft: Radius.circular(40.0),
                      //               topRight: Radius.circular(40.0),
                      //             ),
                      //             // Optional. Styles the search field.
                      //             inputDecoration: InputDecoration(
                      //               labelText: 'Search',
                      //               hintText: 'Start typing to search',
                      //               prefixIcon: const Icon(Icons.search),
                      //               border: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                   color: const Color(0xFF8C98A8)
                      //                       .withOpacity(0.2),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //       child: Container(
                      //           padding: const EdgeInsets.only(left: 10),
                      //           height:
                      //               MediaQuery.of(context).size.height * 0.06,
                      //           width: MediaQuery.of(context).size.width,
                      //           decoration: BoxDecoration(
                      //               color: kWhite,
                      //               borderRadius: BorderRadius.circular(30)),
                      //           margin:
                      //               const EdgeInsets.only(left: 0, right: 0),
                      //           alignment: Alignment.centerLeft,
                      //           child: Padding(
                      //             padding: const EdgeInsets.symmetric(
                      //                 horizontal: 10),
                      //             child: Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceBetween,
                      //                 children: [
                      //                   Text(
                      //                     _country.toString(),
                      //                     style: const TextStyle(fontSize: 16),
                      //                   ),
                      //                   Container(
                      //                     //padding: EdgeInsets.only(right: 6),
                      //                     alignment: Alignment.center,
                      //                     height: MediaQuery.of(context)
                      //                         .size
                      //                         .height,
                      //                     width: MediaQuery.of(context)
                      //                             .size
                      //                             .width *
                      //                         0.07,
                      //                     decoration: const BoxDecoration(
                      //                         // color: Colors.black12,
                      //                         borderRadius: BorderRadius.only(
                      //                             topRight: Radius.circular(4),
                      //                             bottomRight:
                      //                                 Radius.circular(4))),
                      //                     child: const Icon(Icons
                      //                         .keyboard_arrow_down_outlined),
                      //                   ),
                      //                 ]),
                      //           )),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhotoCartDetailsPage(
                                      amount: widget.amount,
                                      selectedHours: widget.selectedHours,
                                      hoursAmount: widget.hoursAmount,
                                      totalAmount: widget.totalAmount,
                                      selectedStartTime: widget.selectedStartTime,
                                      selectedEndTime: widget.selectedEndTime,
                                      myDate: widget.myDate,
                                      myDay: widget.myDay,
                                      totalHoursInNumber: widget.totalHoursInNumber,

                                      carName: widget.carName,
                                      carYear: widget.carYear,
                                      carId: widget.carId,
                                      carRating: widget.carRating,
                                      carColorName: widget.carColorName,
                                      carMakesName: widget.carMakesName,
                                      carModelName: widget.carModelName,
                                      carImage: widget.carImage,
                                      carMakesImage: widget.carMakesImage,
                                      favouriteStatus: widget.favouriteStatus,
                                      discountPercentage: widget.discountPercentage,
                                      carDiscountPrice: widget.carDiscountPrice,
                                      carPrice: widget.carPrice,
                                      carOwnerImage: widget.carOwnerImage,
                                      carOwnerName: widget.carOwnerName,
                                      carOwnerId: widget.carOwnerId,


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
        padding: const EdgeInsets.symmetric(horizontal: 0),
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
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
                            textController: streetAddressLineOneController,
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
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
                            textController: streetAddressLineTwoController,
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
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: AddressTextUtils().getCustomEditTextArea(
                                  hintValue: "City",
                                  validation: true,
                                  // autoFocus: true,
                                  textController: cityController,
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textWidgetBlack("Post Code"),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: AddressTextUtils().getCustomEditTextArea(
                                  hintValue: "Post Code",
                                  validation: true,
                                  // autoFocus: true,
                                  textController: postCodeController,
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
