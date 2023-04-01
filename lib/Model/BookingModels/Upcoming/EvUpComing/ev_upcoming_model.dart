import 'dart:convert';

EvUpcomingModel evUpcomingModelFromJson(String str) => EvUpcomingModel.fromJson(json.decode(str));

String evUpcomingModelToJson(EvUpcomingModel data) => json.encode(data.toJson());

class EvUpcomingModel {
  EvUpcomingModel({
    this.status,
    this.data,
  });

  String? status;
  List<EvUpcomingDatum>? data;

  factory EvUpcomingModel.fromJson(Map<String, dynamic> json) => EvUpcomingModel(
    status: json["status"],
    data: json["data"] != null ? List<EvUpcomingDatum>.from(json["data"].map((x) => EvUpcomingDatum.fromJson(x))): null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class EvUpcomingDatum {
  EvUpcomingDatum({
    this.bookingsId,
    this.carsId,
    this.usersCustomersId,
    this.totalCost,
    this.drivingLicense,
    this.companyLocation,
    this.bookingsDate,
    this.status,
    this.bookingsAddresses,
    this.carsDetails,
    this.usersCompaniesDetails,
    this.userFavouriteCars,
    this.totalBookings,
    this.carsRatings,
    this.carsPlans,
    this.carsPlansCount,
  });

  int? bookingsId;
  int? carsId;
  int? usersCustomersId;
  String? totalCost;
  String? drivingLicense;
  dynamic companyLocation;
  DateTime? bookingsDate;
  String? status;
  List<BookingsAddress>? bookingsAddresses;
  CarsDetails? carsDetails;
  List<UsersCompaniesDetail>? usersCompaniesDetails;
  List<UserFavouriteCar>? userFavouriteCars;
  int? totalBookings;
  List<CarsRating>? carsRatings;
  List<CarsPlan>? carsPlans;
  int? carsPlansCount;

  factory EvUpcomingDatum.fromJson(Map<String, dynamic> json) => EvUpcomingDatum(
    bookingsId: json["bookings_id"],
    carsId: json["cars_id"],
    usersCustomersId: json["users_customers_id"],
    totalCost: json["total_cost"],
    drivingLicense: json["driving_license"],
    companyLocation: json["company_location"],
    bookingsDate: DateTime.parse(json["bookings_date"]),
    status: json["status"],
    bookingsAddresses: List<BookingsAddress>.from(json["bookings_addresses"].map((x) => BookingsAddress.fromJson(x))),
    carsDetails: CarsDetails.fromJson(json["cars_details"]),
    usersCompaniesDetails: List<UsersCompaniesDetail>.from(json["users_companies_details"].map((x) => UsersCompaniesDetail.fromJson(x))),
    userFavouriteCars: List<UserFavouriteCar>.from(json["user_favourite_cars"].map((x) => UserFavouriteCar.fromJson(x))),
    totalBookings: json["total_bookings"],
    carsRatings: List<CarsRating>.from(json["cars_ratings"].map((x) => CarsRating.fromJson(x))),
    carsPlans: List<CarsPlan>.from(json["cars_plans"].map((x) => CarsPlan.fromJson(x))),
    carsPlansCount: json["cars_plans_count"],
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
    "bookings_addresses": List<dynamic>.from(bookingsAddresses!.map((x) => x.toJson())),
    "cars_details": carsDetails!.toJson(),
    "users_companies_details": List<dynamic>.from(usersCompaniesDetails!.map((x) => x.toJson())),
    "user_favourite_cars": List<dynamic>.from(userFavouriteCars!.map((x) => x.toJson())),
    "total_bookings": totalBookings,
    "cars_ratings": List<dynamic>.from(carsRatings!.map((x) => x.toJson())),
    "cars_plans": List<dynamic>.from(carsPlans!.map((x) => x.toJson())),
    "cars_plans_count": carsPlansCount,
  };
}

class BookingsAddress {
  BookingsAddress({
    this.bookingsAddressesId,
    this.bookingsId,
    this.addressType,
    this.streetAddressLine1,
    this.streetAddressLine2,
    this.city,
    this.postCode,
    this.state,
    this.country,
    this.dateAdded,
  });

  int? bookingsAddressesId;
  int? bookingsId;
  String? addressType;
  String? streetAddressLine1;
  String? streetAddressLine2;
  String? city;
  String? postCode;
  String? state;
  String? country;
  DateTime? dateAdded;

  factory BookingsAddress.fromJson(Map<String, dynamic> json) => BookingsAddress(
    bookingsAddressesId: json["bookings_addresses_id"],
    bookingsId: json["bookings_id"],
    addressType: json["address_type"],
    streetAddressLine1: json["street_address_line1"],
    streetAddressLine2: json["street_address_line2"],
    city: json["city"],
    postCode: json["post_code"],
    state: json["state"],
    country: json["country"],
    dateAdded: DateTime.parse(json["date_added"]),
  );

  Map<String, dynamic> toJson() => {
    "bookings_addresses_id": bookingsAddressesId,
    "bookings_id": bookingsId,
    "address_type": addressType,
    "street_address_line1": streetAddressLine1,
    "street_address_line2": streetAddressLine2,
    "city": city,
    "post_code": postCode,
    "state": state,
    "country": country,
    "date_added": dateAdded!.toIso8601String(),
  };
}

class CarsDetails {
  CarsDetails({
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
    this.carsTypes,
    this.carsMakes,
    this.carsModels,
    this.carsColors,
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
  String? carsTypes;
  CarsMakes? carsMakes;
  String? carsModels;
  CarsColors? carsColors;

  factory CarsDetails.fromJson(Map<String, dynamic> json) => CarsDetails(
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
    carsTypes: json["cars_types"],
    carsMakes: CarsMakes.fromJson(json["cars_makes"]),
    carsModels: json["cars_models"],
    carsColors: CarsColors.fromJson(json["cars_colors"]),
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
    "cars_types": carsTypes,
    "cars_makes": carsMakes!.toJson(),
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

class CarsMakes {
  CarsMakes({
    this.carsMakesId,
    this.name,
    this.image,
    this.status,
  });

  int? carsMakesId;
  String? name;
  String? image;
  String? status;

  factory CarsMakes.fromJson(Map<String, dynamic> json) => CarsMakes(
    carsMakesId: json["cars_makes_id"],
    name: json["name"],
    image: json["image"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "cars_makes_id": carsMakesId,
    "name": name,
    "image": image,
    "status": status,
  };
}

class CarsPlan {
  CarsPlan({
    this.bookingsPlansEvId,
    this.bookingsId,
    this.carsId,
    this.planStartDate,
    this.planEndDate,
    this.months,
    this.discountPercentage,
    this.pricePerMonth,
  });

  int? bookingsPlansEvId;
  int? bookingsId;
  int? carsId;
  DateTime? planStartDate;
  DateTime? planEndDate;
  int? months;
  String? discountPercentage;
  String? pricePerMonth;

  factory CarsPlan.fromJson(Map<String, dynamic> json) => CarsPlan(
    bookingsPlansEvId: json["bookings_plans_ev_id"],
    bookingsId: json["bookings_id"],
    carsId: json["cars_id"],
    planStartDate: DateTime.parse(json["plan_start_date"]),
    planEndDate: DateTime.parse(json["plan_end_date"]),
    months: json["months"],
    discountPercentage: json["discount_percentage"],
    pricePerMonth: json["price_per_month"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_plans_ev_id": bookingsPlansEvId,
    "bookings_id": bookingsId,
    "cars_id": carsId,
    "plan_start_date": "${planStartDate!.year.toString().padLeft(4, '0')}-${planStartDate!.month.toString().padLeft(2, '0')}-${planStartDate!.day.toString().padLeft(2, '0')}",
    "plan_end_date": "${planEndDate!.year.toString().padLeft(4, '0')}-${planEndDate!.month.toString().padLeft(2, '0')}-${planEndDate!.day.toString().padLeft(2, '0')}",
    "months": months,
    "discount_percentage": discountPercentage,
    "price_per_month": pricePerMonth,
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

class UserFavouriteCar {
  UserFavouriteCar({
    this.carsFavouriteId,
    this.usersCustomersId,
    this.carsId,
    this.dateAdded,
    this.status,
  });

  int? carsFavouriteId;
  int? usersCustomersId;
  int? carsId;
  DateTime? dateAdded;
  String? status;

  factory UserFavouriteCar.fromJson(Map<String, dynamic> json) => UserFavouriteCar(
    carsFavouriteId: json["cars_favourite_id"],
    usersCustomersId: json["users_customers_id"],
    carsId: json["cars_id"],
    dateAdded: DateTime.parse(json["date_added"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "cars_favourite_id": carsFavouriteId,
    "users_customers_id": usersCustomersId,
    "cars_id": carsId,
    "date_added": dateAdded!.toIso8601String(),
    "status": status,
  };
}

class UsersCompaniesDetail {
  UsersCompaniesDetail({
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
  dynamic dateModified;

  factory UsersCompaniesDetail.fromJson(Map<String, dynamic> json) => UsersCompaniesDetail(
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
    dateModified: json["date_modified"],
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
    "date_modified": dateModified,
  };
}
