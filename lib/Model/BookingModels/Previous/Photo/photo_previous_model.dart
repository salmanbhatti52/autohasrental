// To parse this JSON data, do
//
//     final photoPreviousModel = photoPreviousModelFromJson(jsonString);

import 'dart:convert';

PhotoPreviousModel photoPreviousModelFromJson(String str) => PhotoPreviousModel.fromJson(json.decode(str));

String photoPreviousModelToJson(PhotoPreviousModel data) => json.encode(data.toJson());

class PhotoPreviousModel {
  String? status;
  List<Datum>? data;

  PhotoPreviousModel({
    this.status,
    this.data,
  });

  factory PhotoPreviousModel.fromJson(Map<String, dynamic> json) => PhotoPreviousModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) : null,
    // data: List<DatumPhotoPrevious>.from(json["data"].map((x) => DatumPhotoPrevious.fromJson(x))) != null ? List<DatumPhotoPrevious>.from(json["data"].map((x) => DatumPhotoPrevious.fromJson(x))): null,

  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
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
  List<dynamic>? userFavouriteCars;
  int? totalBookings;
  List<dynamic>? carsRatings;
  List<CarsPlan>? carsPlans;
  int? carsPlansCount;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    userFavouriteCars: List<dynamic>.from(json["user_favourite_cars"].map((x) => x)),
    totalBookings: json["total_bookings"],
    carsRatings: List<dynamic>.from(json["cars_ratings"].map((x) => x)),
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
    "user_favourite_cars": List<dynamic>.from(userFavouriteCars!.map((x) => x)),
    "total_bookings": totalBookings,
    "cars_ratings": List<dynamic>.from(carsRatings!.map((x) => x)),
    "cars_plans": List<dynamic>.from(carsPlans!.map((x) => x.toJson())),
    "cars_plans_count": carsPlansCount,
  };
}

class BookingsAddress {
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
  dynamic featuresSuv;
  String? featuresSeats;
  String? featuresSpeed;
  String? featuresAutomatic;
  String?  featuresDrives;
  String? featuresDoors;
  String? featuresElectric;
  String? featuresEngineCapacity;
  String? featuresFuelCapacity;
  String? featuresMeterReading;
  dynamic featuresNewCars;
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
  int? carsColorsId;
  String? name;
  String? status;

  CarsColors({
   this.carsColorsId,
   this.name,
   this.status,
  });

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
  int? carsMakesId;
  String? name;
  String? image;
  String? status;

  CarsMakes({
    this.carsMakesId,
    this.name,
    this.image,
    this.status,
  });

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
  int? bookingsPlansPgId;
  int? bookingsId;
  int? carsId;
  DateTime? planDate;
  String? startTime;
  String? endTime;
  DateTime? startDate;
  DateTime? endDate;
  int? totalHours;
  String? discountPercentage;
  String? pricePerHour;
  String? driverCharges;
  String? deposit;

  CarsPlan({
    this.bookingsPlansPgId,
    this.bookingsId,
    this.carsId,
    this.planDate,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.totalHours,
    this.discountPercentage,
    this.pricePerHour,
    this.driverCharges,
    this.deposit,
  });

  factory CarsPlan.fromJson(Map<String, dynamic> json) => CarsPlan(
    bookingsPlansPgId: json["bookings_plans_pg_id"],
    bookingsId: json["bookings_id"],
    carsId: json["cars_id"],
    planDate: json["plan_date"] == null ? null : DateTime.parse(json["plan_date"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    totalHours: json["total_hours"],
    discountPercentage: json["discount_percentage"],
    pricePerHour: json["price_per_hour"],
    driverCharges: json["driver_charges"],
    deposit: json["deposit"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_plans_pg_id": bookingsPlansPgId,
    "bookings_id": bookingsId,
    "cars_id": carsId,
    "plan_date": "${planDate!.year.toString().padLeft(4, '0')}-${planDate!.month.toString().padLeft(2, '0')}-${planDate!.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_time": endTime,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "total_hours": totalHours,
    "discount_percentage": discountPercentage,
    "price_per_hour": pricePerHour,
    "driver_charges": driverCharges,
    "deposit": deposit,
  };
}

class UsersCompaniesDetail {
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
  dynamic forgotPasswordOtp;
  dynamic bankName;
  dynamic bankAccountNumber;
  dynamic paypalEmail;
  String? online;
  String? status;
  DateTime? dateAdded;
  dynamic dateModified;

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
