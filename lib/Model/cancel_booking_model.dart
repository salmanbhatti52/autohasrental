import 'dart:convert';

CancelBookingModel cancelBookingModelFromJson(String str) => CancelBookingModel.fromJson(json.decode(str));

String cancelBookingModelToJson(CancelBookingModel data) => json.encode(data.toJson());

class CancelBookingModel {
  String? status;
  Data? data;
  String? message;

  CancelBookingModel({
    this.status,
    this.data,
    this.message,
  });

  factory CancelBookingModel.fromJson(Map<String, dynamic> json) => CancelBookingModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  int? bookingsId;
  int? carsId;
  int? usersCustomersId;
  String? stripeId;
  String? totalCost;
  String? drivingLicense;
  dynamic companyLocation;
  int? plansMileageId;
  DateTime? bookingsDate;
  String? status;

  Data({
    this.bookingsId,
    this.carsId,
    this.usersCustomersId,
    this.stripeId,
    this.totalCost,
    this.drivingLicense,
    this.companyLocation,
    this.plansMileageId,
    this.bookingsDate,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookingsId: json["bookings_id"],
    carsId: json["cars_id"],
    usersCustomersId: json["users_customers_id"],
    stripeId: json["stripe_id"],
    totalCost: json["total_cost"],
    drivingLicense: json["driving_license"],
    companyLocation: json["company_location"],
    plansMileageId: json["plans_mileage_id"],
    bookingsDate: json["bookings_date"] == null ? null : DateTime.parse(json["bookings_date"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_id": bookingsId,
    "cars_id": carsId,
    "users_customers_id": usersCustomersId,
    "stripe_id": stripeId,
    "total_cost": totalCost,
    "driving_license": drivingLicense,
    "company_location": companyLocation,
    "plans_mileage_id": plansMileageId,
    "bookings_date": bookingsDate?.toIso8601String(),
    "status": status,
  };
}
