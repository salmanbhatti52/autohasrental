import 'dart:convert';

GetMonthPlansModel getMonthPlansModelFromJson(String str) => GetMonthPlansModel.fromJson(json.decode(str));

String getMonthPlansModelToJson(GetMonthPlansModel data) => json.encode(data.toJson());

class GetMonthPlansModel {
  String? status;
  List<Datum>? data;

  GetMonthPlansModel({
    this.status,
    this.data,
  });

  factory GetMonthPlansModel.fromJson(Map<String, dynamic> json) => GetMonthPlansModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? carsPlansEvId;
  int? carsId;
  int? plansMileageId;
  int? months;
  String? pricePerMonth;

  Datum({
    this.carsPlansEvId,
    this.carsId,
    this.plansMileageId,
    this.months,
    this.pricePerMonth,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    carsPlansEvId: json["cars_plans_ev_id"],
    carsId: json["cars_id"],
    plansMileageId: json["plans_mileage_id"],
    months: json["months"],
    pricePerMonth: json["price_per_month"],
  );

  Map<String, dynamic> toJson() => {
    "cars_plans_ev_id": carsPlansEvId,
    "cars_id": carsId,
    "plans_mileage_id": plansMileageId,
    "months": months,
    "price_per_month": pricePerMonth,
  };
}
