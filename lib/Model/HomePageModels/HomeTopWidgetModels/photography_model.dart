//
// import 'dart:convert';
//
// PhotoGraphyModel carsPhotoGraphyModelFromJson(String str) => PhotoGraphyModel.fromJson(json.decode(str));
//
// String carsPhotoGraphyModelToJson(PhotoGraphyModel data) => json.encode(data.toJson());
//
// class PhotoGraphyModel {
//   PhotoGraphyModel({
//     this.status,
//     this.data,
//   });
//
//   String? status;
//   List<DatumPhotography>? data;
//
//   factory PhotoGraphyModel.fromJson(Map<String, dynamic> json) => PhotoGraphyModel(
//     status: json["status"],
//     data: List<DatumPhotography>.from(json["data"].map((x) => DatumPhotography.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class DatumPhotography {
//   DatumPhotography({
//     this.carsId,
//     this.carsUsageType,
//     this.usersCompaniesId,
//     this.carsTypeId,
//     this.carsMakesId,
//     this.carsModelsId,
//     this.year,
//     this.carsColorsId,
//     this.vehicalName,
//     this.licensePlate,
//     this.discountPercentage,
//     this.description,
//     this.featuresSuv,
//     this.features2Doors,
//     this.features5Seats,
//     this.featuresAutomatic,
//     this.featuresAwd,
//     this.featuresElectric,
//     this.featuresTbd,
//     this.featuresNewCars,
//     this.rating,
//     this.image1,
//     this.image2,
//     this.image3,
//     this.image4,
//     this.image5,
//     this.dateAdded,
//     this.dateModified,
//     this.status,
//     this.carsMakes,
//     this.carsModels,
//     this.carsColors,
//     this.carsRatings,
//     this.totalBookings,
//     this.usersCompanies,
//     this.favouriteStatus,
//     this.carsPlans,
//   });
//
//   int? carsId;
//   String? carsUsageType;
//   int? usersCompaniesId;
//   int? carsTypeId;
//   int? carsMakesId;
//   int? carsModelsId;
//   int? year;
//   int? carsColorsId;
//   String? vehicalName;
//   String? licensePlate;
//   String? discountPercentage;
//   String? description;
//   String? featuresSuv;
//   String? features2Doors;
//   String? features5Seats;
//   String? featuresAutomatic;
//   String? featuresAwd;
//   String? featuresElectric;
//   String? featuresTbd;
//   String? featuresNewCars;
//   dynamic rating;
//   String? image1;
//   String? image2;
//   String? image3;
//   String? image4;
//   String? image5;
//   DateTime? dateAdded;
//   dynamic dateModified;
//   String? status;
//   CarsM? carsMakes;
//   CarsM? carsModels;
//   CarsColors? carsColors;
//   List<dynamic>? carsRatings;
//   int? totalBookings;
//   UsersCompanies? usersCompanies;
//   String? favouriteStatus;
//   List<CarsPlan>? carsPlans;
//
//   factory DatumPhotography.fromJson(Map<String, dynamic> json) => DatumPhotography(
//     carsId: json["cars_id"],
//     carsUsageType: json["cars_usage_type"],
//     usersCompaniesId: json["users_companies_id"],
//     carsTypeId: json["cars_type_id"],
//     carsMakesId: json["cars_makes_id"],
//     carsModelsId: json["cars_models_id"],
//     year: json["year"],
//     carsColorsId: json["cars_colors_id"],
//     vehicalName: json["vehical_name"],
//     licensePlate: json["license_plate"],
//     discountPercentage: json["discount_percentage"],
//     description: json["description"],
//     featuresSuv: json["features_suv"],
//     features2Doors: json["features_2doors"],
//     features5Seats: json["features_5seats"],
//     featuresAutomatic: json["features_automatic"],
//     featuresAwd: json["features_awd"],
//     featuresElectric: json["features_electric"],
//     featuresTbd: json["features_tbd"],
//     featuresNewCars: json["features_new_cars"],
//     rating: json["rating"],
//     image1: json["image1"],
//     image2: json["image2"],
//     image3: json["image3"],
//     image4: json["image4"],
//     image5: json["image5"],
//     dateAdded: DateTime.parse(json["date_added"]),
//     dateModified: json["date_modified"],
//     status: json["status"],
//     carsMakes: CarsM.fromJson(json["cars_makes"]),
//     carsModels: CarsM.fromJson(json["cars_models"]),
//     carsColors: CarsColors.fromJson(json["cars_colors"]),
//     carsRatings: List<dynamic>.from(json["cars_ratings"].map((x) => x)),
//     totalBookings: json["total_bookings"],
//     usersCompanies: UsersCompanies.fromJson(json["users_companies"]),
//     favouriteStatus: json["favourite_status"],
//     carsPlans: List<CarsPlan>.from(json["cars_plans"].map((x) => CarsPlan.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cars_id": carsId,
//     "cars_usage_type": carsUsageType,
//     "users_companies_id": usersCompaniesId,
//     "cars_type_id": carsTypeId,
//     "cars_makes_id": carsMakesId,
//     "cars_models_id": carsModelsId,
//     "year": year,
//     "cars_colors_id": carsColorsId,
//     "vehical_name": vehicalName,
//     "license_plate": licensePlate,
//     "discount_percentage": discountPercentage,
//     "description": description,
//     "features_suv": featuresSuv,
//     "features_2doors": features2Doors,
//     "features_5seats": features5Seats,
//     "features_automatic": featuresAutomatic,
//     "features_awd": featuresAwd,
//     "features_electric": featuresElectric,
//     "features_tbd": featuresTbd,
//     "features_new_cars": featuresNewCars,
//     "rating": rating,
//     "image1": image1,
//     "image2": image2,
//     "image3": image3,
//     "image4": image4,
//     "image5": image5,
//     "date_added": dateAdded!.toIso8601String(),
//     "date_modified": dateModified,
//     "status": status,
//     "cars_makes": carsMakes!.toJson(),
//     "cars_models": carsModels!.toJson(),
//     "cars_colors": carsColors!.toJson(),
//     "cars_ratings": List<dynamic>.from(carsRatings!.map((x) => x)),
//     "total_bookings": totalBookings,
//     "users_companies": usersCompanies!.toJson(),
//     "favourite_status": favouriteStatus,
//     "cars_plans": List<dynamic>.from(carsPlans!.map((x) => x.toJson())),
//   };
// }
//
// class CarsColors {
//   CarsColors({
//     this.carsColorsId,
//     this.name,
//     this.status,
//   });
//
//   int? carsColorsId;
//   String? name;
//   String? status;
//
//   factory CarsColors.fromJson(Map<String, dynamic> json) => CarsColors(
//     carsColorsId: json["cars_colors_id"],
//     name: json["name"],
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cars_colors_id": carsColorsId,
//     "name": name,
//     "status": status,
//   };
// }
//
// class CarsM {
//   CarsM({
//     this.carsMakesId,
//     this.name,
//     this.image,
//     this.status,
//     this.carsModelsId,
//   });
//
//   int? carsMakesId;
//   String? name;
//   String? image;
//   String? status;
//   int? carsModelsId;
//
//   factory CarsM.fromJson(Map<String, dynamic> json) => CarsM(
//     carsMakesId: json["cars_makes_id"],
//     name: json["name"],
//     image: json["image"],
//     status: json["status"],
//     carsModelsId: json["cars_models_id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cars_makes_id": carsMakesId,
//     "name": name,
//     "image": image,
//     "status": status,
//     "cars_models_id": carsModelsId,
//   };
// }
//
// class CarsPlan {
//   CarsPlan({
//     this.carsPlansPgId,
//     this.carsId,
//     this.planDate,
//     this.pricePerHour,
//     this.discountedPricePerHour,
//   });
//
//   int? carsPlansPgId;
//   int? carsId;
//   DateTime? planDate;
//   String? pricePerHour;
//   String? discountedPricePerHour;
//
//   factory CarsPlan.fromJson(Map<String, dynamic> json) => CarsPlan(
//     carsPlansPgId: json["cars_plans_pg_id"],
//     carsId: json["cars_id"],
//     planDate: DateTime.parse(json["plan_date"]),
//     pricePerHour: json["price_per_hour"],
//     discountedPricePerHour: json["discounted_price_per_hour"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cars_plans_pg_id": carsPlansPgId,
//     "cars_id": carsId,
//     "plan_date": "${planDate!.year.toString().padLeft(4, '0')}-${planDate!.month.toString().padLeft(2, '0')}-${planDate!.day.toString().padLeft(2, '0')}",
//     "price_per_hour": pricePerHour,
//     "discounted_price_per_hour": discountedPricePerHour,
//   };
// }
//
// class UsersCompanies {
//   UsersCompanies({
//     this.usersCompaniesId,
//     this.companyName,
//     this.email,
//     this.password,
//     this.phone,
//     this.about,
//     this.bankName,
//     this.bankAccountNumber,
//     this.companyLocation,
//     this.companyRegistrationNumber,
//     this.companyLogo,
//     this.paypalEmail,
//     this.verifyEmailOtp,
//     this.forgotPasswordOtp,
//     this.verified,
//     this.dateAdded,
//     this.dateModified,
//     this.status,
//   });
//
//   int? usersCompaniesId;
//   String? companyName;
//   String? email;
//   String? password;
//   String? phone;
//   dynamic about;
//   dynamic bankName;
//   dynamic bankAccountNumber;
//   String? companyLocation;
//   String? companyRegistrationNumber;
//   String? companyLogo;
//   dynamic paypalEmail;
//   int? verifyEmailOtp;
//   dynamic forgotPasswordOtp;
//   String? verified;
//   DateTime? dateAdded;
//   dynamic dateModified;
//   String? status;
//
//   factory UsersCompanies.fromJson(Map<String, dynamic> json) => UsersCompanies(
//     usersCompaniesId: json["users_companies_id"],
//     companyName: json["company_name"],
//     email: json["email"],
//     password: json["password"],
//     phone: json["phone"],
//     about: json["about"],
//     bankName: json["bank_name"],
//     bankAccountNumber: json["bank_account_number"],
//     companyLocation: json["company_location"],
//     companyRegistrationNumber: json["company_registration_number"],
//     companyLogo: json["company_logo"],
//     paypalEmail: json["paypal_email"],
//     verifyEmailOtp: json["verify_email_otp"],
//     forgotPasswordOtp: json["forgotPasswordOtp"],
//     verified: json["verified"],
//     dateAdded: DateTime.parse(json["date_added"]),
//     dateModified: json["date_modified"],
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "users_companies_id": usersCompaniesId,
//     "company_name": companyName,
//     "email": email,
//     "password": password,
//     "phone": phone,
//     "about": about,
//     "bank_name": bankName,
//     "bank_account_number": bankAccountNumber,
//     "company_location": companyLocation,
//     "company_registration_number": companyRegistrationNumber,
//     "company_logo": companyLogo,
//     "paypal_email": paypalEmail,
//     "verify_email_otp": verifyEmailOtp,
//     "forgotPasswordOtp": forgotPasswordOtp,
//     "verified": verified,
//     "date_added": dateAdded!.toIso8601String(),
//     "date_modified": dateModified,
//     "status": status,
//   };
// }

