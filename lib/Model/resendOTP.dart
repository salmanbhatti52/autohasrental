import 'dart:convert';

ResendOtp resendOtpFromJson(String str) => ResendOtp.fromJson(json.decode(str));

String resendOtpToJson(ResendOtp data) => json.encode(data.toJson());

class ResendOtp {
  String? status;
  String? message;

  ResendOtp({
    this.status,
    this.message,
  });

  factory ResendOtp.fromJson(Map<String, dynamic> json) => ResendOtp(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
