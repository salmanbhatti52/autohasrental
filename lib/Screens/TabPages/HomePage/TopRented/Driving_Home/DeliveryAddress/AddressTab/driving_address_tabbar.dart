import 'billing_address.dart';
import 'package:flutter/material.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/myTextWidget.dart';
import 'package:country_state_picker/country_state_picker.dart';
import 'package:auto_haus_rental_app/Widget/TextFields/address_text_field.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/top_rented_cars_model.dart';

class DrivingAddressTabBar extends StatefulWidget {
  final String? startTime, endTime, selectedDate;
  final double? totalPrice, selectedSlotPrice;
  final DatumTopRented? myDatum;

  DrivingAddressTabBar(
      {Key? key,
      this.selectedDate,
      this.totalPrice,
      this.selectedSlotPrice,
      this.myDatum,
      this.startTime,
      this.endTime})
      : super(key: key);

  @override
  State<DrivingAddressTabBar> createState() => _DrivingAddressTabBarState();
}

abstract class TickerProvider {}

class _DrivingAddressTabBarState extends State<DrivingAddressTabBar>
    with SingleTickerProviderStateMixin {
  mySelectedData() {
    print("carDayDate: ${widget.selectedDate}");
    print("carTotalPrice: ${widget.totalPrice}");
    print("carStartEndTime: ${widget.startTime} ${widget.endTime}");
  }
  String? selectedCountry, selectedState ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySelectedData();
    tabController = TabController(length: 2, vsync: this);
  }

  TabController? tabController;
  List<String> tabs = [
    "Home Address",
    "Billing Address",
  ];
  int selectedIndex = 0;

  final GlobalKey<FormState> homeAddressFormKey = GlobalKey<FormState>();
  var address1ControllerHome = TextEditingController();
  var address2ControllerHome = TextEditingController();
  var cityControllerHome = TextEditingController();
  var postCodeControllerHome = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              decoration: BoxDecoration(
                  color: Color(0xffd4dce1),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: EdgeInsets.all(05),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  indicatorColor: kWhite,
                  automaticIndicatorColorAdjustment: false,
                  labelColor: kBlack,
                  labelStyle: TextStyle(fontSize: 12),
                  unselectedLabelColor: kBlack,
                  tabs: [
                    Tab(
                      text: "Home Address",
                    ),
                    Tab(
                      text: "Billing Address",
                    ),
                  ],
                ),
              )),
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.8,
          child: TabBarView(
            controller: tabController,
            children: [
              /// HomeAddress
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      buildTextFields(),

                      // IMPLEMENT WIDGET
                      CountryStatePicker(
                        onCountryChanged: (ct) => setState(() {
                          selectedCountry = ct;
                          selectedState = null;
                          print("country $selectedCountry");
                        }),
                        onStateChanged: (st) => setState(() {
                          selectedState = st;
                          print("state $selectedState");
                        }),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      GestureDetector(
                        onTap: () {
                          final newIndex = tabController!.index + 1;
                          tabController!.animateTo(newIndex);
                          print('newIndex $newIndex');
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              color: kRed,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text("Next",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BillingAddress(
                selectedSlotPrice: widget.selectedSlotPrice,
                myDatum: widget.myDatum,
                startTime: widget.startTime,
                endTime: widget.endTime,
                selectedDate: widget.selectedDate,
                totalPrice: widget.totalPrice,

                homeStreetAddress1: address1ControllerHome.text,
                homeStreetAddress2: address2ControllerHome.text,
                homeCity: cityControllerHome.text,
                homePostCode: postCodeControllerHome.text,
                homeSelectedState: selectedState,
                homeSelectedCountry: selectedCountry,
              ),
            ],
          ),
        ),
      ],
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
                key: homeAddressFormKey,
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
                            textController: address1ControllerHome,
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
                            textController: address2ControllerHome,
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
                                  textController: cityControllerHome,
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
                                  textController: postCodeControllerHome,
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
        ),
    );
  }
}