import 'dart:convert';

PhotoGraphyModel photoGraphyModelFromJson(String str) => PhotoGraphyModel.fromJson(json.decode(str));

String photoGraphyModelToJson(PhotoGraphyModel data) => json.encode(data.toJson());

class PhotoGraphyModel {
  PhotoGraphyModel({
      this.status,
      this.data,
  });

  String? status;
  List<DatumPhotography>? data;

  factory PhotoGraphyModel.fromJson(Map<String, dynamic> json) => PhotoGraphyModel(
    status: json["status"],
    data: List<DatumPhotography>.from(json["data"].map((x) => DatumPhotography.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DatumPhotography {
  DatumPhotography({
      this.carsId,
      this.usersCompaniesId,
      this.vehicalName,
      this.licensePlate,
      this.discountPercentage,
      this.carsUsageType,
      this.carsTypeId,
      this.carsMakesId,
      this.carsModelsId,
      this.year,
      this.carsColorsId,
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
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5,
      this.rating,
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
  int? usersCompaniesId;
  String? vehicalName;
  String? licensePlate;
  String? discountPercentage;
  String? carsUsageType;
  int? carsTypeId;
  int? carsMakesId;
  int? carsModelsId;
  int? year;
  int? carsColorsId;
  String? description;
  String? featuresSuv;
  String? featuresSeats;
  String? featuresSpeed;
  String? featuresAutomatic;
  String? featuresDrives;
  String? featuresDoors;
  String? featuresElectric;
  String? featuresEngineCapacity;
  String? featuresFuelCapacity;
  String? featuresMeterReading;
  String? featuresNewCars;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  String? rating;
  DateTime? dateAdded;
  dynamic dateModified;
  String? status;
  CarsM? carsMakes;
  CarsM? carsModels;
  CarsColors? carsColors;
  List<CarsRating>? carsRatings;
  int? totalBookings;
  UsersCompanies? usersCompanies;
  String? favouriteStatus;
  List<CarsPlan>? carsPlans;

  factory DatumPhotography.fromJson(Map<String, dynamic> json) => DatumPhotography(
    carsId: json["cars_id"],
    usersCompaniesId: json["users_companies_id"],
    vehicalName: json["vehical_name"],
    licensePlate: json["license_plate"],
    discountPercentage: json["discount_percentage"],
    carsUsageType: json["cars_usage_type"],
    carsTypeId: json["cars_type_id"],
    carsMakesId: json["cars_makes_id"],
    carsModelsId: json["cars_models_id"],
    year: json["year"],
    carsColorsId: json["cars_colors_id"],
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
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    image4: json["image4"],
    image5: json["image5"],
    rating: json["rating"],
    dateAdded: DateTime.parse(json["date_added"]),
    dateModified: json["date_modified"],
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
    "users_companies_id": usersCompaniesId,
    "vehical_name": vehicalName,
    "license_plate": licensePlate,
    "discount_percentage": discountPercentage,
    "cars_usage_type": carsUsageType,
    "cars_type_id": carsTypeId,
    "cars_makes_id": carsMakesId,
    "cars_models_id": carsModelsId,
    "year": year,
    "cars_colors_id": carsColorsId,
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
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "image5": image5,
    "rating": rating,
    "date_added": dateAdded!.toIso8601String(),
    "date_modified": dateModified,
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
      this.carsPlansPgId,
      this.carsId,
      this.planDate,
      this.pricePerHour,
      this.discountedPricePerHour,
  });

  int? carsPlansPgId;
  int? carsId;
  DateTime? planDate;
  String? pricePerHour;
  String? discountedPricePerHour;

  factory CarsPlan.fromJson(Map<String, dynamic> json) => CarsPlan(
    carsPlansPgId: json["cars_plans_pg_id"],
    carsId: json["cars_id"],
    planDate: DateTime.parse(json["plan_date"]),
    pricePerHour: json["price_per_hour"],
    discountedPricePerHour: json["discounted_price_per_hour"],
  );

  Map<String, dynamic> toJson() => {
    "cars_plans_pg_id": carsPlansPgId,
    "cars_id": carsId,
    "plan_date": "${planDate!.year.toString().padLeft(4, '0')}-${planDate!.month.toString().padLeft(2, '0')}-${planDate!.day.toString().padLeft(2, '0')}",
    "price_per_hour": pricePerHour,
    "discounted_price_per_hour": discountedPricePerHour,
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
      this.usersData,
  });

  int? carsRatingsId;
  int? carsId;
  int? usersCustomersId;
  String? comments;
  String? rateStars;
  DateTime? dateAdded;
  List<UsersDatum>? usersData;

  factory CarsRating.fromJson(Map<String, dynamic> json) => CarsRating(
    carsRatingsId: json["cars_ratings_id"],
    carsId: json["cars_id"],
    usersCustomersId: json["users_customers_id"],
    comments: json["comments"],
    rateStars: json["rate_stars"],
    dateAdded: DateTime.parse(json["date_added"]),
    usersData: List<UsersDatum>.from(json["users_data"].map((x) => UsersDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cars_ratings_id": carsRatingsId,
    "cars_id": carsId,
    "users_customers_id": usersCustomersId,
    "comments": comments,
    "rate_stars": rateStars,
    "date_added": dateAdded!.toIso8601String(),
    "users_data": List<dynamic>.from(usersData!.map((x) => x.toJson())),
  };
}

class UsersDatum {
  UsersDatum({
      this.usersCustomersId,
      this.oneSignalId,
      this.verifiedBadge,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.password,
      this.accountType,
      this.socialAccType,
      this.googleAccessToken,
      this.location,
      this.about,
      this.profilePic,
      this.dateAdded,
      this.verifyCode,
      this.notifications,
      this.status,
  });

  int? usersCustomersId;
  String? oneSignalId;
  String? verifiedBadge;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;
  String? accountType;
  String? socialAccType;
  String? googleAccessToken;
  String? location;
  String? about;
  String? profilePic;
  DateTime? dateAdded;
  String? verifyCode;
  String? notifications;
  String? status;

  factory UsersDatum.fromJson(Map<String, dynamic> json) => UsersDatum(
    usersCustomersId: json["users_customers_id"],
    oneSignalId: json["one_signal_id"],
    verifiedBadge: json["verified_badge"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    email: json["email"],
    password: json["password"],
    accountType: json["account_type"],
    socialAccType: json["social_acc_type"],
    googleAccessToken: json["google_access_token"],
    location: json["location"],
    about: json["about"],
    profilePic: json["profile_pic"],
    dateAdded: DateTime.parse(json["date_added"]),
    verifyCode: json["verify_code"],
    notifications: json["notifications"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "users_customers_id": usersCustomersId,
    "one_signal_id": oneSignalId,
    "verified_badge": verifiedBadge,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "password": password,
    "account_type": accountType,
    "social_acc_type": socialAccType,
    "google_access_token": googleAccessToken,
    "location": location,
    "about": about,
    "profile_pic": profilePic,
    "date_added": dateAdded!.toIso8601String(),
    "verify_code": verifyCode,
    "notifications": notifications,
    "status": status,
  };
}

class UsersCompanies {
  UsersCompanies({
      this.usersCompaniesId,
      this.email,
      this.password,
      this.phone,
      this.companyName,
      this.companyRegistrationNumber,
      this.companyLocation,
      this.companyLogo,
    this.about,
      this.verifyEmailOtp,
      this.forgotPasswordOtp,
      this.bankName,
      this.bankAccountNumber,
      this.paypalEmail,
      this.online,
      this.status,
      this.dateAdded,
      this.dateModified,
  });

  int? usersCompaniesId;
  String? email;
  String? password;
  String? phone;
  String? companyName;
  String? companyRegistrationNumber;
  String? companyLocation;
  String? companyLogo;
  dynamic about;
  int? verifyEmailOtp;
  int? forgotPasswordOtp;
  String? bankName;
  String? bankAccountNumber;
  String? paypalEmail;
  String? online;
  String? status;
  DateTime? dateAdded;
  DateTime? dateModified;

  factory UsersCompanies.fromJson(Map<String, dynamic> json) => UsersCompanies(
    usersCompaniesId: json["users_companies_id"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    companyName: json["company_name"],
    companyRegistrationNumber: json["company_registration_number"],
    companyLocation: json["company_location"],
    companyLogo: json["company_logo"],
    about: json["about"],
    verifyEmailOtp: json["verify_email_otp"],
    forgotPasswordOtp: json["forgotPasswordOtp"],
    bankName: json["bank_name"],
    bankAccountNumber: json["bank_account_number"],
    paypalEmail: json["paypal_email"],
    online: json["online"],
    status: json["status"],
    dateAdded: DateTime.parse(json["date_added"]),
    dateModified: DateTime.parse(json["date_modified"]),
  );

  Map<String, dynamic> toJson() => {
    "users_companies_id": usersCompaniesId,
    "email": email,
    "password": password,
    "phone": phone,
    "company_name": companyName,
    "company_registration_number": companyRegistrationNumber,
    "company_location": companyLocation,
    "company_logo": companyLogo,
    "about": about,
    "verify_email_otp": verifyEmailOtp,
    "forgotPasswordOtp": forgotPasswordOtp,
    "bank_name": bankName,
    "bank_account_number": bankAccountNumber,
    "paypal_email": paypalEmail,
    "online": online,
    "status": status,
    "date_added": dateAdded!.toIso8601String(),
    "date_modified": dateModified!.toIso8601String(),
  };
}
