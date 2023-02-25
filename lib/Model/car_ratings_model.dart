import 'dart:convert';

RateCarModel rateCarModelFromJson(String str) => RateCarModel.fromJson(json.decode(str));

String rateCarModelToJson(RateCarModel data) => json.encode(data.toJson());

class RateCarModel {
  RateCarModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory RateCarModel.fromJson(Map<String, dynamic> json) => RateCarModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
