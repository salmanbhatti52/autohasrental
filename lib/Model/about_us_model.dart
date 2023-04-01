
import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
  AboutUsModel({
    this.status,
    this.data,
  });

  String? status;
  List<Datum>? data;

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
    status: json["status"],
    data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))): null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.systemSettingsId,
    this.type,
    this.description,
  });

  int? systemSettingsId;
  String? type;
  String? description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    systemSettingsId: json["system_settings_id"],
    type: json["type"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "system_settings_id": systemSettingsId,
    "type": type,
    "description": description,
  };
}
