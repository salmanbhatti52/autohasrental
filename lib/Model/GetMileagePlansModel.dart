import 'dart:convert';

GetMileagePlansModel getMileagePlansModelFromJson(String str) => GetMileagePlansModel.fromJson(json.decode(str));

String getMileagePlansModelToJson(GetMileagePlansModel data) => json.encode(data.toJson());

class GetMileagePlansModel {
  String? status;
  List<Datum>? data;

  GetMileagePlansModel({
    this.status,
    this.data,
  });

  factory GetMileagePlansModel.fromJson(Map<String, dynamic> json) => GetMileagePlansModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? plansMileageId;
  String? plansMileageDescription;
  String? status;
  String? dateAdded;

  Datum({
    this.plansMileageId,
    this.plansMileageDescription,
    this.status,
    this.dateAdded,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    plansMileageId: json["plans_mileage_id"],
    plansMileageDescription: json["plans_mileage_description"],
    status: json["status"],
    dateAdded: json["date_added"],
  );

  Map<String, dynamic> toJson() => {
    "plans_mileage_id": plansMileageId,
    "plans_mileage_description": plansMileageDescription,
    "status": status,
    "date_added": dateAdded,
  };
}
