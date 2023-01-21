import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  UserLoginModel({
    this.status,
    this.data,
  });

  String? status;
  Data? data;

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.usersCustomersId,
    this.oneSignalId,
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
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;
  String? accountType;
  String? socialAccType;
  String? googleAccessToken;
  dynamic location;
  dynamic about;
  dynamic profilePic;
  DateTime? dateAdded;
  String? verifyCode;
  String? notifications;
  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    usersCustomersId: json["users_customers_id"],
    oneSignalId: json["one_signal_id"],
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
