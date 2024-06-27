import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
String? userId, userEmail;
String? currentDay;
String? dropdownValueTime = timeHoursList.first;
String dropdownValuePackage = 'Select Package';
DateTime? pickDate;
String? valueDating;

int? evSelectedMonth, selectedMonthDays;
int? tabNewValue;
int count = 0;
String? evSelectedMonthDiscountedPrice;
double? evSelectedMonthTotalPrice = 0.0;
int? carID;

double? myServiceFee;
double? percentage = 8;

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
