// To parse this JSON data, do
//
//     final topRentedCarsModel = topRentedCarsModelFromJson(jsonString);

import 'dart:convert';

TopRentedCarsModel topRentedCarsModelFromJson(String str) => TopRentedCarsModel.fromJson(json.decode(str));

String topRentedCarsModelToJson(TopRentedCarsModel data) => json.encode(data.toJson());

class TopRentedCarsModel {
  TopRentedCarsModel({
    this.status,
    this.data,
  });

  String? status;
  List<Datum>? data;

  factory TopRentedCarsModel.fromJson(Map<String, dynamic> json) => TopRentedCarsModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.carsId,
    this.usersCompaniesId,
    this.carsTypeId,
    this.carsMakesId,
    this.carsModelsId,
    this.year,
    this.vehicalName,
    this.licensePlate,
    this.rentCostDay,
    this.rentCostMonth,
    this.oldRentCostDay,
    this.oldRentCostMonth,
    this.discountPercentage,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.description,
    this.features,
    this.rating,
    this.dateAdded,
    this.dateModified,
    this.status,
    this.totalBookings,
    this.carsMakes,
    this.carsModels,
    this.carsRatings,
  });

  int? carsId;
  int? usersCompaniesId;
  int? carsTypeId;
  int? carsMakesId;
  int? carsModelsId;
  int? year;
  String? vehicalName;
  String? licensePlate;
  String? rentCostDay;
  String? rentCostMonth;
  String? oldRentCostDay;
  String? oldRentCostMonth;
  String? discountPercentage;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  String? description;
  String? features;
  String? rating;
  DateTime? dateAdded;
  DateTime? dateModified;
  String? status;
  int? totalBookings;
  CarsM? carsMakes;
  CarsM? carsModels;
  List<dynamic>? carsRatings;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    carsId: json["cars_id"],
    usersCompaniesId: json["users_companies_id"],
    carsTypeId: json["cars_type_id"],
    carsMakesId: json["cars_makes_id"],
    carsModelsId: json["cars_models_id"],
    year: json["year"],
    vehicalName: json["vehical_name"],
    licensePlate: json["license_plate"],
    rentCostDay: json["rent_cost_day"],
    rentCostMonth: json["rent_cost_month"],
    oldRentCostDay: json["old_rent_cost_day"],
    oldRentCostMonth: json["old_rent_cost_month"],
    discountPercentage: json["discount_percentage"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    image4: json["image4"],
    image5: json["image5"],
    description: json["description"],
    features: json["features"],
    rating: json["rating"],
    dateAdded: DateTime.parse(json["date_added"]),
    dateModified: DateTime.parse(json["date_modified"]),
    status: json["status"],
    totalBookings: json["total_bookings"],
    carsMakes: CarsM.fromJson(json["cars_makes"]),
    carsModels: CarsM.fromJson(json["cars_models"]),
    carsRatings: List<dynamic>.from(json["cars_ratings"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "cars_id": carsId,
    "users_companies_id": usersCompaniesId,
    "cars_type_id": carsTypeId,
    "cars_makes_id": carsMakesId,
    "cars_models_id": carsModelsId,
    "year": year,
    "vehical_name": vehicalName,
    "license_plate": licensePlate,
    "rent_cost_day": rentCostDay,
    "rent_cost_month": rentCostMonth,
    "old_rent_cost_day": oldRentCostDay,
    "old_rent_cost_month": oldRentCostMonth,
    "discount_percentage": discountPercentage,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "image5": image5,
    "description": description,
    "features": features,
    "rating": rating,
    "date_added": dateAdded!.toIso8601String(),
    "date_modified": dateModified!.toIso8601String(),
    "status": status,
    "total_bookings": totalBookings,
    "cars_makes": carsMakes!.toJson(),
    "cars_models": carsModels!.toJson(),
    "cars_ratings": List<dynamic>.from(carsRatings!.map((x) => x)),
  };
}

class CarsM {
  CarsM({
    this.carsMakesId,
    this.name,
    this.status,
    this.carsModelsId,
  });

  int? carsMakesId;
  String? name;
  String? status;
  int? carsModelsId;

  factory CarsM.fromJson(Map<String, dynamic> json) => CarsM(
    carsMakesId: json["cars_makes_id"],
    name: json["name"],
    status: json["status"],
    carsModelsId: json["cars_models_id"] == null ? null : json["cars_models_id"],
  );

  Map<String, dynamic> toJson() => {
    "cars_makes_id": carsMakesId,
    "name": name,
    "status": status,
    "cars_models_id": carsModelsId == null ? null : carsModelsId,
  };
}
