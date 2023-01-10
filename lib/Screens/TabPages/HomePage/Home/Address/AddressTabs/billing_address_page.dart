import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import '../../../../../../Utils/colors.dart';
import '../../../../../../Utils/fontFamily.dart';
import '../../../../../../Widget/TextFields/address_text_field.dart';
import '../../../../../../Widget/myTextWidget.dart';
import 'CartDetails/cart_details_page.dart';

class BillingAddressPage extends StatefulWidget {

  final String? carImage, discountPercentage, carName, carModel, amount, carRatings;
  final int? carYear, discountedAmount;

  const BillingAddressPage({Key? key,
    this.carImage, this.discountPercentage,
    this.carName, this.carModel, this.carYear, this.carRatings,
    this.amount, this.discountedAmount}) : super(key: key);

  @override
  State<BillingAddressPage> createState() => _BillingAddressPageState();
}

class _BillingAddressPageState extends State<BillingAddressPage> {


  final GlobalKey<FormState> billingAddressFormKey = GlobalKey<FormState>();
  var streetAddressLineOneController = TextEditingController();
  var streetAddressLineTwoController = TextEditingController();
  var cityController = TextEditingController();
  var postCodeController = TextEditingController();

  String _country = 'United Kingdom';

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


  mySelectedData(){
    print("carName2: ${widget.carName}");
    print("carImage2: ${widget.carImage}");
    print("carDiscount2: ${widget.discountPercentage}");
    print("carModel2: ${widget.carModel}");
    print("carYear2: ${widget.carYear}");
    print("carDiscountAmount2: ${widget.discountedAmount}");
    print("carDiscountAmount2: ${widget.amount}");
    print("carRatings2: ${widget.carRatings}");
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              children: <Widget>[
                Theme(
                  data: ThemeData(unselectedWidgetColor: const Color(0xffD4DCE1),),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetailsPage(
                      carName: widget.carName,
                      carYear: widget.carYear,
                      carModel: widget.carModel,
                      carImage: widget.carImage,
                      discountedAmount: widget.discountedAmount,
                      amount: widget.amount,
                      discountPercentage: widget.discountPercentage,
                      carRatings: widget.carRatings,
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
            ):

            Column(
              children: [
                buildTextFields(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidgetBlack("State"),
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
                            value: dropdownValue,
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
                                dropdownValue = newValue!;
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
                    textWidgetBlack("Country"),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                loginButton("Save", context),
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
                                  textController: cityController,
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
