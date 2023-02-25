
import 'dart:convert';

BookingCancelDialogModel bookingCancelDialogModelFromJson(String str) => BookingCancelDialogModel.fromJson(json.decode(str));

String bookingCancelDialogModelToJson(BookingCancelDialogModel data) => json.encode(data.toJson());

class BookingCancelDialogModel {
  BookingCancelDialogModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory BookingCancelDialogModel.fromJson(Map<String, dynamic> json) => BookingCancelDialogModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
