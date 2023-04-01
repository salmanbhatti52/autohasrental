import 'dart:convert';

CancelUpcomingBookingDetailsPageModel cancelledBookingModelFromJson(String str) => CancelUpcomingBookingDetailsPageModel.fromJson(json.decode(str));

String cancelledBookingModelToJson(CancelUpcomingBookingDetailsPageModel data) => json.encode(data.toJson());

class CancelUpcomingBookingDetailsPageModel {
  CancelUpcomingBookingDetailsPageModel({
    this.status,
    this.data,
  });

  String? status;
  List<Datum>? data;

  factory CancelUpcomingBookingDetailsPageModel.fromJson(Map<String, dynamic> json) => CancelUpcomingBookingDetailsPageModel(
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
    this.carsId,
    this.usersCustomersId,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.totalCost,
    this.drivingLicense,
    this.companyLocation,
    this.dateAdded,
    this.status,
    this.carsDetails,
    this.usersCompanyDetails,
    this.userFavouriteCars,
    this.totalBookings,
    this.carsRatings,
  });

  int? bookingsId;
  int? carsId;
  int? usersCustomersId;
  DateTime? startDate;
  String? startTime;
  DateTime? endDate;
  String? endTime;
  int? totalCost;
  String? drivingLicense;
  dynamic companyLocation;
  DateTime? dateAdded;
  String? status;
  List<CarsDetail>? carsDetails;
  List<UsersCompanyDetail>? usersCompanyDetails;
  List<UserFavouriteCar>? userFavouriteCars;
  int? totalBookings;
  List<dynamic>? carsRatings;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    bookingsId: json["bookings_id"],
    carsId: json["cars_id"],
    usersCustomersId: json["users_customers_id"],
    startDate: DateTime.parse(json["start_date"]),
    startTime: json["start_time"],
    endDate: DateTime.parse(json["end_date"]),
    endTime: json["end_time"],
    totalCost: json["total_cost"],
    drivingLicense: json["driving_license"],
    companyLocation: json["company_location"],
    dateAdded: DateTime.parse(json["date_added"]),
    status: json["status"],
    carsDetails: List<CarsDetail>.from(json["cars_details"].map((x) => CarsDetail.fromJson(x))),
    usersCompanyDetails: List<UsersCompanyDetail>.from(json["users_company_details"].map((x) => UsersCompanyDetail.fromJson(x))),
    userFavouriteCars: List<UserFavouriteCar>.from(json["user_favourite_cars"].map((x) => UserFavouriteCar.fromJson(x))),
    totalBookings: json["total_bookings"],
    carsRatings: List<dynamic>.from(json["cars_ratings"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "bookings_id": bookingsId,
    "cars_id": carsId,
    "users_customers_id": usersCustomersId,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "end_time": endTime,
    "total_cost": totalCost,
    "driving_license": drivingLicense,
    "company_location": companyLocation,
    "date_added": dateAdded!.toIso8601String(),
    "status": status,
    "cars_details": List<dynamic>.from(carsDetails!.map((x) => x.toJson())),
    "users_company_details": List<dynamic>.from(usersCompanyDetails!.map((x) => x.toJson())),
    "user_favourite_cars": List<dynamic>.from(userFavouriteCars!.map((x) => x.toJson())),
    "total_bookings": totalBookings,
    "cars_ratings": List<dynamic>.from(carsRatings!.map((x) => x)),
  };
}

class CarsDetail {
  CarsDetail({
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
  dynamic dateModified;
  String? status;

  factory CarsDetail.fromJson(Map<String, dynamic> json) => CarsDetail(
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
    dateModified: json["date_modified"],
    status: json["status"],
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
    "date_modified": dateModified,
    "status": status,
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
    this.companyRegistrationNumber,
    this.companyLocation,
    this.companyLogo,
    this.phone,
    this.about,
    this.bankName,
    this.bankAccountNumber,
    this.paypalEmail,
    this.forgotPasswordOtp,
    this.dateAdded,
    this.dateModified,
    this.status,
  });

  int? usersCompaniesId;
  String? companyName;
  String? email;
  String? password;
  String? companyRegistrationNumber;
  String? companyLocation;
  String? companyLogo;
  String? phone;
  dynamic about;
  dynamic bankName;
  dynamic bankAccountNumber;
  String? paypalEmail;
  int? forgotPasswordOtp;
  DateTime? dateAdded;
  dynamic dateModified;
  String? status;

  factory UsersCompanyDetail.fromJson(Map<String, dynamic> json) => UsersCompanyDetail(
    usersCompaniesId: json["users_companies_id"],
    companyName: json["company_name"],
    email: json["email"],
    password: json["password"],
    companyRegistrationNumber: json["company_registration_number"],
    companyLocation: json["company_location"],
    companyLogo: json["company_logo"],
    phone: json["phone"],
    about: json["about"],
    bankName: json["bank_name"],
    bankAccountNumber: json["bank_account_number"],
    paypalEmail: json["paypal_email"],
    forgotPasswordOtp: json["forgotPasswordOtp"],
    dateAdded: DateTime.parse(json["date_added"]),
    dateModified: json["date_modified"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "users_companies_id": usersCompaniesId,
    "company_name": companyName,
    "email": email,
    "password": password,
    "company_registration_number": companyRegistrationNumber,
    "company_location": companyLocation,
    "company_logo": companyLogo,
    "phone": phone,
    "about": about,
    "bank_name": bankName,
    "bank_account_number": bankAccountNumber,
    "paypal_email": paypalEmail,
    "forgotPasswordOtp": forgotPasswordOtp,
    "date_added": dateAdded!.toIso8601String(),
    "date_modified": dateModified,
    "status": status,
  };
}
