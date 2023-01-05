
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
    this.favouriteStatus,
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
  String? rating;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  DateTime? dateAdded;
  DateTime? dateModified;
  String? status;
  CarsM? carsMakes;
  CarsM? carsModels;
  List<CarsRating>? carsRatings;
  int? totalBookings;
  String? favouriteStatus;
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
    rating: json["rating"] == null ? null : json["rating"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    image4: json["image4"],
    image5: json["image5"],
    dateAdded: DateTime.parse(json["date_added"]),
    dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
    status: json["status"],
    carsMakes: CarsM.fromJson(json["cars_makes"]),
    carsModels: CarsM.fromJson(json["cars_models"]),
    carsRatings: List<CarsRating>.from(json["cars_ratings"].map((x) => CarsRating.fromJson(x))),
    totalBookings: json["total_bookings"],
    favouriteStatus: json["favourite_status"],
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
    "rating": rating == null ? null : rating,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "image5": image5,
    "date_added": dateAdded!.toIso8601String(),
    "date_modified": dateModified == null ? null : dateModified!.toIso8601String(),
    "status": status,
    "cars_makes": carsMakes!.toJson(),
    "cars_models": carsModels!.toJson(),
    "cars_ratings": List<dynamic>.from(carsRatings!.map((x) => x.toJson())),
    "total_bookings": totalBookings,
    "favourite_status": favouriteStatus,
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
    this.carsPlansDeId,
    this.carsId,
    this.planDate,
    this.startTime,
    this.endTime,
    this.pricePerSlot,
    this.discountedPricePerSlot,
    this.carsPlansEvId,
    this.months,
    this.pricePerMonth,
    this.discountedPricePerMonth,
    this.carsPlansPgId,
    this.pricePerHour,
    this.discountedPricePerHour,
  });

  int? carsPlansDeId;
  int? carsId;
  DateTime? planDate;
  String? startTime;
  String? endTime;
  String? pricePerSlot;
  int? discountedPricePerSlot;
  int? carsPlansEvId;
  int? months;
  String? pricePerMonth;
  int? discountedPricePerMonth;
  int? carsPlansPgId;
  String? pricePerHour;
  int? discountedPricePerHour;

  factory CarsPlan.fromJson(Map<String, dynamic> json) => CarsPlan(
    carsPlansDeId: json["cars_plans_de_id"] == null ? null : json["cars_plans_de_id"],
    carsId: json["cars_id"],
    planDate: json["plan_date"] == null ? null : DateTime.parse(json["plan_date"]),
    startTime: json["start_time"] == null ? null : json["start_time"],
    endTime: json["end_time"] == null ? null : json["end_time"],
    pricePerSlot: json["price_per_slot"] == null ? null : json["price_per_slot"],
    discountedPricePerSlot: json["discounted_price_per_slot"] == null ? null : json["discounted_price_per_slot"],
    carsPlansEvId: json["cars_plans_ev_id"] == null ? null : json["cars_plans_ev_id"],
    months: json["months"] == null ? null : json["months"],
    pricePerMonth: json["price_per_month"] == null ? null : json["price_per_month"],
    discountedPricePerMonth: json["discounted_price_per_month"] == null ? null : json["discounted_price_per_month"],
    carsPlansPgId: json["cars_plans_pg_id"] == null ? null : json["cars_plans_pg_id"],
    pricePerHour: json["price_per_hour"] == null ? null : json["price_per_hour"],
    discountedPricePerHour: json["discounted_price_per_hour"] == null ? null : json["discounted_price_per_hour"],
  );

  Map<String, dynamic> toJson() => {
    "cars_plans_de_id": carsPlansDeId == null ? null : carsPlansDeId,
    "cars_id": carsId,
    "plan_date": planDate == null ? null : "${planDate!.year.toString().padLeft(4, '0')}-${planDate!.month.toString().padLeft(2, '0')}-${planDate!.day.toString().padLeft(2, '0')}",
    "start_time": startTime == null ? null : startTime,
    "end_time": endTime == null ? null : endTime,
    "price_per_slot": pricePerSlot == null ? null : pricePerSlot,
    "discounted_price_per_slot": discountedPricePerSlot == null ? null : discountedPricePerSlot,
    "cars_plans_ev_id": carsPlansEvId == null ? null : carsPlansEvId,
    "months": months == null ? null : months,
    "price_per_month": pricePerMonth == null ? null : pricePerMonth,
    "discounted_price_per_month": discountedPricePerMonth == null ? null : discountedPricePerMonth,
    "cars_plans_pg_id": carsPlansPgId == null ? null : carsPlansPgId,
    "price_per_hour": pricePerHour == null ? null : pricePerHour,
    "discounted_price_per_hour": discountedPricePerHour == null ? null : discountedPricePerHour,
  };
}

class CarsRating {
  CarsRating({
    this.carsRatingsId,
    this.carsId,
    this.usersCustomersId,
    this.comments,
    this.rateStars,
    this.dateAdded,
  });

  int? carsRatingsId;
  int? carsId;
  int? usersCustomersId;
  String? comments;
  String? rateStars;
  DateTime? dateAdded;

  factory CarsRating.fromJson(Map<String, dynamic> json) => CarsRating(
    carsRatingsId: json["cars_ratings_id"],
    carsId: json["cars_id"],
    usersCustomersId: json["users_customers_id"],
    comments: json["comments"],
    rateStars: json["rate_stars"],
    dateAdded: DateTime.parse(json["date_added"]),
  );

  Map<String, dynamic> toJson() => {
    "cars_ratings_id": carsRatingsId,
    "cars_id": carsId,
    "users_customers_id": usersCustomersId,
    "comments": comments,
    "rate_stars": rateStars,
    "date_added": dateAdded!.toIso8601String(),
  };
}
