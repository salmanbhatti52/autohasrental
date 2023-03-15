// class GetLiveMessagesModel {
//   String? senderType;
//   String? date;
//   String? time;
//   String? msgType;
//   String? message;
//   UsersData? usersData;
//
//   GetLiveMessagesModel(
//       {this.senderType,
//         this.date,
//         this.time,
//         this.msgType,
//         this.message,
//         this.usersData});
//
//   GetLiveMessagesModel.fromJson(Map<String, dynamic> json) {
//     senderType = json['sender_type'];
//     date = json['date'];
//     time = json['time'];
//     msgType = json['msgType'];
//     message = json['message'];
//     usersData = json['users_data'] != null
//         ? new UsersData.fromJson(json['users_data'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['sender_type'] = this.senderType;
//     data['date'] = this.date;
//     data['time'] = this.time;
//     data['msgType'] = this.msgType;
//     data['message'] = this.message;
//     if (this.usersData != null) {
//       data['users_data'] = this.usersData!.toJson();
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
//   int? usersSystemId;
//   int? usersSystemRolesId;
//   String? mobile;
//   String? city;
//   String? address;
//   String? userImage;
//   String? isDeleted;
//   Null? createdAt;
//   Null? updatedAt;
//   Null? deletedAt;
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
//         this.status,
//         this.usersSystemId,
//         this.usersSystemRolesId,
//         this.mobile,
//         this.city,
//         this.address,
//         this.userImage,
//         this.isDeleted,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt});
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
//     usersSystemId = json['users_system_id'];
//     usersSystemRolesId = json['users_system_roles_id'];
//     mobile = json['mobile'];
//     city = json['city'];
//     address = json['address'];
//     userImage = json['user_image'];
//     isDeleted = json['is_deleted'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
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
//     data['users_system_id'] = this.usersSystemId;
//     data['users_system_roles_id'] = this.usersSystemRolesId;
//     data['mobile'] = this.mobile;
//     data['city'] = this.city;
//     data['address'] = this.address;
//     data['user_image'] = this.userImage;
//     data['is_deleted'] = this.isDeleted;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['deleted_at'] = this.deletedAt;
//     return data;
//   }
// }

import 'dart:convert';

GetLiveMessagesModel getLiveMessagesModelFromJson(String str) => GetLiveMessagesModel.fromJson(json.decode(str));

String getLiveMessagesModelToJson(GetLiveMessagesModel data) => json.encode(data.toJson());

class GetLiveMessagesModel {
  GetLiveMessagesModel({this.status, this.data,});

  String? status;
  List<Datum>? data;

  factory GetLiveMessagesModel.fromJson(Map<String, dynamic> json) => GetLiveMessagesModel(
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
    this.senderType,
     this.date,
     this.time,
     this.msgType,
     this.message,
     this.usersData,
  });

  String? senderType;
  String? date;
  String? time;
  String? msgType;
  String? message;
  UsersData? usersData;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    senderType: json["sender_type"],
    date: json["date"],
    time: json["time"],
    msgType: json["msgType"],
    message: json["message"],
    usersData: UsersData.fromJson(json["users_data"]),
  );

  Map<String, dynamic> toJson() => {
    "sender_type": senderType,
    "date": date,
    "time": time,
    "msgType": msgType,
    "message": message,
    "users_data": usersData!.toJson(),
  };
}

class UsersData {
  UsersData({
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
    this.usersSystemId,
    this.usersSystemRolesId,
    this.mobile,
    this.city,
    this.address,
    this.userImage,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
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
  int? usersSystemId;
  int? usersSystemRolesId;
  String? mobile;
  String? city;
  String? address;
  String? userImage;
  String? isDeleted;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  factory UsersData.fromJson(Map<String, dynamic> json) => UsersData(
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
    dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    verifyCode: json["verify_code"],
    notifications: json["notifications"],
    status: json["status"],
    usersSystemId: json["users_system_id"],
    usersSystemRolesId: json["users_system_roles_id"],
    mobile: json["mobile"],
    city: json["city"],
    address: json["address"],
    userImage: json["user_image"],
    isDeleted: json["is_deleted"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
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
    "date_added": dateAdded?.toIso8601String(),
    "verify_code": verifyCode,
    "notifications": notifications,
    "status": status,
    "users_system_id": usersSystemId,
    "users_system_roles_id": usersSystemRolesId,
    "mobile": mobile,
    "city": city,
    "address": address,
    "user_image": userImage,
    "is_deleted": isDeleted,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}
