
import 'dart:convert';

CarsPhotoGraphyModel carsPhotoGraphyModelFromJson(String str) => CarsPhotoGraphyModel.fromJson(json.decode(str));

String updateProfileModelToJson(CarsPhotoGraphyModel data) => json.encode(data.toJson());

class CarsPhotoGraphyModel {
  CarsPhotoGraphyModel({
    this.status,
    this.data,
  });

  String? status;
  List<Datum>? data;

  factory CarsPhotoGraphyModel.fromJson(Map<String, dynamic> json) => CarsPhotoGraphyModel(
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
    this.carsUsageType,
    this.usersCompaniesId,
    this.carsTypeId,
    this.carsMakesId,
    this.carsModelsId,
    this.year,
    this.vehicalName,
    this.licensePlate,
    this.discountPercentage,
    this.description,
    this.featuresSuv,
    this.features2Doors,
    this.features5Seats,
    this.featuresAutomatic,
    this.featuresAwd,
    this.featuresElectric,
    this.featuresTbd,
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
    this.carsMakes,
    this.carsModels,
    this.carsRatings,
    this.totalBookings,
    this.carsPlans,
  });

  int? carsId;
  String? carsUsageType;
  int? usersCompaniesId;
  int? carsTypeId;
  int? carsMakesId;
  int? carsModelsId;
  int? year;
  String? vehicalName;
  String? licensePlate;
  String? discountPercentage;
  String? description;
  String? featuresSuv;
  String? features2Doors;
  String? features5Seats;
  String? featuresAutomatic;
  String? featuresAwd;
  String? featuresElectric;
  String? featuresTbd;
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
  CarsM? carsMakes;
  CarsM? carsModels;
  List<dynamic>? carsRatings;
  int? totalBookings;
  List<CarsPlan>? carsPlans;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    carsId: json["cars_id"],
    carsUsageType: json["cars_usage_type"],
    usersCompaniesId: json["users_companies_id"],
    carsTypeId: json["cars_type_id"],
    carsMakesId: json["cars_makes_id"],
    carsModelsId: json["cars_models_id"],
    year: json["year"],
    vehicalName: json["vehical_name"],
    licensePlate: json["license_plate"],
    discountPercentage: json["discount_percentage"],
    description: json["description"],
    featuresSuv: json["features_suv"],
    features2Doors: json["features_2doors"],
    features5Seats: json["features_5seats"],
    featuresAutomatic: json["features_automatic"],
    featuresAwd: json["features_awd"],
    featuresElectric: json["features_electric"],
    featuresTbd: json["features_tbd"],
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
    carsMakes: CarsM.fromJson(json["cars_makes"]),
    carsModels: CarsM.fromJson(json["cars_models"]),
    carsRatings: List<dynamic>.from(json["cars_ratings"].map((x) => x)),
    totalBookings: json["total_bookings"],
    carsPlans: List<CarsPlan>.from(json["cars_plans"].map((x) => CarsPlan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cars_id": carsId,
    "cars_usage_type": carsUsageType,
    "users_companies_id": usersCompaniesId,
    "cars_type_id": carsTypeId,
    "cars_makes_id": carsMakesId,
    "cars_models_id": carsModelsId,
    "year": year,
    "vehical_name": vehicalName,
    "license_plate": licensePlate,
    "discount_percentage": discountPercentage,
    "description": description,
    "features_suv": featuresSuv,
    "features_2doors": features2Doors,
    "features_5seats": features5Seats,
    "features_automatic": featuresAutomatic,
    "features_awd": featuresAwd,
    "features_electric": featuresElectric,
    "features_tbd": featuresTbd,
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
    "cars_makes": carsMakes!.toJson(),
    "cars_models": carsModels!.toJson(),
    "cars_ratings": List<dynamic>.from(carsRatings!.map((x) => x)),
    "total_bookings": totalBookings,
    "cars_plans": List<dynamic>.from(carsPlans!.map((x) => x.toJson())),
  };
}

class CarsM {
  CarsM({
    this.carsMakesId,
    this.name,
    this.image,
    this.status,
    this.carsModelsId,
  });

  int? carsMakesId;
  String? name;
  String? image;
  String? status;
  int? carsModelsId;

  factory CarsM.fromJson(Map<String, dynamic> json) => CarsM(
    carsMakesId: json["cars_makes_id"],
    name: json["name"],
    image: json["image"],
    status: json["status"],
    carsModelsId: json["cars_models_id"] == null ? null : json["cars_models_id"],
  );

  Map<String, dynamic> toJson() => {
    "cars_makes_id": carsMakesId,
    "name": name,
    "image": image,
    "status": status,
    "cars_models_id": carsModelsId == null ? null : carsModelsId,
  };
}

class CarsPlan {
  CarsPlan({
    this.carsPlansPgId,
    this.carsId,
    this.planDate,
    this.pricePerHour,
  });

  int? carsPlansPgId;
  int? carsId;
  DateTime? planDate;
  String? pricePerHour;

  factory CarsPlan.fromJson(Map<String, dynamic> json) => CarsPlan(
    carsPlansPgId: json["cars_plans_pg_id"],
    carsId: json["cars_id"],
    planDate: DateTime.parse(json["plan_date"]),
    pricePerHour: json["price_per_hour"],
  );

  Map<String, dynamic> toJson() => {
    "cars_plans_pg_id": carsPlansPgId,
    "cars_id": carsId,
    "plan_date": "${planDate!.year.toString().padLeft(4, '0')}-${planDate!.month.toString().padLeft(2, '0')}-${planDate!.day.toString().padLeft(2, '0')}",
    "price_per_hour": pricePerHour,
  };
}
