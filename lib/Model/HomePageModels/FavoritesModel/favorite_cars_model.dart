// To parse this JSON data, do
//
//     final favoriteCarModel = favoriteCarModelFromJson(jsonString);

import 'dart:convert';

FavoriteCarModel favoriteCarModelFromJson(String str) => FavoriteCarModel.fromJson(json.decode(str));

String favoriteCarModelToJson(FavoriteCarModel data) => json.encode(data.toJson());

class FavoriteCarModel {
  FavoriteCarModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory FavoriteCarModel.fromJson(Map<String, dynamic> json) => FavoriteCarModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
