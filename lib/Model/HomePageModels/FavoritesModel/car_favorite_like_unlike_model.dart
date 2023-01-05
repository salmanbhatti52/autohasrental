// To parse this JSON data, do
//
//     final carLikeUnlikeModel = carLikeUnlikeModelFromJson(jsonString);

import 'dart:convert';

CarLikeUnlikeModel carLikeUnlikeModelFromJson(String str) => CarLikeUnlikeModel.fromJson(json.decode(str));

String carLikeUnlikeModelToJson(CarLikeUnlikeModel data) => json.encode(data.toJson());

class CarLikeUnlikeModel {
  CarLikeUnlikeModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory CarLikeUnlikeModel.fromJson(Map<String, dynamic> json) => CarLikeUnlikeModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
