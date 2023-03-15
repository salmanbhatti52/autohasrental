// class SearchModel1 {
//   int? carsId;
//   int? usersCompaniesId;
//   String? vehicalName;
//   String? licensePlate;
//   String? discountPercentage;
//   String? carsUsageType;
//   int? carsTypeId;
//   int? carsMakesId;
//   int? carsModelsId;
//   int? year;
//   int? carsColorsId;
//   String? description;
//   String? featuresSuv;
//   String? featuresSeats;
//   String? featuresSpeed;
//   String? featuresAutomatic;
//   String? featuresDrives;
//   String? featuresDoors;
//   String? featuresElectric;
//   String? featuresEngineCapacity;
//   String? featuresFuelCapacity;
//   String? featuresMeterReading;
//   String? featuresNewCars;
//   String? image1;
//   String? image2;
//   String? image3;
//   String? image4;
//   String? image5;
//   String? rating;
//   String? dateAdded;
//   String? dateModified;
//   String? status;
//   CarsMakes? carsMakes;
//   CarsModels? carsModels;
//   CarsColors? carsColors;
//   List<CarsRatings>? carsRatings;
//   int? totalBookings;
//   UsersCompanies? usersCompanies;
//   String? favouriteStatus;
//   List<CarsPlans>? carsPlans;
//
//   SearchModel1(
//       {this.carsId,
//         this.usersCompaniesId,
//         this.vehicalName,
//         this.licensePlate,
//         this.discountPercentage,
//         this.carsUsageType,
//         this.carsTypeId,
//         this.carsMakesId,
//         this.carsModelsId,
//         this.year,
//         this.carsColorsId,
//         this.description,
//         this.featuresSuv,
//         this.featuresSeats,
//         this.featuresSpeed,
//         this.featuresAutomatic,
//         this.featuresDrives,
//         this.featuresDoors,
//         this.featuresElectric,
//         this.featuresEngineCapacity,
//         this.featuresFuelCapacity,
//         this.featuresMeterReading,
//         this.featuresNewCars,
//         this.image1,
//         this.image2,
//         this.image3,
//         this.image4,
//         this.image5,
//         this.rating,
//         this.dateAdded,
//         this.dateModified,
//         this.status,
//         this.carsMakes,
//         this.carsModels,
//         this.carsColors,
//         this.carsRatings,
//         this.totalBookings,
//         this.usersCompanies,
//         this.favouriteStatus,
//         this.carsPlans});
//
//   SearchModel1.fromJson(Map<String, dynamic> json) {
//     carsId = json['cars_id'];
//     usersCompaniesId = json['users_companies_id'];
//     vehicalName = json['vehical_name'];
//     licensePlate = json['license_plate'];
//     discountPercentage = json['discount_percentage'];
//     carsUsageType = json['cars_usage_type'];
//     carsTypeId = json['cars_type_id'];
//     carsMakesId = json['cars_makes_id'];
//     carsModelsId = json['cars_models_id'];
//     year = json['year'];
//     carsColorsId = json['cars_colors_id'];
//     description = json['description'];
//     featuresSuv = json['features_suv'];
//     featuresSeats = json['features_seats'];
//     featuresSpeed = json['features_speed'];
//     featuresAutomatic = json['features_automatic'];
//     featuresDrives = json['features_drives'];
//     featuresDoors = json['features_doors'];
//     featuresElectric = json['features_electric'];
//     featuresEngineCapacity = json['features_engine_capacity'];
//     featuresFuelCapacity = json['features_fuel_capacity'];
//     featuresMeterReading = json['features_meter_reading'];
//     featuresNewCars = json['features_new_cars'];
//     image1 = json['image1'];
//     image2 = json['image2'];
//     image3 = json['image3'];
//     image4 = json['image4'];
//     image5 = json['image5'];
//     rating = json['rating'];
//     dateAdded = json['date_added'];
//     dateModified = json['date_modified'];
//     status = json['status'];
//     carsMakes = json['cars_makes'] != null
//         ? new CarsMakes.fromJson(json['cars_makes'])
//         : null;
//     carsModels = json['cars_models'] != null
//         ? new CarsModels.fromJson(json['cars_models'])
//         : null;
//     carsColors = json['cars_colors'] != null
//         ? new CarsColors.fromJson(json['cars_colors'])
//         : null;
//     if (json['cars_ratings'] != null) {
//       carsRatings = <CarsRatings>[];
//       json['cars_ratings'].forEach((v) {
//         carsRatings!.add(new CarsRatings.fromJson(v));
//       });
//     }
//     totalBookings = json['total_bookings'];
//     usersCompanies = json['users_companies'] != null
//         ? new UsersCompanies.fromJson(json['users_companies'])
//         : null;
//     favouriteStatus = json['favourite_status'];
//     if (json['cars_plans'] != null) {
//       carsPlans = <CarsPlans>[];
//       json['cars_plans'].forEach((v) {
//         carsPlans!.add(new CarsPlans.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cars_id'] = this.carsId;
//     data['users_companies_id'] = this.usersCompaniesId;
//     data['vehical_name'] = this.vehicalName;
//     data['license_plate'] = this.licensePlate;
//     data['discount_percentage'] = this.discountPercentage;
//     data['cars_usage_type'] = this.carsUsageType;
//     data['cars_type_id'] = this.carsTypeId;
//     data['cars_makes_id'] = this.carsMakesId;
//     data['cars_models_id'] = this.carsModelsId;
//     data['year'] = this.year;
//     data['cars_colors_id'] = this.carsColorsId;
//     data['description'] = this.description;
//     data['features_suv'] = this.featuresSuv;
//     data['features_seats'] = this.featuresSeats;
//     data['features_speed'] = this.featuresSpeed;
//     data['features_automatic'] = this.featuresAutomatic;
//     data['features_drives'] = this.featuresDrives;
//     data['features_doors'] = this.featuresDoors;
//     data['features_electric'] = this.featuresElectric;
//     data['features_engine_capacity'] = this.featuresEngineCapacity;
//     data['features_fuel_capacity'] = this.featuresFuelCapacity;
//     data['features_meter_reading'] = this.featuresMeterReading;
//     data['features_new_cars'] = this.featuresNewCars;
//     data['image1'] = this.image1;
//     data['image2'] = this.image2;
//     data['image3'] = this.image3;
//     data['image4'] = this.image4;
//     data['image5'] = this.image5;
//     data['rating'] = this.rating;
//     data['date_added'] = this.dateAdded;
//     data['date_modified'] = this.dateModified;
//     data['status'] = this.status;
//     if (this.carsMakes != null) {
//       data['cars_makes'] = this.carsMakes!.toJson();
//     }
//     if (this.carsModels != null) {
//       data['cars_models'] = this.carsModels!.toJson();
//     }
//     if (this.carsColors != null) {
//       data['cars_colors'] = this.carsColors!.toJson();
//     }
//     if (this.carsRatings != null) {
//       data['cars_ratings'] = this.carsRatings!.map((v) => v.toJson()).toList();
//     }
//     data['total_bookings'] = this.totalBookings;
//     if (this.usersCompanies != null) {
//       data['users_companies'] = this.usersCompanies!.toJson();
//     }
//     data['favourite_status'] = this.favouriteStatus;
//     if (this.carsPlans != null) {
//       data['cars_plans'] = this.carsPlans!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class CarsMakes {
//   int? carsMakesId;
//   String? name;
//   String? image;
//   String? status;
//
//   CarsMakes({this.carsMakesId, this.name, this.image, this.status});
//
//   CarsMakes.fromJson(Map<String, dynamic> json) {
//     carsMakesId = json['cars_makes_id'];
//     name = json['name'];
//     image = json['image'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cars_makes_id'] = this.carsMakesId;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['status'] = this.status;
//     return data;
//   }
// }
//
// class CarsModels {
//   int? carsModelsId;
//   int? carsMakesId;
//   String? name;
//   String? image;
//   String? status;
//
//   CarsModels(
//       {this.carsModelsId,
//         this.carsMakesId,
//         this.name,
//         this.image,
//         this.status});
//
//   CarsModels.fromJson(Map<String, dynamic> json) {
//     carsModelsId = json['cars_models_id'];
//     carsMakesId = json['cars_makes_id'];
//     name = json['name'];
//     image = json['image'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cars_models_id'] = this.carsModelsId;
//     data['cars_makes_id'] = this.carsMakesId;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['status'] = this.status;
//     return data;
//   }
// }
//
// class CarsColors {
//   int? carsColorsId;
//   String? name;
//   String? status;
//
//   CarsColors({this.carsColorsId, this.name, this.status});
//
//   CarsColors.fromJson(Map<String, dynamic> json) {
//     carsColorsId = json['cars_colors_id'];
//     name = json['name'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cars_colors_id'] = this.carsColorsId;
//     data['name'] = this.name;
//     data['status'] = this.status;
//     return data;
//   }
// }
//
// class CarsRatings {
//   int? carsRatingsId;
//   int? carsId;
//   int? usersCustomersId;
//   String? comments;
//   String? rateStars;
//   String? dateAdded;
//   List<UsersData>? usersData;
//
//   CarsRatings(
//       {this.carsRatingsId,
//         this.carsId,
//         this.usersCustomersId,
//         this.comments,
//         this.rateStars,
//         this.dateAdded,
//         this.usersData});
//
//   CarsRatings.fromJson(Map<String, dynamic> json) {
//     carsRatingsId = json['cars_ratings_id'];
//     carsId = json['cars_id'];
//     usersCustomersId = json['users_customers_id'];
//     comments = json['comments'];
//     rateStars = json['rate_stars'];
//     dateAdded = json['date_added'];
//     if (json['users_data'] != null) {
//       usersData = <UsersData>[];
//       json['users_data'].forEach((v) {
//         usersData!.add(new UsersData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cars_ratings_id'] = this.carsRatingsId;
//     data['cars_id'] = this.carsId;
//     data['users_customers_id'] = this.usersCustomersId;
//     data['comments'] = this.comments;
//     data['rate_stars'] = this.rateStars;
//     data['date_added'] = this.dateAdded;
//     if (this.usersData != null) {
//       data['users_data'] = this.usersData!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class UsersData {
//   int? usersCustomersId;
//   String? oneSignalId;
//   String? verifiedBadge;
//   String? firstName;
//   String? lastName;
//   String? phone;
//   String? email;
//   String? password;
//   String? accountType;
//   String? socialAccType;
//   String? googleAccessToken;
//   String? location;
//   String? about;
//   String? profilePic;
//   String? dateAdded;
//   String? verifyCode;
//   String? notifications;
//   String? status;
//
//   UsersData(
//       {this.usersCustomersId,
//         this.oneSignalId,
//         this.verifiedBadge,
//         this.firstName,
//         this.lastName,
//         this.phone,
//         this.email,
//         this.password,
//         this.accountType,
//         this.socialAccType,
//         this.googleAccessToken,
//         this.location,
//         this.about,
//         this.profilePic,
//         this.dateAdded,
//         this.verifyCode,
//         this.notifications,
//         this.status});
//
//   UsersData.fromJson(Map<String, dynamic> json) {
//     usersCustomersId = json['users_customers_id'];
//     oneSignalId = json['one_signal_id'];
//     verifiedBadge = json['verified_badge'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     phone = json['phone'];
//     email = json['email'];
//     password = json['password'];
//     accountType = json['account_type'];
//     socialAccType = json['social_acc_type'];
//     googleAccessToken = json['google_access_token'];
//     location = json['location'];
//     about = json['about'];
//     profilePic = json['profile_pic'];
//     dateAdded = json['date_added'];
//     verifyCode = json['verify_code'];
//     notifications = json['notifications'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['users_customers_id'] = this.usersCustomersId;
//     data['one_signal_id'] = this.oneSignalId;
//     data['verified_badge'] = this.verifiedBadge;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['account_type'] = this.accountType;
//     data['social_acc_type'] = this.socialAccType;
//     data['google_access_token'] = this.googleAccessToken;
//     data['location'] = this.location;
//     data['about'] = this.about;
//     data['profile_pic'] = this.profilePic;
//     data['date_added'] = this.dateAdded;
//     data['verify_code'] = this.verifyCode;
//     data['notifications'] = this.notifications;
//     data['status'] = this.status;
//     return data;
//   }
// }
//
// class UsersCompanies {
//   int? usersCompaniesId;
//   String? email;
//   String? password;
//   String? phone;
//   String? companyName;
//   String? companyRegistrationNumber;
//   String? companyLocation;
//   String? companyLogo;
//   Null? about;
//   int? verifyEmailOtp;
//   int? forgotPasswordOtp;
//   String? bankName;
//   String? bankAccountNumber;
//   String? paypalEmail;
//   String? online;
//   String? status;
//   String? dateAdded;
//   String? dateModified;
//
//   UsersCompanies(
//       {this.usersCompaniesId,
//         this.email,
//         this.password,
//         this.phone,
//         this.companyName,
//         this.companyRegistrationNumber,
//         this.companyLocation,
//         this.companyLogo,
//         this.about,
//         this.verifyEmailOtp,
//         this.forgotPasswordOtp,
//         this.bankName,
//         this.bankAccountNumber,
//         this.paypalEmail,
//         this.online,
//         this.status,
//         this.dateAdded,
//         this.dateModified});
//
//   UsersCompanies.fromJson(Map<String, dynamic> json) {
//     usersCompaniesId = json['users_companies_id'];
//     email = json['email'];
//     password = json['password'];
//     phone = json['phone'];
//     companyName = json['company_name'];
//     companyRegistrationNumber = json['company_registration_number'];
//     companyLocation = json['company_location'];
//     companyLogo = json['company_logo'];
//     about = json['about'];
//     verifyEmailOtp = json['verify_email_otp'];
//     forgotPasswordOtp = json['forgotPasswordOtp'];
//     bankName = json['bank_name'];
//     bankAccountNumber = json['bank_account_number'];
//     paypalEmail = json['paypal_email'];
//     online = json['online'];
//     status = json['status'];
//     dateAdded = json['date_added'];
//     dateModified = json['date_modified'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['users_companies_id'] = this.usersCompaniesId;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['phone'] = this.phone;
//     data['company_name'] = this.companyName;
//     data['company_registration_number'] = this.companyRegistrationNumber;
//     data['company_location'] = this.companyLocation;
//     data['company_logo'] = this.companyLogo;
//     data['about'] = this.about;
//     data['verify_email_otp'] = this.verifyEmailOtp;
//     data['forgotPasswordOtp'] = this.forgotPasswordOtp;
//     data['bank_name'] = this.bankName;
//     data['bank_account_number'] = this.bankAccountNumber;
//     data['paypal_email'] = this.paypalEmail;
//     data['online'] = this.online;
//     data['status'] = this.status;
//     data['date_added'] = this.dateAdded;
//     data['date_modified'] = this.dateModified;
//     return data;
//   }
// }
//
// class CarsPlans {
//   int? carsPlansDeId;
//   int? carsId;
//   String? planDate;
//   String? startTime;
//   String? endTime;
//   String? pricePerSlot;
//   int? discountedPricePerSlot;
//   int? carsPlansPgId;
//   String? pricePerHour;
//   dynamic discountedPricePerHour;
//   int? carsPlansEvId;
//   int? months;
//   String? pricePerMonth;
//   dynamic discountedPricePerMonth;
//
//   CarsPlans(
//       {this.carsPlansDeId,
//         this.carsId,
//         this.planDate,
//         this.startTime,
//         this.endTime,
//         this.pricePerSlot,
//         this.discountedPricePerSlot,
//         this.carsPlansPgId,
//         this.pricePerHour,
//         this.discountedPricePerHour,
//         this.carsPlansEvId,
//         this.months,
//         this.pricePerMonth,
//         this.discountedPricePerMonth});
//
//   CarsPlans.fromJson(Map<String, dynamic> json) {
//     carsPlansDeId = json['cars_plans_de_id'];
//     carsId = json['cars_id'];
//     planDate = json['plan_date'];
//     startTime = json['start_time'];
//     endTime = json['end_time'];
//     pricePerSlot = json['price_per_slot'];
//     discountedPricePerSlot = json['discounted_price_per_slot'];
//     carsPlansPgId = json['cars_plans_pg_id'];
//     pricePerHour = json['price_per_hour'];
//     discountedPricePerHour = json['discounted_price_per_hour'];
//     carsPlansEvId = json['cars_plans_ev_id'];
//     months = json['months'];
//     pricePerMonth = json['price_per_month'];
//     discountedPricePerMonth = json['discounted_price_per_month'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cars_plans_de_id'] = this.carsPlansDeId;
//     data['cars_id'] = this.carsId;
//     data['plan_date'] = this.planDate;
//     data['start_time'] = this.startTime;
//     data['end_time'] = this.endTime;
//     data['price_per_slot'] = this.pricePerSlot;
//     data['discounted_price_per_slot'] = this.discountedPricePerSlot;
//     data['cars_plans_pg_id'] = this.carsPlansPgId;
//     data['price_per_hour'] = this.pricePerHour;
//     data['discounted_price_per_hour'] = this.discountedPricePerHour;
//     data['cars_plans_ev_id'] = this.carsPlansEvId;
//     data['months'] = this.months;
//     data['price_per_month'] = this.pricePerMonth;
//     data['discounted_price_per_month'] = this.discountedPricePerMonth;
//     return data;
//   }
// }