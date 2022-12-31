class MessageDetailsModel {
  String? senderType;
  String? date;
  String? time;
  String? msgType;
  String? message;
  UsersData? usersData;

  MessageDetailsModel(
      {this.senderType,
        this.date,
        this.time,
        this.msgType,
        this.message,
        this.usersData});

  MessageDetailsModel.fromJson(Map<String, dynamic> json) {
    senderType = json['sender_type'];
    date = json['date'];
    time = json['time'];
    msgType = json['msgType'];
    message = json['message'];
    usersData = json['users_data'] != null
        ? new UsersData.fromJson(json['users_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_type'] = this.senderType;
    data['date'] = this.date;
    data['time'] = this.time;
    data['msgType'] = this.msgType;
    data['message'] = this.message;
    if (this.usersData != null) {
      data['users_data'] = this.usersData!.toJson();
    }
    return data;
  }
}

class UsersData {
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
  Null? location;
  Null? about;
  String? profilePic;
  String? dateAdded;
  String? verifyCode;
  String? notifications;
  String? status;
  int? usersCompaniesId;
  String? companyName;
  String? bankName;
  String? bankAccountNumber;
  String? companyLocation;
  String? companyRegistrationNumber;
  String? companyLogo;
  String? paypalEmail;
  int? verifyEmailOtp;
  int? forgotPasswordOtp;
  String? dateModified;

  UsersData(
      {this.usersCustomersId,
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
        this.usersCompaniesId,
        this.companyName,
        this.bankName,
        this.bankAccountNumber,
        this.companyLocation,
        this.companyRegistrationNumber,
        this.companyLogo,
        this.paypalEmail,
        this.verifyEmailOtp,
        this.forgotPasswordOtp,
        this.dateModified});

  UsersData.fromJson(Map<String, dynamic> json) {
    usersCustomersId = json['users_customers_id'];
    oneSignalId = json['one_signal_id'];
    verifiedBadge = json['verified_badge'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    accountType = json['account_type'];
    socialAccType = json['social_acc_type'];
    googleAccessToken = json['google_access_token'];
    location = json['location'];
    about = json['about'];
    profilePic = json['profile_pic'];
    dateAdded = json['date_added'];
    verifyCode = json['verify_code'];
    notifications = json['notifications'];
    status = json['status'];
    usersCompaniesId = json['users_companies_id'];
    companyName = json['company_name'];
    bankName = json['bank_name'];
    bankAccountNumber = json['bank_account_number'];
    companyLocation = json['company_location'];
    companyRegistrationNumber = json['company_registration_number'];
    companyLogo = json['company_logo'];
    paypalEmail = json['paypal_email'];
    verifyEmailOtp = json['verify_email_otp'];
    forgotPasswordOtp = json['forgotPasswordOtp'];
    dateModified = json['date_modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_customers_id'] = this.usersCustomersId;
    data['one_signal_id'] = this.oneSignalId;
    data['verified_badge'] = this.verifiedBadge;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['account_type'] = this.accountType;
    data['social_acc_type'] = this.socialAccType;
    data['google_access_token'] = this.googleAccessToken;
    data['location'] = this.location;
    data['about'] = this.about;
    data['profile_pic'] = this.profilePic;
    data['date_added'] = this.dateAdded;
    data['verify_code'] = this.verifyCode;
    data['notifications'] = this.notifications;
    data['status'] = this.status;
    data['users_companies_id'] = this.usersCompaniesId;
    data['company_name'] = this.companyName;
    data['bank_name'] = this.bankName;
    data['bank_account_number'] = this.bankAccountNumber;
    data['company_location'] = this.companyLocation;
    data['company_registration_number'] = this.companyRegistrationNumber;
    data['company_logo'] = this.companyLogo;
    data['paypal_email'] = this.paypalEmail;
    data['verify_email_otp'] = this.verifyEmailOtp;
    data['forgotPasswordOtp'] = this.forgotPasswordOtp;
    data['date_modified'] = this.dateModified;
    return data;
  }
}
