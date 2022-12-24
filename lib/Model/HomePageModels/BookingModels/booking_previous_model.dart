// To parse this JSON data, do
//
//     final previousBookingModel = previousBookingModelFromJson(jsonString);

import 'dart:convert';

PreviousBookingModel previousBookingModelFromJson(String str) => PreviousBookingModel.fromJson(json.decode(str));

String previousBookingModelToJson(PreviousBookingModel data) => json.encode(data.toJson());

class PreviousBookingModel {
  PreviousBookingModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory PreviousBookingModel.fromJson(Map<String, dynamic> json) => PreviousBookingModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
