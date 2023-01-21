import 'dart:convert';

PhotographyCheckOutModel photographyCheckOutModelFromJson(String str) => PhotographyCheckOutModel.fromJson(json.decode(str));

String photographyCheckOutModelToJson(PhotographyCheckOutModel data) => json.encode(data.toJson());

class PhotographyCheckOutModel {
  PhotographyCheckOutModel({
    this.status,
    this.data,
  });

  String? status;
  Data? data;

  factory PhotographyCheckOutModel.fromJson(Map<String, dynamic> json) => PhotographyCheckOutModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.bookingsId,
    this.bookingsDate,
    this.carsId,
    this.usersCustomersId,
    this.totalCost,
    this.drivingLicense,
    this.status,
  });

  int? bookingsId;
  DateTime? bookingsDate;
  int? carsId;
  int? usersCustomersId;
  int? totalCost;
  String? drivingLicense;
  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookingsId: json["bookings_id"],
    bookingsDate: DateTime.parse(json["bookings_date"]),
    carsId: json["cars_id"],
    usersCustomersId: json["users_customers_id"],
    totalCost: json["total_cost"],
    drivingLicense: json["driving_license"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_id": bookingsId,
    "bookings_date": bookingsDate?.toIso8601String(),
    "cars_id": carsId,
    "users_customers_id": usersCustomersId,
    "total_cost": totalCost,
    "driving_license": drivingLicense,
    "status": status,
  };
}
