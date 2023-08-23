
import 'photo_billing_address.dart';
import 'package:flutter/material.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/myTextWidget.dart';
import 'package:country_state_picker/country_state_picker.dart';
import 'package:auto_haus_rental_app/Widget/TextFields/address_text_field.dart';

class PhotoAddressTabBar extends StatefulWidget {

  final String? amount, myDate, myDay, selectedHours, selectedStartTime, selectedEndTime;
  final int? totalHoursInNumber;
  final double? hoursAmount, totalAmount;
  final String? carName, carImage, carYear, carPrice, favouriteStatus,
      carColorName, carModelName, carMakesName, carMakesImage,
      carRating, carOwnerImage, driverCharges, carDeposit, carOwnerName, discountPercentage, carDiscountPrice;
  final int? carId, carOwnerId;

  PhotoAddressTabBar({Key? key,
    this.selectedHours, this.myDate, this.myDay, this.totalHoursInNumber,
    this.hoursAmount, this.carDeposit, this.totalAmount, this.selectedStartTime, this.selectedEndTime,
    this.amount,this.driverCharges, this.carName, this.carColorName, this.carModelName, this.discountPercentage,
    this.carDiscountPrice, this.carImage, this.carYear, this.carMakesImage,
    this.favouriteStatus, this.carMakesName, this.carId, this.carPrice, this.carRating,
    this.carOwnerId, this.carOwnerImage, this.carOwnerName
  }): super(key: key);

  @override
  State<PhotoAddressTabBar> createState() => _PhotoAddressTabBarState();
}

abstract class TickerProvider {}

class _PhotoAddressTabBarState extends State<PhotoAddressTabBar> with SingleTickerProviderStateMixin {

  mySelectedData(){
    print("carOriginalAmount1: ${widget.amount}");
    print("carDayDate1: ${widget.myDay} ${widget.myDate}");
    print("carMakersName1: ${widget.totalHoursInNumber}");
    print("carStartEndTime1: ${widget.selectedStartTime} ${widget.selectedEndTime}");
    print("carHours1: ${widget.selectedHours} ${widget.hoursAmount} ${widget.totalAmount}");
  }
  String? selectedCountry, selectedState ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    mySelectedData();

  }
  TabController? tabController;
  List<String> tabs = ["Home Address", "Billing Address",];
  int selectedIndex = 0;

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
          height: MediaQuery.of(context).size.height*0.8,
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
                      InkWell(
                        onTap: (){
                          final newIndex = tabController!.index + 1;
                          tabController!.animateTo(newIndex);
                          // myFunction(widget.totalAmount, widget.favouriteStatus, widget.carName, widget.carImage,
                          //     widget.carYear, widget.carPrice, widget.carColorName,
                          //     widget.carModelName, widget.carMakesName, widget.carMakesImage, widget.carRating,
                          //     address2ControllerHome.text, cityControllerHome.text, postCodeControllerHome.text, selectedState,
                          //     widget.carOwnerImage, widget.carOwnerName, widget.discountPercentage, address1ControllerHome.text,
                          //     selectedCountry, widget.carId, widget.carOwnerId, widget.carDiscountPrice);
                          print('newIndex $newIndex');
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              color: kRed,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text("Next", style: TextStyle(
                                color: Colors.white, fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400, fontSize: 18)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PhotoBillingAddress(
                // datumPhotography: widget.datumPhotography,
                amount: widget.amount,
                carDeposit: widget.carDeposit,
                driverCharges: widget.driverCharges,
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

  // myFunction(
  //     final double? totalAmount,
  //     final String? mySelectedTabMonth, mySelectedTabPrice, carName, carImage, carYear, carPrice,
  //     carColorName, carModelName, carMakesName, carMakesImage, favouriteStatus,
  //     carRating, carOwnerImage, carOwnerName, discountPercentage,
  //     homeStreetAddress1, homeStreetAddress2, homeCity, homePostCode,
  //     homeSelectedState, homeSelectedCountry, evStartDate, evEndDate,
  //     final int? carId, carOwnerId,
  //     final double? carDiscountPrice){
  //
  // }

  final GlobalKey<FormState> homeAddressFormKey = GlobalKey<FormState>();
  var address1ControllerHome = TextEditingController();
  var address2ControllerHome = TextEditingController();
  var cityControllerHome = TextEditingController();
  var postCodeControllerHome = TextEditingController();

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
        ));
  }

  // void myFunction(double? totalAmount,
  //     String? favouriteStatus, carName, carImage,
  //     carYear, carPrice, carColorName, carModelName,
  //     carMakesName, carMakesImage, carRating, text,
  //     text2, text3, selectedState, carOwnerImage,
  //     carOwnerName, discountPercentage, text4, selectedCountry,
  //     int? carId, int? carOwnerId, String? carDiscountPrice) {}
}
