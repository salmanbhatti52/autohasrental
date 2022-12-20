
import 'dart:convert';

LikeUnlikeFavoriteCarModel likeUnlikeFavoriteCarModelFromJson(String str) => LikeUnlikeFavoriteCarModel.fromJson(json.decode(str));

String likeUnlikeFavoriteCarModelToJson(LikeUnlikeFavoriteCarModel data) => json.encode(data.toJson());

class LikeUnlikeFavoriteCarModel {
  LikeUnlikeFavoriteCarModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory LikeUnlikeFavoriteCarModel.fromJson(Map<String, dynamic> json) => LikeUnlikeFavoriteCarModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
