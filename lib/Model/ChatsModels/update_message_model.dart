
class UpdateMessageModel {
  int? chatLength;
  List<UnreadMessages>? unreadMessages;

  UpdateMessageModel({this.chatLength, this.unreadMessages});

  UpdateMessageModel.fromJson(Map<String, dynamic> json) {
    chatLength = json['chat_length'];
    if (json['unread_messages'] != null) {
      unreadMessages = <UnreadMessages>[];
      json['unread_messages'].forEach((v) {
        unreadMessages!.add(UnreadMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_length'] = chatLength;
    if (unreadMessages != null) {
      data['unread_messages'] =
          unreadMessages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnreadMessages {
  int? chatMessageId;
  String? senderType;
  String? time;
  String? msgType;
  String? message;
  UsersData? usersData;

  UnreadMessages(
      {this.chatMessageId,
        this.senderType,
        this.time,
        this.msgType,
        this.message,
        this.usersData});

  UnreadMessages.fromJson(Map<String, dynamic> json) {
    chatMessageId = json['chat_message_id'];
    senderType = json['sender_type'];
    time = json['time'];
    msgType = json['msgType'];
    message = json['message'];
    usersData = json['users_data'] != null
        ? UsersData.fromJson(json['users_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_message_id'] = chatMessageId;
    data['sender_type'] = senderType;
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
  String? dateAdded;
  String? verifyCode;
  String? notifications;
  String? status;

  UsersData(
      {this.usersCustomersId,
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
        this.status});

  UsersData.fromJson(Map<String, dynamic> json) {
    usersCustomersId = json['users_customers_id'];
    oneSignalId = json['one_signal_id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['users_customers_id'] = usersCustomersId;
    data['one_signal_id'] = oneSignalId;
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
    return data;
  }
}