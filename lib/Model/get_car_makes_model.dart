import 'dart:convert';

GetCarMakesModel getCarMakesModelFromJson(String str) => GetCarMakesModel.fromJson(json.decode(str));

String getCarMakesModelToJson(GetCarMakesModel data) => json.encode(data.toJson());

class GetCarMakesModel {
  GetCarMakesModel({this.status, this.data});

  String? status;
  List<Datum>? data;

  factory GetCarMakesModel.fromJson(Map<String, dynamic> json) => GetCarMakesModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.carsMakesId,
    this.name,
    this.image,
    this.status,
  });

  int? carsMakesId;
  String? name;
  String? image;
  String? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    carsMakesId: json["cars_makes_id"],
    name: json["name"],
    image: json["image"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "cars_makes_id": carsMakesId,
    "name": name,
    "image": image,
    "status": status,
  };
}
