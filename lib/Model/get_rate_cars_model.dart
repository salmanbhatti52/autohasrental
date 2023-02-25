
import 'dart:convert';

GetStatusRateCarsModel getStatusRateCarsModelFromJson(String str) => GetStatusRateCarsModel.fromJson(json.decode(str));

String getStatusRateCarsModelToJson(GetStatusRateCarsModel data) => json.encode(data.toJson());

class GetStatusRateCarsModel {
  GetStatusRateCarsModel({this.status, this.message});

  String? status;
  String? message;

  factory GetStatusRateCarsModel.fromJson(Map<String, dynamic> json) => GetStatusRateCarsModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
