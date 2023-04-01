import 'dart:convert';

SendLiveMessagesModel sendLiveMessagesModelFromJson(String str) => SendLiveMessagesModel.fromJson(json.decode(str));

String sendLiveMessagesModelToJson(SendLiveMessagesModel data) => json.encode(data.toJson());

class SendLiveMessagesModel {
  SendLiveMessagesModel({this.status, this.message,});

  String? status;
  String? message;

  factory SendLiveMessagesModel.fromJson(Map<String, dynamic> json) => SendLiveMessagesModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
