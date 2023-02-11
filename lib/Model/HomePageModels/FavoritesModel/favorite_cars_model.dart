
import 'dart:convert';

FavoriteCarModel favoriteCarModelFromJson(String str) => FavoriteCarModel.fromJson(json.decode(str));

String favoriteCarModelToJson(FavoriteCarModel data) => json.encode(data.toJson());

class FavoriteCarModel {
  FavoriteCarModel({this.status, this.data, this.message});

  String? status;
  String? message;
  List<Datum>? data;

  factory FavoriteCarModel.fromJson(Map<String, dynamic> json) => FavoriteCarModel(
    status: json["status"],
    message : json["message"] != null ? json["message"] : null,
    // data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    data:json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))): null,
    // data : json["data"] != null ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    'message' : message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),

  };
}

class Datum {
  Datum({
    this.carsId,
    this.carsUsageType,
    this.usersCompaniesId,
    this.carsTypeId,
    this.carsMakesId,
    this.carsModelsId,
    this.year,
    this.carsColorsId,
    this.vehicalName,
    this.licensePlate,
    this.discountPercentage,
    this.description,
    this.featuresSuv,
    this.featuresSeats,
    this.featuresSpeed,
    this.featuresAutomatic,
    this.featuresDrives,
    this.featuresDoors,
    this.featuresElectric,
    this.featuresEngineCapacity,
    this.featuresFuelCapacity,
    this.featuresMeterReading,
    this.featuresNewCars,
    this.rating,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.dateAdded,
    this.dateModified,
    this.status,
  });

  int? carsId;
  String? carsUsageType;
  int? usersCompaniesId;
  int? carsTypeId;
  int? carsMakesId;
  int? carsModelsId;
  int? year;
  int? carsColorsId;
  String? vehicalName;
  String? licensePlate;
  String? discountPercentage;
  String? description;
  String? featuresSuv;
  String? featuresSeats;
  dynamic featuresSpeed;
  String? featuresAutomatic;
  String? featuresDrives;
  int? featuresDoors;
  String? featuresElectric;
  String? featuresEngineCapacity;
  dynamic featuresFuelCapacity;
  String? featuresMeterReading;
  String? featuresNewCars;
  dynamic rating;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  DateTime? dateAdded;
  dynamic dateModified;
  String? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    carsId: json["cars_id"],
    carsUsageType: json["cars_usage_type"],
    usersCompaniesId: json["users_companies_id"],
    carsTypeId: json["cars_type_id"],
    carsMakesId: json["cars_makes_id"],
    carsModelsId: json["cars_models_id"],
    year: json["year"],
    carsColorsId: json["cars_colors_id"],
    vehicalName: json["vehical_name"],
    licensePlate: json["license_plate"],
    discountPercentage: json["discount_percentage"],
    description: json["description"],
    featuresSuv: json["features_suv"],
    featuresSeats: json["features_seats"],
    featuresSpeed: json["features_speed"],
    featuresAutomatic: json["features_automatic"],
    featuresDrives: json["features_drives"],
    featuresDoors: json["features_doors"],
    featuresElectric: json["features_electric"],
    featuresEngineCapacity: json["features_engine_capacity"],
    featuresFuelCapacity: json["features_fuel_capacity"],
    featuresMeterReading: json["features_meter_reading"],
    featuresNewCars: json["features_new_cars"],
    rating: json["rating"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    image4: json["image4"],
    image5: json["image5"],
    dateAdded: DateTime.parse(json["date_added"]),
    dateModified: json["date_modified"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "cars_id": carsId,
    "cars_usage_type": carsUsageType,
    "users_companies_id": usersCompaniesId,
    "cars_type_id": carsTypeId,
    "cars_makes_id": carsMakesId,
    "cars_models_id": carsModelsId,
    "year": year,
    "cars_colors_id": carsColorsId,
    "vehical_name": vehicalName,
    "license_plate": licensePlate,
    "discount_percentage": discountPercentage,
    "description": description,
    "features_suv": featuresSuv,
    "features_seats": featuresSeats,
    "features_speed": featuresSpeed,
    "features_automatic": featuresAutomatic,
    "features_drives": featuresDrives,
    "features_doors": featuresDoors,
    "features_electric": featuresElectric,
    "features_engine_capacity": featuresEngineCapacity,
    "features_fuel_capacity": featuresFuelCapacity,
    "features_meter_reading": featuresMeterReading,
    "features_new_cars": featuresNewCars,
    "rating": rating,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "image5": image5,
    "date_added": dateAdded!.toIso8601String(),
    "date_modified": dateModified,
    "status": status,
  };
}
