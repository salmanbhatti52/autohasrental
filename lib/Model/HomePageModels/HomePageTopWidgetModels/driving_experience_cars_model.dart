
import 'dart:convert';

DrivingExperienceCarsModel drivingExperienceCarsModelFromJson(String str) => DrivingExperienceCarsModel.fromJson(json.decode(str));

String drivingExperienceCarsModelToJson(DrivingExperienceCarsModel data) => json.encode(data.toJson());

class DrivingExperienceCarsModel {
  DrivingExperienceCarsModel({
    this.status,
    this.data,
  });

  String? status;
  List<ExperienceDatumList>? data;

  factory DrivingExperienceCarsModel.fromJson(Map<String, dynamic> json) => DrivingExperienceCarsModel(
    status: json["status"],
    data: List<ExperienceDatumList>.from(json["data"].map((x) => ExperienceDatumList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ExperienceDatumList {
  ExperienceDatumList({
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
    this.carsColors,
    this.carsRatings,
    this.totalBookings,
    this.usersCompanies,
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
  int? carsColorsId;
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
  String?image1;
  String?image2;
  String?image3;
  String?image4;
  String?image5;
  DateTime? dateAdded;
  DateTime? dateModified;
  String? status;
  CarsM? carsMakes;
  CarsM? carsModels;
  CarsColors? carsColors;
  List<CarsRating>? carsRatings;
  int? totalBookings;
  UsersCompanies? usersCompanies;
  String? favouriteStatus;
  List<CarsPlan>? carsPlans;

  factory ExperienceDatumList.fromJson(Map<String, dynamic> json) => ExperienceDatumList(
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
    dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
    status: json["status"],
    carsMakes: CarsM.fromJson(json["cars_makes"]),
    carsModels: CarsM.fromJson(json["cars_models"]),
    carsColors: CarsColors.fromJson(json["cars_colors"]),
    carsRatings: List<CarsRating>.from(json["cars_ratings"].map((x) => CarsRating.fromJson(x))),
    totalBookings: json["total_bookings"],
    usersCompanies: UsersCompanies.fromJson(json["users_companies"]),
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
    "cars_colors_id": carsColorsId,
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
    "date_modified": dateModified?.toIso8601String(),
    "status": status,
    "cars_makes": carsMakes!.toJson(),
    "cars_models": carsModels!.toJson(),
    "cars_colors": carsColors!.toJson(),
    "cars_ratings": List<dynamic>.from(carsRatings!.map((x) => x.toJson())),
    "total_bookings": totalBookings,
    "users_companies": usersCompanies!.toJson(),
    "favourite_status": favouriteStatus,
    "cars_plans": List<dynamic>.from(carsPlans!.map((x) => x.toJson())),
  };
}

class CarsColors {
  CarsColors({
    this.carsColorsId,
    this.name,
    this.status,
  });

  int? carsColorsId;
  String? name;
  String? status;

  factory CarsColors.fromJson(Map<String, dynamic> json) => CarsColors(
    carsColorsId: json["cars_colors_id"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "cars_colors_id": carsColorsId,
    "name": name,
    "status": status,
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
    carsModelsId: json["cars_models_id"],
  );

  Map<String, dynamic> toJson() => {
    "cars_makes_id": carsMakesId,
    "name": name,
    "image": image,
    "status": status,
    "cars_models_id": carsModelsId,
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
  });

  int? carsPlansDeId;
  int? carsId;
  DateTime? planDate;
  String? startTime;
  String? endTime;
  String? pricePerSlot;
  double? discountedPricePerSlot;

  factory CarsPlan.fromJson(Map<String, dynamic> json) => CarsPlan(
    carsPlansDeId: json["cars_plans_de_id"],
    carsId: json["cars_id"],
    planDate: DateTime.parse(json["plan_date"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
    pricePerSlot: json["price_per_slot"],
    discountedPricePerSlot: json["discounted_price_per_slot"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "cars_plans_de_id": carsPlansDeId,
    "cars_id": carsId,
    "plan_date": "${planDate!.year.toString().padLeft(4, '0')}-${planDate!.month.toString().padLeft(2, '0')}-${planDate!.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_time": endTime,
    "price_per_slot": pricePerSlot,
    "discounted_price_per_slot": discountedPricePerSlot,
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

class UsersCompanies {
  UsersCompanies({
    this.usersCompaniesId,
    this.companyName,
    this.email,
    this.password,
    this.phone,
    this.about,
    this.bankName,
    this.bankAccountNumber,
    this.companyLocation,
    this.companyRegistrationNumber,
    this.companyLogo,
    this.paypalEmail,
    this.verifyEmailOtp,
    this.forgotPasswordOtp,
    this.verified,
    this.dateAdded,
    this.dateModified,
    this.status,
  });

  int? usersCompaniesId;
  String? companyName;
  String? email;
  String? password;
  String? phone;
  String? about;
  String? bankName;
  String? bankAccountNumber;
  String? companyLocation;
  String? companyRegistrationNumber;
  String? companyLogo;
  String? paypalEmail;
  int? verifyEmailOtp;
  int? forgotPasswordOtp;
  String? verified;
  DateTime? dateAdded;
  DateTime? dateModified;
  String? status;

  factory UsersCompanies.fromJson(Map<String, dynamic> json) => UsersCompanies(
    usersCompaniesId: json["users_companies_id"],
    companyName: json["company_name"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    about: json["about"],
    bankName: json["bank_name"],
    bankAccountNumber: json["bank_account_number"],
    companyLocation: json["company_location"],
    companyRegistrationNumber: json["company_registration_number"],
    companyLogo: json["company_logo"],
    paypalEmail: json["paypal_email"],
    verifyEmailOtp: json["verify_email_otp"],
    forgotPasswordOtp: json["forgotPasswordOtp"],
    verified: json["verified"],
    dateAdded: DateTime.parse(json["date_added"]),
    dateModified: DateTime.parse(json["date_modified"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "users_companies_id": usersCompaniesId,
    "company_name": companyName,
    "email": email,
    "password": password,
    "phone": phone,
    "about": about,
    "bank_name": bankName,
    "bank_account_number": bankAccountNumber,
    "company_location": companyLocation,
    "company_registration_number": companyRegistrationNumber,
    "company_logo": companyLogo,
    "paypal_email": paypalEmail,
    "verify_email_otp": verifyEmailOtp,
    "forgotPasswordOtp": forgotPasswordOtp,
    "verified": verified,
    "date_added": dateAdded!.toIso8601String(),
    "date_modified": dateModified!.toIso8601String(),
    "status": status,
  };
}
