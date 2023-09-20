import 'package:auto_haus_rental_app/Model/filter_car_by_attribute_model.dart';
import 'package:auto_haus_rental_app/Model/get_car_makes_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/tab_page.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../HomePageTopCard/EvSubscriptions/ev_subscription_page.dart';
import 'package:http/http.dart' as http;

class FilterScreen extends StatefulWidget {
   FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  GetCarMakesModel getCarMakesModelObject = GetCarMakesModel();
  FilterCarByAttributeModel filterCarByAttributeModelObject = FilterCarByAttributeModel();
  int? selectedCarMakesId, selectedCarsYear;
  String? selectedCarMakesName;
  // String? valueYear;
  String showYear = "";
  bool progress = false;
  bool bProgress = false;
  final GlobalKey<FormState> filterFormKey = GlobalKey<FormState>();

  getCarMakesListWidget() async {
    bProgress = true;
    setState(() {});
    print('in getCarMakesAPI');
    try {
      String apiUrl = getCarMakesApiUrl;
      print("getCarMakesApi: $apiUrl");
      final response = await http.get(Uri.parse(apiUrl));
      print('${response.statusCode}');
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("getCarMakesResponse: ${responseString.toString()}");
        getCarMakesModelObject = getCarMakesModelFromJson(responseString);
        print("getCarMakesName: ${getCarMakesModelObject.data![0].name}");
        print("getCarMakesId: ${getCarMakesModelObject.data![0].carsMakesId}");
        print("getCarMakesLength: ${getCarMakesModelObject.data!.length}");
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    bProgress = false;
    setState(() {});
  }
int BMW = 1;
  filterCarsWidget() async {
    progress = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    print('in filterCarsModelApi');
    print('users_customers_id $userId');
    print('cars_usage_type $dropdownCarType');
    print('cars_makes_id $selectedCarMakesId');
    print('year $showYear');
    print('BMW $BMW');
    print('rent_start $rangeStartPrice');
    print('rent_end $rangeEndPrice');
    // try {
    String apiUrl = topRentedCarsFilterApiUrl;
    print("filterCarsApi: $apiUrl");
    final response = await http.post(Uri.parse(apiUrl),
        body: {
          "users_customers_id" : userId,
          "cars_usage_type" : dropdownCarType,
          "cars_makes_id" : "${selectedCarMakesId != null ? selectedCarMakesId : BMW}",
          "year" : showYear,
          "rent_start" : "$rangeStartPrice",
          "rent_end" : "$rangeEndPrice",
          // "sort_column" : "cars_id",
          // "sort_order" : "DESC",
        },
        headers: {
          'Accept': 'application/json'
        });
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("filterCarsResponse: ${responseString.toString()}");
      filterCarByAttributeModelObject = filterCarByAttributeModelFromJson(responseString);
    }
    // } catch (e) {
    //   print('Error: ${e.toString()}');
    // }
    progress = false;
    setState(() {});
  }

  String? dropdownCarType;

  var items = ['EV Subscriptions'];

