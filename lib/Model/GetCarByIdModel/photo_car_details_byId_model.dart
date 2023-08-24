// To parse this JSON data, do
//
//     final carDetailsByIdModelPhoto = carDetailsByIdModelPhotoFromJson(jsonString);

import 'dart:convert';

CarDetailsByIdModelPhoto carDetailsByIdModelPhotoFromJson(String str) => CarDetailsByIdModelPhoto.fromJson(json.decode(str));

String carDetailsByIdModelPhotoToJson(CarDetailsByIdModelPhoto data) => json.encode(data.toJson());

class CarDetailsByIdModelPhoto {
  String? status;
  Data? data;

  CarDetailsByIdModelPhoto({
    this.status,
    this.data,
  });

  factory CarDetailsByIdModelPhoto.fromJson(Map<String, dynamic> json) => CarDetailsByIdModelPhoto(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  int carsId;
  int usersCompaniesId;
  String vehicalName;
  String licensePlate;
  String discountPercentage;
  String carsUsageType;
  int carsTypeId;
  int carsMakesId;
  int carsModelsId;
  int year;
  int carsColorsId;
  String description;
  dynamic featuresSuv;
  String featuresSeats;
  String featuresSpeed;
  String featuresAutomatic;
  dynamic featuresDrives;
  String featuresDoors;
  String featuresElectric;
  String featuresEngineCapacity;
  String featuresFuelCapacity;
  String featuresMeterReading;
  dynamic featuresNewCars;
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  String rating;
  DateTime dateAdded;
  dynamic dateModified;
  String status;
  CarsM carsMakes;
  CarsM carsModels;
  CarsColors carsColors;
  List<dynamic> carsRatings;
  int totalBookings;
  UsersCompanies usersCompanies;
  String favouriteStatus;
  List<CarsPlan> carsPlans;

  Data({
    required this.carsId,
    required this.usersCompaniesId,
    required this.vehicalName,
    required this.licensePlate,
    required this.discountPercentage,
    required this.carsUsageType,
    required this.carsTypeId,
    required this.carsMakesId,
    required this.carsModelsId,
    required this.year,
    required this.carsColorsId,
    required this.description,
    required this.featuresSuv,
    required this.featuresSeats,
    required this.featuresSpeed,
    required this.featuresAutomatic,
    required this.featuresDrives,
    required this.featuresDoors,
    required this.featuresElectric,
    required this.featuresEngineCapacity,
    required this.featuresFuelCapacity,
    required this.featuresMeterReading,
    required this.featuresNewCars,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.rating,
    required this.dateAdded,
    required this.dateModified,
    required this.status,
    required this.carsMakes,
    required this.carsModels,
    required this.carsColors,
    required this.carsRatings,
    required this.totalBookings,
    required this.usersCompanies,
    required this.favouriteStatus,
    required this.carsPlans,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    carsRatings: List<dynamic>.from(json["cars_ratings"].map((x) => x)),
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
    "date_added": dateAdded.toIso8601String(),
    "date_modified": dateModified,
    "status": status,
    "cars_makes": carsMakes.toJson(),
    "cars_models": carsModels.toJson(),
    "cars_colors": carsColors.toJson(),
    "cars_ratings": List<dynamic>.from(carsRatings.map((x) => x)),
    "total_bookings": totalBookings,
    "users_companies": usersCompanies.toJson(),
    "favourite_status": favouriteStatus,
    "cars_plans": List<dynamic>.from(carsPlans.map((x) => x.toJson())),
  };
}

class CarsColors {
  int carsColorsId;
  String name;
  String status;

  CarsColors({
    required this.carsColorsId,
    required this.name,
    required this.status,
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

class CarsM {
  int carsMakesId;
  String name;
  String image;
  String status;
  int? carsModelsId;

  CarsM({
    required this.carsMakesId,
    required this.name,
    required this.image,
    required this.status,
    this.carsModelsId,
  });

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
  int carsPlansPgId;
  int carsId;
  String packageType;
  String pricePerHour;
  String driverCharges;
  String deposit;
  int discountedPricePerHour;

  CarsPlan({
    required this.carsPlansPgId,
    required this.carsId,
    required this.packageType,
    required this.pricePerHour,
    required this.driverCharges,
    required this.deposit,
    required this.discountedPricePerHour,
  });

  factory CarsPlan.fromJson(Map<String, dynamic> json) => CarsPlan(
    carsPlansPgId: json["cars_plans_pg_id"],
    carsId: json["cars_id"],
    packageType: json["package_type"],
    pricePerHour: json["price_per_hour"],
    driverCharges: json["driver_charges"],
    deposit: json["deposit"],
    discountedPricePerHour: json["discounted_price_per_hour"],
  );

  Map<String, dynamic> toJson() => {
    "cars_plans_pg_id": carsPlansPgId,
    "cars_id": carsId,
    "package_type": packageType,
    "price_per_hour": pricePerHour,
    "driver_charges": driverCharges,
    "deposit": deposit,
    "discounted_price_per_hour": discountedPricePerHour,
  };
}

class UsersCompanies {
  int usersCompaniesId;
  String email;
  String password;
  String phone;
  String companyName;
  String companyRegistrationNumber;
  String companyLocation;
  String companyLogo;
  dynamic about;
  int verifyEmailOtp;
  dynamic forgotPasswordOtp;
  dynamic bankName;
  dynamic bankAccountNumber;
  dynamic paypalEmail;
  String online;
  String status;
  DateTime dateAdded;
  dynamic dateModified;

  UsersCompanies({
    required this.usersCompaniesId,
    required this.email,
    required this.password,
    required this.phone,
    required this.companyName,
    required this.companyRegistrationNumber,
    required this.companyLocation,
    required this.companyLogo,
    required this.about,
    required this.verifyEmailOtp,
    required this.forgotPasswordOtp,
    required this.bankName,
    required this.bankAccountNumber,
    required this.paypalEmail,
    required this.online,
    required this.status,
    required this.dateAdded,
    required this.dateModified,
  });

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
    "date_added": dateAdded.toIso8601String(),
    "date_modified": dateModified,
  };
}
