//
// class AllChatsListModel {
//   int? senderId;
//   int? receiverId;
//   String? companyName;
//   String? companyLogo;
//   String? date;
//   String? lastMessage;
//
//   AllChatsListModel(
//       {this.senderId,
//         this.receiverId,
//         this.companyName,
//         this.companyLogo,
//         this.date,
//         this.lastMessage});
//
//   AllChatsListModel.fromJson(Map<String, dynamic> json) {
//     senderId = json['sender_id'];
//     receiverId = json['receiver_id'];
//     companyName = json['company_name'];
//     companyLogo = json['company_logo'];
//     date = json['date'];
//     lastMessage = json['last_message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['sender_id'] = this.senderId;
//     data['receiver_id'] = this.receiverId;
//     data['company_name'] = this.companyName;
//     data['company_logo'] = this.companyLogo;
//     data['date'] = this.date;
//     data['last_message'] = this.lastMessage;
//     return data;
//   }
// }

class AllChatsListModel {
  int? senderId;
  int? receiverId;
  String? companyName;
  String? companyLogo;
  String? date;
  String? lastMessage;

  AllChatsListModel(
      {this.senderId,
        this.receiverId,
        this.companyName,
        this.companyLogo,
        this.date,
        this.lastMessage});

  AllChatsListModel.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    companyName = json['company_name'];
    companyLogo = json['company_logo'];
    date = json['date'];
    lastMessage = json['last_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['company_name'] = this.companyName;
    data['company_logo'] = this.companyLogo;
    data['date'] = this.date;
    data['last_message'] = this.lastMessage;
    return data;
  }
}
