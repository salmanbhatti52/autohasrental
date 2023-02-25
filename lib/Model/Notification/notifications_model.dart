import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    this.status,
    this.data,
  });

  String? status;
  List<Datum>? data;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
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
    this.notificationsId,
    this.bookingsId,
    this.sendersId,
    this.receiversId,
    this.message,
    this.dateAdded,
    this.dateModified,
    this.status,
    this.notificationDate,
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
  });

  int? notificationsId;
  int? bookingsId;
  int? sendersId;
  int? receiversId;
  String? message;
  DateTime? dateAdded;
  dynamic dateModified;
  String? status;
  DateTime? notificationDate;
  int? usersCompaniesId;
  String? companyName;
  String? email;
  String? password;
  String? phone;
  dynamic about;
  dynamic bankName;
  dynamic bankAccountNumber;
  String? companyLocation;
  String? companyRegistrationNumber;
  String? companyLogo;
  dynamic paypalEmail;
  int? verifyEmailOtp;
  int? forgotPasswordOtp;
  String? verified;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    notificationsId: json["notifications_id"],
    bookingsId: json["bookings_id"],
    sendersId: json["senders_id"],
    receiversId: json["receivers_id"],
    message: json["message"],
    dateAdded: DateTime.parse(json["date_added"]),
    dateModified: json["date_modified"],
    status: json["status"],
    notificationDate: DateTime.parse(json["notification_date"]),
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
  );

  Map<String, dynamic> toJson() => {
    "notifications_id": notificationsId,
    "bookings_id": bookingsId,
    "senders_id": sendersId,
    "receivers_id": receiversId,
    "message": message,
    "date_added": dateAdded!.toIso8601String(),
    "date_modified": dateModified,
    "status": status,
    "notification_date": notificationDate!.toIso8601String(),
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
  };
}
