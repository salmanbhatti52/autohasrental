
import 'dart:convert';

UpcomingBookingModel upcomingBookingModelFromJson(String str) => UpcomingBookingModel.fromJson(json.decode(str));

String upcomingBookingModelToJson(UpcomingBookingModel data) => json.encode(data.toJson());

class UpcomingBookingModel {
  UpcomingBookingModel({
    this.status,
    this.data,
  });

  String?status;
  List<Datum>? data;

  factory UpcomingBookingModel.fromJson(Map<String, dynamic> json) => UpcomingBookingModel(
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
    this.bookingsId,
    this.bookingsDate,
    this.carsId,
    this.usersCustomersId,
    this.totalCost,
    this.drivingLicense,
    this.status,
    this.carsDetails,
    this.usersCompanyDetails,
    this.userFavouriteCars,
    this.totalBookings,
    this.carsRatings,
    this.carsPlans,
    this.carsPlansCount,
  });

  int?bookingsId;
  DateTime? bookingsDate;
  int? carsId;
  int? usersCustomersId;
  int? totalCost;
  String? drivingLicense;
  String? status;
  CarsDetails? carsDetails;
  List<UsersCompanyDetail>? usersCompanyDetails;
  List<UserFavouriteCar>? userFavouriteCars;
  int? totalBookings;
  List<CarsRating>? carsRatings;
  List<CarsPlan>? carsPlans;
  int? carsPlansCount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    bookingsId: json["bookings_id"],
    bookingsDate: DateTime.parse(json["bookings_date"]),
    carsId: json["cars_id"],
    usersCustomersId: json["users_customers_id"],
    totalCost: json["total_cost"],
    drivingLicense: json["driving_license"],
    status: json["status"],
    carsDetails: CarsDetails.fromJson(json["cars_details"]),
    usersCompanyDetails: List<UsersCompanyDetail>.from(json["users_company_details"].map((x) => UsersCompanyDetail.fromJson(x))),
    userFavouriteCars: List<UserFavouriteCar>.from(json["user_favourite_cars"].map((x) => UserFavouriteCar.fromJson(x))),
    totalBookings: json["total_bookings"],
    carsRatings: List<CarsRating>.from(json["cars_ratings"].map((x) => CarsRating.fromJson(x))),
    carsPlans: List<CarsPlan>.from(json["cars_plans"].map((x) => CarsPlan.fromJson(x))),
    carsPlansCount: json["cars_plans_count"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_id": bookingsId,
    "bookings_date": bookingsDate!.toIso8601String(),
    "cars_id": carsId,
    "users_customers_id": usersCustomersId,
    "total_cost": totalCost,
    "driving_license": drivingLicense,
    "status": status,
    "cars_details": carsDetails!.toJson(),
    "users_company_details": List<dynamic>.from(usersCompanyDetails!.map((x) => x.toJson())),
    "user_favourite_cars": List<dynamic>.from(userFavouriteCars!.map((x) => x.toJson())),
    "total_bookings": totalBookings,
    "cars_ratings": List<dynamic>.from(carsRatings!.map((x) => x.toJson())),
    "cars_plans": List<dynamic>.from(carsPlans!.map((x) => x.toJson())),
    "cars_plans_count": carsPlansCount,
  };
}

class CarsDetails {
  CarsDetails({
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
    this.carsTypes,
    this.carsMakes,
    this.carsModels,
    this.carsColors,
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
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  DateTime? dateAdded;
  DateTime? dateModified;
  String? status;
  String? carsTypes;
  String? carsMakes;
  String? carsModels;
  CarsColors? carsColors;

  factory CarsDetails.fromJson(Map<String, dynamic> json) => CarsDetails(
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
    carsTypes: json["cars_types"],
    carsMakes: json["cars_makes"],
    carsModels: json["cars_models"],
    carsColors: CarsColors.fromJson(json["cars_colors"]),
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
    "cars_types": carsTypes,
    "cars_makes": carsMakes,
    "cars_models": carsModels,
    "cars_colors": carsColors!.toJson(),
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

class CarsPlan {
  CarsPlan({
    this.bookingsPlansPgId,
    this.bookingsId,
    this.carsId,
    this.planDate,
    this.startTime,
    this.endTime,
    this.discountPercentage,
    this.totalHours,
    this.pricePerHour,
    this.bookingsPlansDeId,
    this.pricePerSlot,
  });

  int? bookingsPlansPgId;
  int? bookingsId;
  int? carsId;
  DateTime? planDate;
  String? startTime;
  String? endTime;
  int? discountPercentage;
  int? totalHours;
  String? pricePerHour;
  int? bookingsPlansDeId;
  String? pricePerSlot;

  factory CarsPlan.fromJson(Map<String, dynamic> json) => CarsPlan(
    bookingsPlansPgId: json["bookings_plans_pg_id"],
    bookingsId: json["bookings_id"],
    carsId: json["cars_id"],
    planDate: DateTime.parse(json["plan_date"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
    discountPercentage: json["discount_percentage"],
    totalHours: json["total_hours"],
    pricePerHour: json["price_per_hour"],
    bookingsPlansDeId: json["bookings_plans_de_id"],
    pricePerSlot: json["price_per_slot"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_plans_pg_id": bookingsPlansPgId,
    "bookings_id": bookingsId,
    "cars_id": carsId,
    "plan_date": "${planDate!.year.toString().padLeft(4, '0')}-${planDate!.month.toString().padLeft(2, '0')}-${planDate!.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_time": endTime,
    "discount_percentage": discountPercentage,
    "total_hours": totalHours,
    "price_per_hour": pricePerHour,
    "bookings_plans_de_id": bookingsPlansDeId,
    "price_per_slot": pricePerSlot,
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

class UserFavouriteCar {
  UserFavouriteCar({
    this.carsFavouriteId,
    this.usersCustomersId,
    this.carsId,
    this.dateAdded,
  });

  int? carsFavouriteId;
  int? usersCustomersId;
  int? carsId;
  DateTime? dateAdded;

  factory UserFavouriteCar.fromJson(Map<String, dynamic> json) => UserFavouriteCar(
    carsFavouriteId: json["cars_favourite_id"],
    usersCustomersId: json["users_customers_id"],
    carsId: json["cars_id"],
    dateAdded: DateTime.parse(json["date_added"]),
  );

  Map<String, dynamic> toJson() => {
    "cars_favourite_id": carsFavouriteId,
    "users_customers_id": usersCustomersId,
    "cars_id": carsId,
    "date_added": dateAdded!.toIso8601String(),
  };
}

class UsersCompanyDetail {
  UsersCompanyDetail({
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
  dynamic about;
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

  factory UsersCompanyDetail.fromJson(Map<String, dynamic> json) => UsersCompanyDetail(
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
