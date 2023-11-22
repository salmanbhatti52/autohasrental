import 'package:flutter/material.dart';
import 'EvCartDetails/ev_cart_details_page.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/myTextWidget.dart';
import 'package:country_state_picker/country_state_picker.dart';
import 'package:auto_haus_rental_app/Widget/TextFields/address_text_field.dart';

class EvBillingAddress extends StatefulWidget {
  final String? mySelectedTabMonth, mySelectedTabPrice;
  final String? totalAmount, setupCost;
  final String? carName, carImage, carYear, carPrice, carStatus, carColorName,
      carModelName, carMakesName, carMakesImage, favouriteStatus, carRating,
      carOwnerImage, carOwnerName, discountPercentage,

  homeStreetAddress1, homeStreetAddress2, homeCity, homePostCode,
  homeSelectedState, homeSelectedCountry, evStartDate, evEndDate;
  final int? carId, carOwnerId,mileagePlanID;
  final String? carDiscountPrice;

  EvBillingAddress({Key? key, this.setupCost , this.mileagePlanID, this.homeStreetAddress1, this.homeStreetAddress2,
    this.favouriteStatus, this.homeCity, this.homePostCode, this.homeSelectedState,
    this.homeSelectedCountry, this.totalAmount, this.carName, this.carColorName,
    this.carModelName, this.carYear, this.discountPercentage, this.carDiscountPrice,
    this.carImage, this.carMakesImage, this.carStatus, this.carMakesName, this.carId,
    this.carPrice, this.carRating, this.carOwnerId, this.carOwnerImage, this.carOwnerName,
    this.evStartDate, this.evEndDate, this.mySelectedTabMonth, this.mySelectedTabPrice}) : super(key: key);

  @override
  State<EvBillingAddress> createState() => _EvBillingAddressState();
}

class _EvBillingAddressState extends State<EvBillingAddress> {

  final GlobalKey<FormState> billingAddressFormKey = GlobalKey<FormState>();
  var address1ControllerBilling = TextEditingController();
  var address2ControllerBilling = TextEditingController();
  var cityControllerBilling = TextEditingController();
  var postCodeControllerBilling = TextEditingController();
  String? billingState, billingCountry;

  mySelectedData(){
    print("homeStreetAddresses : ${widget.homeStreetAddress1} ${widget.homeStreetAddress2}");
    print("homeCity homePostCode: ${widget.homeCity} ${widget.homePostCode}");
    print("homeSelectedState homeSelectedCountry: ${widget.homeSelectedState} ${widget.homeSelectedCountry}");
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              children: <Widget>[
                Theme(
                  data: ThemeData(unselectedWidgetColor: Color(0xffD4DCE1)),
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
                Image.asset("assets/home_page/empty-cart.png"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                GestureDetector(
                  onTap: (){
                    print("homeStreetAddress1 ${widget.homeStreetAddress1}");
                    print("checkBoxValue ${checkBoxValue}");

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => EvCartDetailsPage(
                          // myDatum: widget.myDatum,
                          setupCost: widget.setupCost,
                          mileagePlanID: widget.mileagePlanID,
                          mySelectedTabMonth: widget.mySelectedTabMonth,
                          mySelectedTabPrice: widget.mySelectedTabPrice,
                          favouriteStatus: widget.favouriteStatus,
                          totalAmount: widget.totalAmount,
                          carName: widget.carName,
                          carImage: widget.carImage,
                          carYear: widget.carYear,
                          carPrice: widget.carPrice,
                          carDiscountPrice: widget.carDiscountPrice,
                          carRating: widget.carRating,
                          carColorName: widget.carColorName,
                          discountPercentage: widget.discountPercentage,
                          carStatus: widget.carStatus,
                          carId: widget.carId,
                          carOwnerId: widget.carOwnerId,
                          carMakesName: widget.carMakesName,
                          carModelName: widget.carModelName,
                          evStartDate: widget.evStartDate,
                          evEndDate: widget.evEndDate,

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

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => EvCartDetailsPage(
                            setupCost: widget.setupCost,
                            mySelectedTabMonth: widget.mySelectedTabMonth,
                            mySelectedTabPrice: widget.mySelectedTabPrice,
                            totalAmount: widget.totalAmount,
                            favouriteStatus: widget.favouriteStatus,
                            mileagePlanID: widget.mileagePlanID,
                            carName: widget.carName,
                            carImage: widget.carImage,
                            carYear: widget.carYear,
                            carPrice: widget.carPrice,
                            carDiscountPrice: widget.carDiscountPrice,
                            carRating: widget.carRating,
                            carColorName: widget.carColorName,
                            discountPercentage: widget.discountPercentage,
                            carStatus: widget.carStatus,
                            carId: widget.carId,
                            carOwnerId: widget.carOwnerId,
                            carMakesName: widget.carMakesName,
                            carModelName: widget.carModelName,
                            evStartDate: widget.evStartDate,
                            evEndDate: widget.evEndDate,

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