  bool clearFilters = false;
  void clearFilter() {
   setState(() {
     clearFilters = true;
   });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCarMakesListWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: ModalProgressHUD(
        inAsyncCall: progress,
        opacity: 0.02,
        blur: 0.5,
        color: Colors.transparent,
        progressIndicator: CircularProgressIndicator(
          color: borderColor,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: appBgColor,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   height: 30,
                //   child: Stack(
                //     children: [
                //       Positioned(
                //         left: 160,
                //         child: Text('Filter', textAlign: TextAlign.center,
                //           style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kWhite),),
                //       ),
                //       Positioned(
                //         // bottom:12,
                //         right: 15,
                //         child: TextButton(
                //           onPressed: (){
                //             clearFilter();
                //             Navigator.pushReplacement(context,
                //                 MaterialPageRoute(builder: (context) => TabBarPage(clearFilters: clearFilters,)));
                //           },
                //           child: Text('Clear Filter', textAlign: TextAlign.right,
                //             style: TextStyle(fontSize: 14,
                //                 fontFamily: poppinMedium, color: kWhite),),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                        Get.back();
                      }, icon: Image.asset('assets/live_chat_images/back_arrow.png',
                          color: Colors.white, height: 25, width: 25),),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text('Filter', textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kWhite),),
                      ),
          TextButton(
                      onPressed: (){
                        clearFilter();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => TabBarPage(clearFilters: clearFilters,)));
                      },
                      child: Text('Clear Filter', textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 14,
                            fontFamily: poppinMedium, color: kWhite),),
                    ),
                    ],
                  ),
                ),
                 SizedBox(height: 10),
                // Padding(
                //   padding:  EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Text('TESLA', textAlign: TextAlign.left,
                //         style: TextStyle(fontSize: 10,
                //             fontFamily: poppinRegular, color: kWhite),
                //       ),
                //        SizedBox(width: 5),
                //       Icon(Icons.close, color: borderColor, size: 10,),
                //        SizedBox(width: 10),
                //       Text('Low to High', textAlign: TextAlign.left,
                //         style: TextStyle(fontSize: 10,
                //             fontFamily: poppinRegular, color: kWhite),
                //       ),
                //        SizedBox(width: 5),
                //       Icon(Icons.close, color: borderColor, size: 10,),
                //        SizedBox(width: 10),
                //       Text('400 km to 800', textAlign: TextAlign.left,
                //         style: TextStyle(
                //             fontSize: 10,
                //             fontFamily: poppinRegular,
                //             color: kWhite),
                //       ),
                //        SizedBox(width: 5),
                //       Icon(
                //         Icons.close,
                //         color: borderColor,
                //         size: 10,
                //       ),
                //     ],
                //   ),
                // ),
                dividerWidget(),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Select Car make', textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: kWhite,
                        fontFamily: poppinBold,
                      ),
                    ),
                  ),
                ),
                 SizedBox(height: 10),

                buildTextFields(),

                SizedBox(height: Get.height* 0.15),
                GestureDetector(
                    onTap: () async {

                      print("dropdownValue $dropdownCarType");
                      print("valueYear $showYear");
                      print("rangeStartPrice $rangeStartPrice");
                      print("rangeEndPrice $rangeEndPrice");
                      print("selectedCarMakesId $selectedCarMakesId");
                      if(filterFormKey.currentState!.validate()){
                        if (rangeStartPrice == null) {
                          toastFailedMessage('Please select Your Start Price', Colors.red);
                        } else if (rangeEndPrice == null) {
                          toastFailedMessage('Please select Your End Price',Colors.red);
                        } else if (dropdownCarType == null) {
                          toastFailedMessage('CarType cannot be empty',Colors.red);
                        } else if (showYear == "") {
                          toastFailedMessage('Year cannot be empty',Colors.red);
                        } else{
                          setState(() {
                            progress = true;
                          });
                          await filterCarsWidget();

                          Future.delayed(Duration(seconds: 1), () {
                            if(filterCarByAttributeModelObject.status == "success"){
                              // for(int i = 0; i < filterCarByAttributeModelObject.data!.length; i++){
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) => TabBarPage(filterCarByAttributeModelObject: filterCarByAttributeModelObject,)));
                                setState(() {
                                  progress = false;
                                });
                                print("false: $progress");
                              // }
                            } else{
                              // toastFailedMessage("${filterCarByAttributeModelObject.message}", kRed);
                              toastFailedMessage("No Car Found", kRed);
                            }
                          });
                        }
                      }
                    },
                    child: loginButton('Apply', context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _selectYear(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2100),
  //     initialDatePickerMode: DatePickerMode.year,
  //   );
  //
  //   if (picked != null) {
  //     setState(() {
  //       valueYear = "${picked.year}";
  //       print("pickedYear ${picked.year}");
  //       print("pickedYear ${valueYear}");
  //     });
  //
  //   }
  // }

  DateTime _selectedYear = DateTime.now();

  selectYear(context) async {
    print("Calling date picker");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 10, 1),
              // lastDate: DateTime.now(),
              lastDate: DateTime(2025),
              initialDate: DateTime.now(),
              selectedDate: _selectedYear,
              onChanged: (DateTime dateTime) {
                print(dateTime.year);
                setState(() {
                  _selectedYear = dateTime;
                  showYear = "${dateTime.year}";
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  carMakersListWidget(){
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 08),
      child: bProgress? CircularProgressIndicator(color: borderColor):
      Container(
        height: MediaQuery.of(context).size.height* 0.1,
        color: Colors.transparent,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: getCarMakesModelObject.data?.length,
            itemBuilder: (context, index){
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedIndex = index;
                      selectedCarMakesId = getCarMakesModelObject.data?[selectedIndex].carsMakesId;
                      selectedCarMakesName = getCarMakesModelObject.data?[selectedIndex].name;
                      print("myIndex $index");
                      print("selectedIndex $selectedIndex");
                      print("selectedCarMakesName $selectedCarMakesName");
                      print("selectedCarMakesId $selectedCarMakesId");
                    });
                  },
                  child: Container(
                    height: 50, width: 70,
                    decoration: BoxDecoration(
                        color: selectedIndex == index? borderColor: kWhite,
                        border: Border.all(width: 2,
                            color: selectedIndex == index ? borderColor : kWhite),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Image.network("$baseUrlImage${getCarMakesModelObject.data?[index].image}",
                        height: 25, width: 25, fit: BoxFit.fill),
                  ),
                ),
              );
            }),
      ),
    );
  }

  RangeValues priceRangeValues =  RangeValues(800, 1800);
  String? rangeStartPrice, rangeEndPrice;
  priceRangeSliderWidget(){
    return SliderTheme(
      data: SliderThemeData(
        valueIndicatorColor: Colors.white,
        valueIndicatorTextStyle:
         TextStyle(fontSize: 12, color: Colors.black),
        trackHeight: 4,
        rangeThumbShape:
         RoundRangeSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
        overlayColor: borderColor.withOpacity(0.3),
        thumbColor: borderColor,
        activeTrackColor: borderColor,
        inactiveTrackColor:  Color(0xffd4dce1),
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
      ),
      child: RangeSlider(
        values: priceRangeValues,
        min: 0,
        max: 15000,
        divisions: 20,
        labels: RangeLabels(
          'RM ${priceRangeValues.start.round().toString()}',
          'RM ${priceRangeValues.end.round().toString()}',
        ),
        onChanged: (value) {
          setState(() {
            priceRangeValues = value;

            rangeStartPrice = value.start.toString();
            rangeEndPrice = value.end.toString();

            print('startPriceEndPrice: $rangeStartPrice $rangeEndPrice');
          });
        },
      ),
    );
  }
  dividerWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(
        color: Color(0xff3F4655),
        indent: 20,
        endIndent: 20,
      ),
    );
  }

  Widget buildTextFields() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width*0.02),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Form(
                key: filterFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    carMakersListWidget(),

                    dividerWidget(),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Price', textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: poppinBold,
                                color: kWhite),
                          ),
                          SizedBox(width: 10),
                          RichText(
                            text: TextSpan(
                              text: 'from RM ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: poppinMedium,
                                  color: borderColor),
                              children: [

                                rangeStartPrice == null?
                                TextSpan(
                                    text: '800',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: poppinMedium,
                                        color: Colors.white)):
                                TextSpan(
                                    text: '$rangeStartPrice',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: poppinMedium,
                                        color: Colors.white)),
                                TextSpan(
                                    text: 'to RM ',
                                    style: TextStyle(
                                        fontSize: 14, fontFamily: poppinMedium)),
                                rangeEndPrice == null?
                                TextSpan(
                                    text: '1800',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: poppinMedium,
                                        color: Colors.white)):
                                TextSpan(text: '$rangeEndPrice',
                                    style: TextStyle(fontSize: 14,
                                        fontFamily: poppinMedium,
                                        color: Colors.white)),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    priceRangeSliderWidget(),
                    // SizedBox(height: 10),
                    // ChooseFilterPrice(),
                    dividerWidget(),

                    // Padding(
                    //   padding:  EdgeInsets.symmetric(horizontal: 20),
                    //   child: Row(
                    //     children: [
                    //       Text('Mileage', textAlign: TextAlign.left,
                    //         style: TextStyle(fontSize: 16, fontFamily: poppinBold, color: kWhite),),
                    //        SizedBox(width: 10),
                    //       RichText(
                    //         text: TextSpan(
                    //           text: 'from KM ',
                    //           style: TextStyle(fontSize: 14, fontFamily: poppinMedium, color: borderColor),
                    //           children: [
                    //             TextSpan(
                    //                 text: '400 ',
                    //                 style: TextStyle(fontSize: 14, fontFamily: poppinMedium, color: Colors.white)),
                    //             TextSpan(
                    //                 text: 'to KM ',
                    //                 style: TextStyle(fontSize: 14, fontFamily: poppinMedium)),
                    //             TextSpan(
                    //                 text: '800',
                    //                 style: TextStyle(fontSize: 14, fontFamily: poppinMedium, color: Colors.white)),
                    //           ],
                    //         ),
                    //         textAlign: TextAlign.left,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    //  SizedBox(height: 10),
                    //  CustomRangeSlider2(),
                    //  SizedBox(height: 10),
                    //  ChooseFilterMileage(),
                    //  SizedBox(height: 10),
                    //  Divider(
                    //   color: Color(0xff3F4655),
                    //   indent: 20,
                    //   endIndent: 20,
                    // ),
                    SizedBox(height: 10),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Select CarType', style: TextStyle(color: kWhite),),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: DropdownButton(
                                  // Initial Value
                                  hint: Text('Select an option', style: TextStyle(color: kBlack),),
                                  value: dropdownCarType,
                                  icon: Icon(Icons.keyboard_arrow_down),
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
                                      dropdownCarType = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Car Year', textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 16, fontFamily: poppinBold, color: kWhite),
                          ),
                          SizedBox(height: 20),

                          GestureDetector(
                            onTap: () {
                              print("clicked...");
                              selectYear(context);
                            },
                            child: Container(
                              width: Get.width* 0.3,
                              height: Get.height* 0.04,
                              decoration: BoxDecoration(
                                  color: showYear == ""? kWhite: borderColor,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: kWhite)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(showYear == ""? "Select Year" : "$showYear", textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14, fontFamily: poppinSemiBold, color: showYear == ""? borderColor: kWhite)),
                                ],
                              ),
                            ),

                            // GestureDetector(
                            //   onTap: (){
                            //     _selectYear(context);
                            //   },
                            //
                            //   child: Text('Select Year', textAlign: TextAlign.left,
                            //     style: TextStyle(fontSize: 16, fontFamily: poppinBold, color: kWhite),
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
