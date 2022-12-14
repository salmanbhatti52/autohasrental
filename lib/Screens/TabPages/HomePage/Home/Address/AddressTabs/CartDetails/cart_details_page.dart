import 'package:flutter/material.dart';
import '../../../../../../../Widget/TextFields/address_text_field.dart';
import '../../../../../../../Widget/TextFields/text_form_field.dart';
import '../../../../../../../Widget/button.dart';
import '../../../../../../../Utils/colors.dart';
import '../../../../../../../Utils/fontFamily.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../../../../Widget/myTextWidget.dart';
import '../../../../../MyAppBarHeader/app_bar_header.dart';

class CartDetailsPage extends StatefulWidget {

  final String? carImage, discountPercentage, carName, carModel, amount, carRatings;
  final int? carYear, discountedAmount;
  const CartDetailsPage({Key? key,
    this.carImage, this.discountPercentage,
    this.carName, this.carModel, this.carYear, this.carRatings,
    this.amount, this.discountedAmount}) : super(key: key);

  @override
  State<CartDetailsPage> createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {

  var emailController = TextEditingController();

  mySelectedData(){
    print("carName3: ${widget.carName}");
    print("carImage3: ${widget.carImage}");
    print("carDiscount3: ${widget.discountPercentage}");
    print("carModel3: ${widget.carModel}");
    print("carYear3: ${widget.carYear}");
    print("carDiscountAmount3: ${widget.discountedAmount}");
    print("carAmount3: ${widget.amount}");
    print("carRatings3: ${widget.carRatings}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySelectedData();
  }

  // Initial Selected Value
  String dropdownValue = 'Select state';

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
      appBar: const MyAppBarSingleImage(
        title: "Cart Details",
        backImage: "assets/messages_images/Back.png",
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    top: 70,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.62,
                        width: MediaQuery.of(context).size.width * 0.47,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.13),
                              Row(
                                children: [
                                  Text("${widget.carName} | ", textAlign: TextAlign.left,
                                    style: TextStyle(color: kBlack,
                                      fontSize: 14, fontFamily: poppinBold)),
                                  Text("MODEL", textAlign: TextAlign.left,
                                    style: TextStyle(color: kBlack,
                                      fontSize: 12, fontFamily: poppinRegular)),
                                  Text("${widget.carModel} ", textAlign: TextAlign.left,
                                      style: TextStyle(color: kBlack,
                                          fontSize: 14, fontFamily: poppinMedium)),
                                  Text("${widget.carYear}", textAlign: TextAlign.left,
                                      style: TextStyle(color: kBlack,
                                          fontSize: 10, fontFamily: poppinRegular)),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 04),
                                    child: Text("RM ", textAlign: TextAlign.left,
                                      style: TextStyle(color: kRed,
                                          fontSize: 5, fontFamily: poppinLight)),
                                  ),
                                  Text("${widget.amount}", textAlign: TextAlign.left,
                                    style: TextStyle(color: kRed,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 10, fontFamily: poppinLight),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 06),
                                    child: Text("RM ", textAlign: TextAlign.left,
                                      style: TextStyle(color: borderColor,
                                          fontSize: 7, fontFamily: poppinSemiBold)),
                                  ),
                                  Text("${widget.discountedAmount}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: borderColor,
                                        fontSize: 20, fontFamily: poppinSemiBold)),
                                  Text("/ Month", textAlign: TextAlign.left,
                                    style: TextStyle(color: kBlack,
                                        fontSize: 8, fontFamily: poppinRegular),
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Row(
                                children: [
                                  Image.asset("assets/home_page/Promoted.png"),
                                  const SizedBox(width: 05),
                                  Text("Verified Dealer", textAlign: TextAlign.left,
                                    style: TextStyle(color: textLabelColor,
                                      fontSize: 10, fontFamily: poppinRegular)),
                                  const SizedBox(width: 05,),
                                  Container(
                                    height: 20, width: 40,
                                    decoration: BoxDecoration(
                                        color: kBlack,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Center(
                                      child: Text("New", textAlign: TextAlign.left,
                                        style: TextStyle(color: kWhite,
                                            fontSize: 8, fontFamily: poppinRegular)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                      Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.height * 0.01),

                                      widget.carRatings == null?
                                      Text("0.0", textAlign: TextAlign.left,
                                        style: TextStyle(color: kBlack,
                                            fontSize: 12, fontFamily: poppinRegular)):
                                      Text("${widget.carRatings}", textAlign: TextAlign.left,
                                          style: TextStyle(color: kBlack,
                                              fontSize: 12, fontFamily: poppinRegular))
                                    ],
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.height * 0.2),
                                  Container(
                                    height: 25, width: 80,
                                    decoration: BoxDecoration(
                                        color: kBlack,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Center(
                                      child: Text("Pre book", textAlign: TextAlign.left,
                                        style: TextStyle(color: kWhite,
                                            fontSize: 12, fontFamily: poppinMedium)),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 05),
                                child: Divider(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Subscription Plan ", textAlign: TextAlign.left,
                                    style: TextStyle(color: kBlack,
                                        fontSize: 14, fontFamily: poppinSemiBold)),
                                  Text("12 Months Plan", textAlign: TextAlign.right,
                                    style: TextStyle(color: kBlack,
                                        fontSize: 14, fontFamily: poppinRegular)),
                                ],
                              ),
                              // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       "Mileage Packages ",
                              //       textAlign: TextAlign.left,
                              //       style: TextStyle(
                              //         color: kBlack,
                              //         fontSize: 14,
                              //         fontFamily: poppinMedium,
                              //       ),
                              //     ),
                              //     Text(
                              //       "Lite - 120KM pr month",
                              //       textAlign: TextAlign.right,
                              //       style: TextStyle(
                              //           color: kBlack,
                              //           fontSize: 14,
                              //           fontFamily: poppinRegular),
                              //     ),
                              //   ],
                              // ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 05),
                                child: Divider(),
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text("Start Fee",
                              //         textAlign: TextAlign.left,
                              //         style: TextStyle(
                              //             color: kBlack,
                              //             fontSize: 14,
                              //             fontFamily: poppinMedium)),
                              //     Text("RM 8,471.94",
                              //         textAlign: TextAlign.right,
                              //         style: TextStyle(
                              //             color: kBlack,
                              //             fontSize: 14,
                              //             fontFamily: poppinMedium)),
                              //   ],
                              // ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("12 Months Plan", textAlign: TextAlign.left,
                                    style: TextStyle(color: textLabelColor,
                                        fontSize: 14, fontFamily: poppinRegular)),
                                  Text("RM 8,120.00", textAlign: TextAlign.right,
                                    style: TextStyle(color: textLabelColor,
                                        fontSize: 14, fontFamily: poppinRegular)),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       "Lite Package - 1,250KM",
                              //       textAlign: TextAlign.left,
                              //       style: TextStyle(
                              //           color: textLabelColor,
                              //           fontSize: 14,
                              //           fontFamily: poppinRegular),
                              //     ),
                              //     Text(
                              //       "RM 0.00",
                              //       textAlign: TextAlign.right,
                              //       style: TextStyle(
                              //           color: textLabelColor,
                              //           fontSize: 14,
                              //           fontFamily: poppinRegular),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Service Fee (6%)",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: textLabelColor,
                                        fontSize: 14, fontFamily: poppinRegular)),
                                  Text("RM 487.20", textAlign: TextAlign.right,
                                    style: TextStyle(color: textLabelColor,
                                        fontSize: 14, fontFamily: poppinRegular)),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Monthly Total Fee", textAlign: TextAlign.left,
                                    style: TextStyle(color: kBlack,
                                        fontSize: 16, fontFamily: poppinSemiBold)),
                                  Text("RM 8,607.20", textAlign: TextAlign.right,
                                    style: TextStyle(color: kBlack,
                                        fontSize: 16, fontFamily: poppinSemiBold)),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Center(
                                child: Text(
                                  "*A security deposit may be applicable, depending on your eligibility assessment.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 12,
                                      fontFamily: poppinRegular, color: borderColor)),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.03,
                                  width: MediaQuery.of(context).size.width *0.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: borderColor)),
                                  child: Center(
                                      child: Text("Edit", textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12,
                                              fontFamily: poppinRegular, color: borderColor))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Image.network("${widget.carImage}", width: 400, height: 150),
                  ),
                  Positioned(
                      top: 10, left: 20,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.06,
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("5% ", textAlign: TextAlign.left,
                              style: TextStyle(color: kWhite,
                                  fontSize: 13, fontFamily: poppinSemiBold)),
                            Text("OFF ", textAlign: TextAlign.left,
                                style: TextStyle(color: kWhite,
                                    fontSize: 8, fontFamily: poppinRegular)),
                          ],
                        ),
                      )),
                  Positioned(
                      top: 10, right: 20,
                      child: Image.asset("assets/home_page/heart_transparent.png", color: kBlack),
                  ),
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  showMaterialModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => SingleChildScrollView(
                      controller: ModalScrollController.of(context),
                      child: Container(
                        decoration: BoxDecoration(
                            color: homeBgColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: kBlack,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/payment_card_images/apple_image.png",
                                        color: kWhite),
                                      const SizedBox(width: 10),
                                      Text("Pay", textAlign: TextAlign.center,  
                                          style: TextStyle(color: kWhite,
                                              fontFamily: poppinRegular, fontSize: 18)),
                                    ],
                                  ),
                                ),
                              ),
                              Text("Or pay with card",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: detailsTextColor,
                                      fontFamily: poppinSemiBold, fontSize: 16)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWidgetBlack("Email"),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                  EditTextUtils().getCustomEditTextArea(
                                    hintValue: "rose.matthews@mail.com",
                                    validation: true,
                                    // autoFocus: true,
                                    // textController: firstNameController,
                                    keyboardType: TextInputType.text,
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWidgetBlack("Card Information"),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.06,
                                    decoration: BoxDecoration(
                                      color: kWhite,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.all(20),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                            borderSide: BorderSide(color: borderColor)),
                                        hintText: 'xxxx xxxx xxxx xxxx',
                                        hintStyle: TextStyle(color: textLabelColor),
                                        focusColor: borderColor,
                                        fillColor: kWhite,
                                        prefixIcon: Image.asset("assets/payment_card_images/card_prefix.png"),
                                        suffixIcon: Image.asset("assets/payment_card_images/visa_icon.png",),
                                      ),
                                      style: TextStyle(
                                          color: borderColor, fontSize: 14),
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
                                        textWidgetBlack("Expire date"),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                        Container(
                                          height: MediaQuery.of(context).size.height * 0.06,
                                          decoration: BoxDecoration(
                                            color: kWhite,
                                            borderRadius: BorderRadius.circular(30.0)),
                                          child: TextField(
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: const EdgeInsets.all(20),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(30.0),
                                                  borderSide: BorderSide(color: borderColor)),
                                              hintText: 'MM/YY',
                                              hintStyle: TextStyle(color: textLabelColor),
                                              focusColor: borderColor,
                                              prefixIcon: Image.asset("assets/payment_card_images/calendar.png",),
                                            ),
                                            style: TextStyle(color: borderColor, fontSize: 14),
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
                                        textWidgetBlack("CVC"),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                        Container(
                                          height: MediaQuery.of(context).size.height * 0.06,
                                          decoration: BoxDecoration(
                                            color: kWhite,
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          child: TextField(
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: const EdgeInsets.all(20),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(30.0),
                                                  borderSide: BorderSide(color: borderColor)),
                                              hintText: 'CVC',
                                              hintStyle: TextStyle(color: textLabelColor),
                                              focusColor: borderColor,
                                              prefixIcon: Image.asset("assets/payment_card_images/cvc.png"),
                                            ),
                                            style: TextStyle(color: borderColor, fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWidgetBlack("Country or Region"),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.06,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(30)),
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        // Initial Value
                                        value: dropdownValue,
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
                                            dropdownValue = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWidgetBlack("Zip"),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.06,
                                    decoration: BoxDecoration(
                                      color: kWhite,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: AddressTextUtils().getCustomEditTextArea(
                                      hintValue: "Select state",
                                      validation: true,
                                      // autoFocus: true,
                                      // textController: resetEmailController,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          color: const Color(0xffb0b0b0),
                                          child: Container(
                                            color: const Color(0xffb0b0b0),
                                            child: Container(
                                              color: const Color(0xff0f172a).withOpacity(0.5),
                                              child: Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: homeBgColor,
                                                      borderRadius: BorderRadius.circular(20)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                              },
                                                              child:
                                                                  Image.asset("assets/payment_card_images/cancle.png"),
                                                            ),
                                                          ],
                                                        ),
                                                        Image.asset("assets/payment_card_images/alert_dialog_image.png"),
                                                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                        Text("Congratulation!", textAlign: TextAlign.center,
                                                          style: TextStyle(color: borderColor,
                                                            fontSize: 24, fontFamily: poppinSemiBold)),
                                                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                        Text("Your Ride is Booked.", textAlign: TextAlign.center,
                                                          style: TextStyle(color: textLabelColor,
                                                              fontSize: 20, fontFamily: poppinMedium)),
                                                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                                        GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                            },
                                                            child: loginButton("Okay", context)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: loginButton("Pay", context),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: loginButton("Check out", context)),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
