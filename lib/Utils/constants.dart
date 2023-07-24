import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
String? userId, userEmail;
String? currentDay;
// String? currentDate;
String? dropdownValueTime = timeHoursList.first;
String dropdownValuePackage = 'Select Package';
DateTime? pickDate;
String? valueDate;
// String? valueDay;
// String evStartDate = "Start Date";

// String evEndDate = "End Date";
int? evSelectedMonth, selectedMonthDays;
int? tabNewValue;
int count = 0;
String? evSelectedMonthDiscountedPrice;
double? evSelectedMonthTotalPrice = 0.0;
int? carID;

// double serviceFee = 50.0;
double? myServiceFee;
double? percentage = 6;

List timeHoursList = [
  '6 hours',
  '24 hours',
  '72 hours',
];

List daysPackageList = [
  '1 day',
  '3 day',
  '7 day',
];
