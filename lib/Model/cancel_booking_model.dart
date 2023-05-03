import 'dart:convert';

CancelBookingModel cancelBookingModelFromJson(String str) => CancelBookingModel.fromJson(json.decode(str));

String cancelBookingModelToJson(CancelBookingModel data) => json.encode(data.toJson());

class CancelBookingModel {
  CancelBookingModel({
    this.status,
    this.data,
    this.message,
  });

  String? status;
  String? message;
  List<Datum>? data;

  factory CancelBookingModel.fromJson(Map<String, dynamic> json) => CancelBookingModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.bookingsId,
    this.carsId,
    this.usersCustomersId,
    this.totalCost,
    this.drivingLicense,
    this.companyLocation,
    this.bookingsDate,
    this.status,
  });

  int? bookingsId;
  int? carsId;
  int? usersCustomersId;
  String? totalCost;
  String? drivingLicense;
  dynamic companyLocation;
  DateTime? bookingsDate;
  String? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    bookingsId: json["bookings_id"],
    carsId: json["cars_id"],
    usersCustomersId: json["users_customers_id"],
    totalCost: json["total_cost"],
    drivingLicense: json["driving_license"],
    companyLocation: json["company_location"],
    bookingsDate: DateTime.parse(json["bookings_date"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_id": bookingsId,
    "cars_id": carsId,
    "users_customers_id": usersCustomersId,
    "total_cost": totalCost,
    "driving_license": drivingLicense,
    "company_location": companyLocation,
    "bookings_date": bookingsDate!.toIso8601String(),
    "status": status,
  };
}
