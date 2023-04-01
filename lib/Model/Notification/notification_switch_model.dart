import 'dart:convert';

NotificationsSwitchModel notificationsSwitchModelFromJson(String str) => NotificationsSwitchModel.fromJson(json.decode(str));

String notificationsSwitchModelToJson(NotificationsSwitchModel data) => json.encode(data.toJson());

class NotificationsSwitchModel {
  NotificationsSwitchModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory NotificationsSwitchModel.fromJson(Map<String, dynamic> json) => NotificationsSwitchModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
