import 'dart:convert';

NotificationsListModel notificationsListModelFromJson(String str) => NotificationsListModel.fromJson(json.decode(str));

String notificationsListModelToJson(NotificationsListModel data) => json.encode(data.toJson());

class NotificationsListModel {
  NotificationsListModel({
    this.status,
    this.data,
  });

  String? status;
  List<Datum>? data;

  factory NotificationsListModel.fromJson(Map<String, dynamic> json) => NotificationsListModel(
    status: json["status"],
    data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))): null,
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
    this.email,
    this.password,
    this.phone,
    this.companyName,
    this.companyRegistrationNumber,
    this.formattedDateTime,
    this.companyLocation,
    this.companyLogo,
    this.about,
    this.verifyEmailOtp,
    this.forgotPasswordOtp,
    this.bankName,
    this.bankAccountNumber,
    this.paypalEmail,
    this.online,
  });

  int? notificationsId;
  int? bookingsId;
  int? sendersId;
  int? receiversId;
  String? message;
  DateTime? dateAdded;
  DateTime? dateModified;
  String? status;
  DateTime? notificationDate;
  String? formattedDateTime;
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    notificationsId: json["notifications_id"],
    bookingsId: json["bookings_id"],
    sendersId: json["senders_id"],
    receiversId: json["receivers_id"],
    message: json["message"],
    dateAdded: DateTime.parse(json["date_added"]),
    dateModified: DateTime.parse(json["date_modified"]),
    status: json["status"],
    notificationDate: DateTime.parse(json["notification_date"]),
    usersCompaniesId: json["users_companies_id"],
    email: json["email"],
    password: json["password"],
    formattedDateTime: json["formatted_date_time"],
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
  );

  Map<String, dynamic> toJson() => {
    "notifications_id": notificationsId,
    "bookings_id": bookingsId,
    "senders_id": sendersId,
    "receivers_id": receiversId,
    "message": message,
    "formatted_date_time": formattedDateTime,
    "date_added": dateAdded!.toIso8601String(),
    "date_modified": dateModified!.toIso8601String(),
    "status": status,
    "notification_date": notificationDate!.toIso8601String(),
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
  };
}
