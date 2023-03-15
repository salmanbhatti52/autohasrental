
import 'dart:convert';

LikeUnlikeCarModel likeUnlikeCarModelFromJson(String str) => LikeUnlikeCarModel.fromJson(json.decode(str));

String likeUnlikeFavoriteCarModelToJson(LikeUnlikeCarModel data) => json.encode(data.toJson());

class LikeUnlikeCarModel {
  LikeUnlikeCarModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory LikeUnlikeCarModel.fromJson(Map<String, dynamic> json) => LikeUnlikeCarModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
