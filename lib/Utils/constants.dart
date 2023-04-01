import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
String? userId, userEmail;
String? currentDay;
// String? currentDate;
String dropdownValueTime = 'Select Hours';
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

double serviceFee = 50.0;

List timeHoursList = [
  'Select Hours', '1 hour', '2 hour', '3 hour', '4 hour',
  '5 hour', '6 hour', '7 hour', '8 hour', '9 hour',
  '10 hour', '11 hour', '12 hour', '13 hour', '14 hour',
  '15 hour', '16 hour', '17 hour', '18 hour', '19 hour',
  '20 hour', '21 hour', '22 hour', '23 hour', '24 hour'];
