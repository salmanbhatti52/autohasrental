import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/Chats/all_chats_model.dart';
import 'message_details_screen.dart';



// Widget allChatList() {
//   return ListView.builder(
//       shrinkWrap: true,
//       scrollDirection: Axis.vertical,
//       physics: const BouncingScrollPhysics(),
//       itemCount: messageItemsList.length,
//       itemBuilder: (BuildContext context, int index) {
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => const MessageDetailsScreen()));
//           },
//           child: Column(
//             children: [
//               ListTile(
//                 leading: Image.asset(messageItemsList[index].image),
//                 title: Text(
//                   messageItemsList[index].sendName,
//                   style: const TextStyle(
//                     fontSize: 15,
//                     fontFamily: 'Poppins-Medium',
//                   ),
//                   textAlign: TextAlign.left,
//                 ),
//                 subtitle: Text(
//                   messageItemsList[index].messageDescription,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     fontFamily: 'Poppins-Regular',
//                   ),
//                   textAlign: TextAlign.left,
//                 ),
//                 trailing: Text(
//                   messageItemsList[index].msgTime,
//                   style: const TextStyle(
//                     fontSize: 10,
//                     color: Color(0xffB1A8B9),
//                     fontFamily: 'Poppins-Regular',
//                   ),
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               const Divider(),
//             ],
//           ),
//         );
//       });
// }
//
// List messageItemsList = [
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Josh Gibson',
//     "Subject line comes here",
//     "10 min ago",
//   ),
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Miss Mindy Kub',
//     "Subject line comes here",
//     "Yesterday",
//   ),
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Roxanne Nitzsche',
//     "Subject line comes here",
//     "Yesterday",
//   ),
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Deanna Stamm',
//     "Subject line comes here",
//     "29 August 2022",
//   ),
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Nettie Dicki V',
//     "Subject line comes here",
//     "29 August 2022",
//   ),
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Eula Mitchell',
//     "Subject line comes here",
//     "29 August 2022",
//   ),
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Lorium',
//     "Subject line comes here",
//     "29 August 2022",
//   ),
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Josh Gibson',
//     "Subject line comes here",
//     "10 min ago",
//   ),
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Miss Mindy Kub',
//     "Subject line comes here",
//     "Yesterday",
//   ),
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Roxanne Nitzsche',
//     "Subject line comes here",
//     "29 August 2022",
//   ),
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Deanna Stamm',
//     "Subject line comes here",
//     "29 August 2022",
//   ),
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Nettie Dicki V',
//     "Subject line comes here",
//     "29 August 2022",
//   ),
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Eula Mitchell',
//     "Subject line comes here",
//     "29 August 2022",
//   ),
//   MessageItemList(
//     "assets/home_page/user.png",
//     'Lorium',
//     "Subject line comes here",
//     "29 August 2022",
//   ),
// ];
//
// class MessageItemList {
//   final String image;
//   final String sendName;
//   final String messageDescription;
//   final String msgTime;
//
//   MessageItemList(
//       this.image,
//       this.sendName,
//       this.messageDescription,
//       this.msgTime,
//       );
// }
