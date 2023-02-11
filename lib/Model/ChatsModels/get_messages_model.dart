class GetMessageDetailsModel {
  String? senderType;
  String? date;
  String? time;
  String? msgType;
  String? message;
  UsersData? usersData;

  GetMessageDetailsModel(
      {this.senderType,
        this.date,
        this.time,
        this.msgType,
        this.message,
        this.usersData});

  GetMessageDetailsModel.fromJson(Map<String, dynamic> json) {
    senderType = json['sender_type'];
    date = json['date'];
    time = json['time'];
    msgType = json['msgType'];
    message = json['message'];
    usersData = json['users_data'] != null
        ? UsersData.fromJson(json['users_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_type'] = senderType;
    data['date'] = date;
    data['time'] = time;
    data['msgType'] = msgType;
    data['message'] = message;
    if (usersData != null) {
      data['users_data'] = usersData!.toJson();
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
  dynamic location;
  dynamic about;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['users_customers_id'] = usersCustomersId;
    data['one_signal_id'] = oneSignalId;
    data['verified_badge'] = verifiedBadge;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['account_type'] = accountType;
    data['social_acc_type'] = socialAccType;
    data['google_access_token'] = googleAccessToken;
    data['location'] = location;
    data['about'] = about;
    data['profile_pic'] = profilePic;
    data['date_added'] = dateAdded;
    data['verify_code'] = verifyCode;
    data['notifications'] = notifications;
    data['status'] = status;
    data['users_companies_id'] = usersCompaniesId;
    data['company_name'] = companyName;
    data['bank_name'] = bankName;
    data['bank_account_number'] = bankAccountNumber;
    data['company_location'] = companyLocation;
    data['company_registration_number'] = companyRegistrationNumber;
    data['company_logo'] = companyLogo;
    data['paypal_email'] = paypalEmail;
    data['verify_email_otp'] = verifyEmailOtp;
    data['forgotPasswordOtp'] = forgotPasswordOtp;
    data['date_modified'] = dateModified;
    return data;
  }
}

