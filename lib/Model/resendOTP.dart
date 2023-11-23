import 'dart:convert';

ResendOtp resendOtpFromJson(String str) => ResendOtp.fromJson(json.decode(str));

String resendOtpToJson(ResendOtp data) => json.encode(data.toJson());

class ResendOtp {
  String? status;
  Data? data;

  ResendOtp({
    this.status,
    this.data,
  });

  factory ResendOtp.fromJson(Map<String, dynamic> json) => ResendOtp(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  String? email;
  int? verifyCode;

  Data({
    this.email,
    this.verifyCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"],
    verifyCode: json["verify_code"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "verify_code": verifyCode,
  };
}
